import 'package:supabase_flutter/supabase_flutter.dart';

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

  AuthService(this._supabase);

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
