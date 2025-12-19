import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myitihas/config/go_router_refresh.dart';
import 'package:myitihas/pages/Chat/Widget/chat_detail_page.dart';
import 'package:myitihas/pages/Chat/Widget/group_profile_page.dart';
import 'package:myitihas/pages/Chat/Widget/new_chat_page.dart';
import 'package:myitihas/pages/Chat/Widget/new_contact_page.dart';
import 'package:myitihas/pages/Chat/Widget/new_group_page.dart';
import 'package:myitihas/pages/Chat/Widget/profile_detail_page.dart';
import 'package:myitihas/pages/home_page.dart';
import 'package:myitihas/pages/login_page.dart';
import 'package:myitihas/pages/reset_password_page.dart';
import 'package:myitihas/pages/signup_page.dart';
import 'package:myitihas/pages/splash.dart';
import 'package:myitihas/services/supabase_service.dart';

part 'routes.g.dart';

// ============================================================================
// TypedGoRoute Definitions
// ============================================================================

/// Splash screen route - initial route that checks auth state
@TypedGoRoute<SplashRoute>(path: '/')
class SplashRoute extends GoRouteData {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashScreen();
  }
}

/// Home page route - main authenticated page
@TypedGoRoute<HomeRoute>(path: '/homepage')
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

/// Login page route
@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginPage();
  }
}

/// Signup page route
@TypedGoRoute<SignupRoute>(path: '/signup')
class SignupRoute extends GoRouteData {
  const SignupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignupPage();
  }
}

/// Password reset page route - only accessible during recovery flow
@TypedGoRoute<ResetPasswordRoute>(path: '/reset-password')
class ResetPasswordRoute extends GoRouteData {
  const ResetPasswordRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ResetPasswordPage();
  }
}

/// New chat page route
@TypedGoRoute<NewChatRoute>(path: '/new_chat')
class NewChatRoute extends GoRouteData {
  const NewChatRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NewChatPage();
  }
}

/// New group page route
@TypedGoRoute<NewGroupRoute>(path: '/new_group')
class NewGroupRoute extends GoRouteData {
  const NewGroupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NewGroupPage();
  }
}

/// New contact page route
@TypedGoRoute<NewContactRoute>(path: '/new_contact')
class NewContactRoute extends GoRouteData {
  const NewContactRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NewContactPage();
  }
}

/// Chat detail page route - requires parameters passed via $extra
@TypedGoRoute<ChatDetailRoute>(path: '/chat_detail')
class ChatDetailRoute extends GoRouteData {
  const ChatDetailRoute({required this.$extra});

  final Map<String, dynamic> $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ChatDetailPage(
      name: $extra['name'] ?? "User",
      avatarColor:
          $extra['color'] != null
              ? "0xFF${($extra['color'] as Color).value.toRadixString(16).substring(2)}"
              : "0xFF3B82F6",
      isGroup: $extra['isGroup'] ?? false,
    );
  }
}

/// Profile detail page route - requires name parameter via $extra
@TypedGoRoute<ProfileDetailRoute>(path: '/profile_detail')
class ProfileDetailRoute extends GoRouteData {
  const ProfileDetailRoute({required this.$extra});

  final Map<String, dynamic> $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProfileDetailPage(name: $extra['name'] ?? "User");
  }
}

/// Group profile page route - requires parameters via $extra
@TypedGoRoute<GroupProfileRoute>(path: '/group_profile')
class GroupProfileRoute extends GoRouteData {
  const GroupProfileRoute({required this.$extra});

  final Map<String, dynamic> $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return GroupProfilePage(
      name: $extra['name'] ?? "Group",
      avatarColor: $extra['color'] ?? "0xFF8B5CF6",
    );
  }
}

// ============================================================================
// MyItihasRouter - GoRouter Configuration
// ============================================================================

class MyItihasRouter {
  late final GoRouterRefreshStream _refreshStream;

  MyItihasRouter() {
    _refreshStream = GoRouterRefreshStream();
    // Register refresh stream so AuthService can access it for recovery state
    SupabaseService.setRefreshStream(_refreshStream);
  }

  GoRouter get router => GoRouter(
    initialLocation: '/',
    refreshListenable: _refreshStream,
    redirect: (context, state) {
      // CRITICAL: Check recovery state FIRST before any other routing logic
      // Recovery state has HIGHEST PRIORITY and overrides authentication state.
      //
      // Why recovery comes first:
      // - Supabase PKCE automatically creates a session when reset link is opened
      // - Without recovery flag, user would be treated as authenticated
      // - This would allow access to authenticated routes before password reset
      // - Recovery flag prevents this by forcing navigation to /reset-password
      final isRecovering = _refreshStream.isRecovering;
      final isOnResetPasswordPage = state.matchedLocation == '/reset-password';

      // If in recovery mode, FORCE redirect to reset password page
      // User CANNOT access any other route until password is reset
      if (isRecovering && !isOnResetPasswordPage) {
        print(
          '[Router] Recovery mode active - forcing redirect to /reset-password',
        );
        return '/reset-password';
      }

      // If NOT in recovery mode but on reset password page, redirect away
      // This prevents accessing reset page outside of recovery flow
      if (!isRecovering && isOnResetPasswordPage) {
        print(
          '[Router] Not in recovery mode - redirecting away from /reset-password',
        );
        return '/login';
      }

      // Normal authentication routing (only applies when NOT in recovery)
      final isAuthenticated = SupabaseService.getCurrentSession() != null;
      final isOnLoginPage = state.matchedLocation == '/login';
      final isOnSignupPage = state.matchedLocation == '/signup';
      final isOnSplash = state.matchedLocation == '/';

      // If user is authenticated and trying to access login/signup, redirect to home
      if (isAuthenticated && (isOnLoginPage || isOnSignupPage)) {
        return '/homepage';
      }

      // Allow splash screen to decide next route based on session
      // Splash screen will handle the redirect after checking session
      if (isOnSplash) {
        return null; // Allow splash to handle routing
      }

      // If user is not authenticated and trying to access protected routes, redirect to login
      if (!isAuthenticated && !isOnLoginPage && !isOnSignupPage) {
        return '/login';
      }

      return null; // No redirect needed
    },
    routes: $appRoutes,
  );
}
