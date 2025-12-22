import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_links/app_links.dart';
import 'supabase_service.dart';

/// Custom authentication exception class for user-friendly error messages
/// Note: Renamed to avoid conflict with Supabase's AuthException
class AuthServiceException implements Exception {
  final String message;

  AuthServiceException(this.message);

  @override
  String toString() => message;
}

/// Backend service for authentication and user management
/// Uses Supabase Auth for user authentication
///
/// Schema in Supabase Auth users table:
/// - uid (uuid, primary key, auto-generated)
/// - email (text, unique)
/// - display_name (text, from metadata)
/// - phone (text, nullable - not used for email provider)
/// - providers (text array - 'email' for email signup)
/// - created_at (timestamp)
/// - last_signed_in (timestamp)
class AuthService {
  final SupabaseClient _supabase;
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;

  AuthService(this._supabase);

  /// Start listening for deep links (both cold start and warm start)
  ///
  /// This method should be called once during app initialization in main.dart
  /// after Supabase has been initialized.
  ///
  /// Example usage in main.dart:
  /// ```dart
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   await Supabase.initialize(...);
  ///   SupabaseService.authService.startDeepLinkListener();
  ///   runApp(MyApp());
  /// }
  /// ```
  ///
  /// Handles two scenarios:
  /// 1. Cold start: App was not running when deep link was opened
  /// 2. Warm start: App was in background when deep link was opened
  ///
  /// For password reset deep links (myitihas://reset-password#access_token=...),
  /// this method:
  /// - Parses the URI fragment for Supabase tokens
  /// - Logs the captured information for debugging
  /// - Does NOT create a session or navigate (handled by GoRouter)
  Future<void> startDeepLinkListener() async {
    try {
      // Handle cold start: Check if app was launched with a deep link
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        print('[Deep Link] Cold start with URI: $initialUri');
        _handleDeepLink(initialUri);
      }

      // Handle warm start: Listen for deep links while app is running
      _linkSubscription = _appLinks.uriLinkStream.listen(
        (uri) {
          print('[Deep Link] Warm start with URI: $uri');
          _handleDeepLink(uri);
        },
        onError: (err) {
          print('[Deep Link] Error: $err');
        },
      );
    } catch (e) {
      print('[Deep Link] Failed to initialize deep link listener: $e');
    }
  }

  /// Handle incoming deep link URI
  ///
  /// Detects password reset deep links and sets recovery state.
  /// Format: myitihas://reset-password?code=...
  ///
  /// IMPORTANT: Supabase PKCE automatically creates and persists a session when
  /// the reset link is opened. We MUST set recovery flag to prevent this session
  /// from being treated as a normal authenticated session.
  ///
  /// DO NOT navigate here - GoRouter will handle navigation based on recovery state.
  void _handleDeepLink(Uri uri) {
    print('[Deep Link] Received URI: $uri');
    print('[Deep Link] Scheme: ${uri.scheme}');
    print('[Deep Link] Host: ${uri.host}');
    print('[Deep Link] Path: ${uri.path}');
    print('[Deep Link] Query: ${uri.query}');
    print('[Deep Link] Fragment: ${uri.fragment}');

    // Check if this is a password reset deep link
    // Password reset links have host == "reset-password"
    if (uri.scheme == 'myitihas' && uri.host == 'reset-password') {
      print('[Deep Link] Password reset deep link detected');

      // CRITICAL: Set recovery flag IMMEDIATELY
      // This prevents the auto-created Supabase session from being treated
      // as a normal login. GoRouter will see isRecovering=true and redirect
      // to /reset-password page, preventing access to authenticated routes.
      final refreshStream = SupabaseService.refreshStream;
      if (refreshStream != null) {
        refreshStream.setRecovering();
        print(
          '[Deep Link] Recovery state activated - user will be forced to /reset-password',
        );
      } else {
        print(
          '[Deep Link] WARNING: RefreshStream not available, recovery state not set',
        );
      }
    } else {
      print('[Deep Link] Not a password reset deep link, ignoring');
    }
  }

  /// Clean up deep link listener
  ///
  /// Should be called when the AuthService is disposed (typically never in practice
  /// since AuthService is a singleton that lives for the app lifetime)
  void dispose() {
    _linkSubscription?.cancel();
  }

  /// Update user password during password recovery flow
  ///
  /// IMPORTANT: This method is ONLY for password recovery flow, not for
  /// changing password while logged in.
  ///
  /// Password Recovery Flow:
  /// 1. User clicks reset link → Supabase PKCE creates recovery session
  /// 2. Deep link sets isRecovering=true → GoRouter redirects to /reset-password
  /// 3. User enters new password → This method is called
  /// 4. Update password → Sign out recovery session → Clear recovery state
  /// 5. GoRouter redirects to /login
  ///
  /// Why we sign out after password update:
  /// - The recovery session was created only for password reset
  /// - User should NOT remain logged in with the recovery session
  /// - User must sign in again with their new password to create a proper session
  /// - This ensures clean state and proper authentication flow
  ///
  /// Throws AuthServiceException with user-friendly error messages on failure
  Future<void> updatePassword(String newPassword) async {
    try {
      // Validate password
      if (newPassword.trim().isEmpty) {
        throw AuthServiceException('Password cannot be empty');
      }

      if (newPassword.length < 6) {
        throw AuthServiceException(
          'Password must be at least 6 characters long',
        );
      }

      print('[Password Update] Updating password...');

      // Update password using Supabase
      // This works because we're in a recovery session created by PKCE
      await _supabase.auth.updateUser(UserAttributes(password: newPassword));

      print('[Password Update] Password updated successfully');

      // CRITICAL: Sign out the recovery session
      // We MUST terminate the recovery session to prevent:
      // 1. User staying logged in with recovery session
      // 2. Recovery session persisting across app restarts
      // 3. User accessing authenticated routes without proper login
      print('[Password Update] Signing out recovery session...');
      await _supabase.auth.signOut();
      print('[Password Update] Recovery session signed out');

      // CRITICAL: Clear recovery state
      // This allows GoRouter to resume normal authentication routing
      // User will be redirected to /login page
      final refreshStream = SupabaseService.refreshStream;
      if (refreshStream != null) {
        refreshStream.clearRecovery();
        print('[Password Update] Recovery state cleared - routing to login');
      } else {
        print('[Password Update] WARNING: RefreshStream not available');
      }
    } on AuthServiceException {
      // Re-throw our custom exceptions
      rethrow;
    } catch (e) {
      print('[Password Update] Error: $e');

      String errorString = e.toString();

      // Try to extract more specific error message
      try {
        final dynamic error = e;
        if (error.message != null && error.message is String) {
          errorString = error.message as String;
        }
      } catch (_) {
        // Ignore if we can't extract message
      }

      final lowerError = errorString.toLowerCase();

      // Handle specific errors
      if (lowerError.contains('network') ||
          lowerError.contains('connection') ||
          lowerError.contains('timeout')) {
        throw AuthServiceException(
          'Network error. Please check your connection and try again.',
        );
      }

      if (lowerError.contains('invalid') ||
          lowerError.contains('expired') ||
          lowerError.contains('token')) {
        throw AuthServiceException(
          'Password reset link has expired. Please request a new one.',
        );
      }

      if (lowerError.contains('weak') || lowerError.contains('password')) {
        throw AuthServiceException(
          'Password does not meet requirements. Please use a stronger password.',
        );
      }

      throw AuthServiceException(
        'Failed to update password. Please try again.',
      );
    }
  }

  /// Sign up a new user using Supabase Auth
  ///
  /// Parameters:
  /// - email: User's email address
  /// - password: User's password (will be hashed by Supabase)
  /// - fullName: User's full name (stored in user_metadata as display_name)
  ///
  /// Returns AuthResponse with user session on success
  /// Throws AuthServiceException with user-friendly error messages on failure
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      // Validate inputs
      if (email.trim().isEmpty) {
        throw AuthServiceException('Email cannot be empty');
      }
      if (password.trim().isEmpty) {
        throw AuthServiceException('Password cannot be empty');
      }
      if (fullName.trim().isEmpty) {
        throw AuthServiceException('Full name cannot be empty');
      }

      // Email format validation
      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
      if (!emailRegex.hasMatch(email.trim())) {
        throw AuthServiceException('Please enter a valid email address');
      }

      // Password strength validation
      if (password.length < 6) {
        throw AuthServiceException(
          'Password must be at least 6 characters long',
        );
      }

      // Sign up using Supabase Auth
      // The display_name will be stored in user_metadata and accessible as user.userMetadata?['display_name']
      final response = await _supabase.auth.signUp(
        email: email.trim().toLowerCase(),
        password: password,
        data: {'display_name': fullName.trim(), 'full_name': fullName.trim()},
      );

      // Check if signup was successful
      if (response.user == null) {
        throw AuthServiceException(
          'Failed to create account. Please try again.',
        );
      }

      // Insert user into public.users table
      // UUID is automatically taken from auth.users.id (Supabase generates it)
      try {
        final userId = response.user!.id;
        final username = _generateUsername(email, fullName);
        
        await _supabase.from('users').insert({
          'id': userId, // Same UUID as auth.users.id
          'email': email.trim().toLowerCase(),
          'full_name': fullName.trim(),
          'username': username,
          'avatar_url': 'https://api.dicebear.com/7.x/avataaars/svg?seed=$username',
          'bio': '',
          'is_online': true,
          'last_seen': DateTime.now().toIso8601String(),
        });
        
        print('[Signup] User added to public.users table with id: $userId');

        // Create corresponding profile after successful signup
        // This is done separately because profiles table has different RLS policies
        await createProfileAfterSignup(
          userId: userId,
          username: username,
          fullName: fullName.trim(),
        );
      } catch (e) {
        print('[Signup] Warning: Failed to add user to public.users table: $e');
        // Don't throw - auth user was created successfully
        // This can be handled later or retried
      }

      return response;
    } on AuthServiceException {
      // Re-throw our custom AuthServiceException as-is (already user-friendly)
      rethrow;
    } catch (e) {
      // Handle all other errors including Supabase exceptions
      // Supabase throws various exception types, so we catch all and convert to user-friendly messages
      String errorString = e.toString();

      // Try to extract a more specific error message if available
      try {
        final dynamic error = e;
        if (error.message != null && error.message is String) {
          errorString = error.message as String;
        }
      } catch (_) {
        // Ignore if we can't extract message
      }

      final errorMessage = _getErrorMessage(errorString);
      throw AuthServiceException(errorMessage);
    }
  }

  /// Sign in with email and password
  ///
  /// Parameters:
  /// - email: User's email address
  /// - password: User's password
  ///
  /// Returns AuthResponse with user session on success
  /// Throws AuthServiceException with user-friendly error messages on failure
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Validate inputs
      if (email.trim().isEmpty) {
        throw AuthServiceException('Email cannot be empty');
      }
      if (password.trim().isEmpty) {
        throw AuthServiceException('Password cannot be empty');
      }

      // Email format validation
      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
      if (!emailRegex.hasMatch(email.trim())) {
        throw AuthServiceException('Please enter a valid email address');
      }

      // Sign in using Supabase Auth
      final response = await _supabase.auth.signInWithPassword(
        email: email.trim().toLowerCase(),
        password: password,
      );

      // Check if sign in was successful
      if (response.user == null) {
        throw AuthServiceException('Failed to sign in. Please try again.');
      }

      return response;
    } on AuthServiceException {
      // Re-throw our custom AuthServiceException as-is (already user-friendly)
      rethrow;
    } catch (e) {
      // Handle all other errors including Supabase exceptions
      String errorString = e.toString();

      // Try to extract a more specific error message if available
      try {
        final dynamic error = e;
        if (error.message != null && error.message is String) {
          errorString = error.message as String;
        }
      } catch (_) {
        // Ignore if we can't extract message
      }

      final errorMessage = _getSignInErrorMessage(errorString);
      throw AuthServiceException(errorMessage);
    }
  }

  /// Get current authenticated user
  /// Returns User if authenticated, null otherwise
  User? getCurrentUser() {
    return _supabase.auth.currentUser;
  }

  /// Check if user is currently authenticated
  bool isAuthenticated() {
    return _supabase.auth.currentUser != null;
  }

  /// Sign out the current user
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw AuthServiceException('Failed to sign out. Please try again.');
    }
  }

  /// Sign in with Google OAuth
  ///
  /// Initiates Google OAuth flow in a web view/browser
  /// The actual authentication happens via redirect callback
  /// OAuth completion is handled via Supabase auth state changes (onAuthStateChange)
  /// and GoRouter redirect logic - do NOT handle success/failure here
  Future<void> signInWithGoogle() async {
    // Initiate OAuth flow - opens browser for Google authentication
    // After user authenticates, they're redirected back via myitihas://login-callback
    // Supabase handles the session creation automatically
    await _supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'myitihas://login-callback',
      authScreenLaunchMode: LaunchMode.externalApplication,
    );
  }

  /// Send password reset email
  ///
  /// Sends a password reset email to the specified address
  /// User will receive an email with a link to reset their password
  ///
  /// Throws AuthServiceException with user-friendly error messages on failure
  Future<void> resetPasswordForEmail(String email) async {
    try {
      // Validate email input
      if (email.trim().isEmpty) {
        throw AuthServiceException('Please enter your email address');
      }

      // Email format validation
      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
      if (!emailRegex.hasMatch(email.trim())) {
        throw AuthServiceException('Please enter a valid email address');
      }

      // Send password reset email
      await _supabase.auth.resetPasswordForEmail(
        email.trim().toLowerCase(),
        redirectTo: 'myitihas://reset-password',
      );
    } on AuthServiceException {
      rethrow;
    } catch (e) {
      String errorString = e.toString();

      try {
        final dynamic error = e;
        if (error.message != null && error.message is String) {
          errorString = error.message as String;
        }
      } catch (_) {
        // Ignore if we can't extract message
      }

      final lowerError = errorString.toLowerCase();

      if (lowerError.contains('network') ||
          lowerError.contains('connection') ||
          lowerError.contains('timeout')) {
        throw AuthServiceException(
          'Network error. Please check your connection and try again.',
        );
      }

      if (lowerError.contains('rate limit') ||
          lowerError.contains('too many requests')) {
        throw AuthServiceException(
          'Too many requests. Please wait a moment and try again.',
        );
      }

      throw AuthServiceException(
        'Failed to send password reset email. Please try again.',
      );
    }
  }

  /// Create a profile record after successful signup
  ///
  /// This method is called after Supabase auth.signUp() succeeds to create
  /// a corresponding row in the profiles table. This is done separately because:
  /// - Auth user creation and profile creation have different failure modes
  /// - Profiles table may have stricter validation or RLS policies
  /// - Allows retry logic if profile creation fails without re-creating auth user
  ///
  /// Parameters:
  /// - userId: UUID from authenticated user (auth.uid())
  /// - username: Generated or provided unique username
  /// - fullName: User's full display name
  ///
  /// Throws AuthServiceException if profile creation fails
  Future<void> createProfileAfterSignup({
    required String userId,
    required String username,
    required String fullName,
  }) async {
    try {
      // Verify we have an authenticated user
      final currentUser = _supabase.auth.currentUser;
      if (currentUser == null || currentUser.id != userId) {
        throw AuthServiceException(
          'Cannot create profile: user not authenticated',
        );
      }

      print('[Profile Creation] Creating profile for user: $userId');

      // Insert into profiles table
      // RLS policy ensures auth.uid() = id, so this will only work for the authenticated user
      await _supabase.from('profiles').insert({
        'id': userId, // Must match auth.uid() for RLS
        'username': username,
        'full_name': fullName,
        'avatar_url': null, // Nullable - can be set later
        'bio': null, // Nullable - can be set later
        'is_private': false, // Default value
      });

      print('[Profile Creation] Profile created successfully for user: $userId');
    } on PostgrestException catch (e) {
      print('[Profile Creation] Postgres error: ${e.message}');

      // Handle duplicate username error specifically
      if (e.code == '23505' && e.message.toLowerCase().contains('username')) {
        throw AuthServiceException(
          'Username already taken. Please try again.',
        );
      }

      // Handle other database errors
      throw AuthServiceException(
        'Failed to create user profile. Please contact support.',
      );
    } catch (e) {
      print('[Profile Creation] Error: $e');

      // Don't rethrow AuthServiceException - already handled above
      if (e is AuthServiceException) {
        rethrow;
      }

      // Generic error
      throw AuthServiceException(
        'Failed to create user profile. Please try again.',
      );
    }
  }

  /// Convert error messages to user-friendly format
  String _getErrorMessage(String error) {
    final lowerError = error.toLowerCase();

    // Handle Supabase Auth specific errors
    if (lowerError.contains('user already registered') ||
        lowerError.contains('email already exists') ||
        lowerError.contains('already registered') ||
        lowerError.contains('email address is already registered') ||
        lowerError.contains('user with this email already exists')) {
      return 'This email is already registered. Please use a different email or sign in.';
    }

    if (lowerError.contains('invalid email') ||
        lowerError.contains('email format is invalid') ||
        lowerError.contains('valid email')) {
      return 'Please enter a valid email address.';
    }

    if ((lowerError.contains('password') && lowerError.contains('weak')) ||
        lowerError.contains('password is too weak') ||
        lowerError.contains('password does not meet requirements')) {
      return 'Password is too weak. Please use a stronger password (at least 6 characters).';
    }

    if (lowerError.contains('network') ||
        lowerError.contains('connection') ||
        lowerError.contains('timeout') ||
        lowerError.contains('socketexception') ||
        lowerError.contains('failed host lookup')) {
      return 'Network error. Please check your internet connection and try again.';
    }

    if (lowerError.contains('rate limit') ||
        lowerError.contains('too many requests') ||
        lowerError.contains('429')) {
      return 'Too many requests. Please wait a moment and try again.';
    }

    if (lowerError.contains('signup_disabled') ||
        lowerError.contains('signup is disabled')) {
      return 'Account creation is temporarily disabled. Please contact support.';
    }

    if (lowerError.contains('invalid credentials') ||
        lowerError.contains('authentication failed')) {
      return 'Authentication failed. Please check your credentials and try again.';
    }

    // Generic error message
    return 'Failed to create account. Please check your information and try again.';
  }

  /// Generate a unique username from email or full name
  String _generateUsername(String email, String fullName) {
    // Try to use part before @ in email
    String username = email.split('@')[0];
    
    // Remove special characters and make lowercase
    username = username.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_').toLowerCase();
    
    // Add random suffix to ensure uniqueness
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString().substring(8);
    username = '${username}_$timestamp';
    
    return username;
  }

  /// Convert sign-in error messages to user-friendly format
  String _getSignInErrorMessage(String error) {
    final lowerError = error.toLowerCase();

    // Handle Supabase Auth specific errors for sign in
    if (lowerError.contains('invalid login credentials') ||
        lowerError.contains('invalid credentials') ||
        lowerError.contains('wrong password') ||
        lowerError.contains('incorrect password') ||
        lowerError.contains('email not confirmed')) {
      return 'Invalid email or password. Please check your credentials and try again.';
    }

    if (lowerError.contains('user not found') ||
        lowerError.contains('email not found')) {
      return 'No account found with this email. Please sign up first.';
    }

    if (lowerError.contains('invalid email') ||
        lowerError.contains('email format is invalid') ||
        lowerError.contains('valid email')) {
      return 'Please enter a valid email address.';
    }

    if (lowerError.contains('network') ||
        lowerError.contains('connection') ||
        lowerError.contains('timeout') ||
        lowerError.contains('socketexception') ||
        lowerError.contains('failed host lookup')) {
      return 'Network error. Please check your internet connection and try again.';
    }

    if (lowerError.contains('rate limit') ||
        lowerError.contains('too many requests') ||
        lowerError.contains('429')) {
      return 'Too many requests. Please wait a moment and try again.';
    }

    if (lowerError.contains('email not confirmed') ||
        lowerError.contains('verify your email')) {
      return 'Please verify your email address before signing in.';
    }

    // Generic error message
    return 'Failed to sign in. Please check your credentials and try again.';
  }
}
