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
    routes: [
      GoRoute(
        name: "splash",
        path: '/',
        pageBuilder: (context, state) {
          return MaterialPage(key: state.pageKey, child: const SplashScreen());
        },
      ),
      GoRoute(
        name: "homepage",
        path: '/homepage',
        pageBuilder: (context, state) {
          return MaterialPage(key: state.pageKey, child: const HomePage());
        },
      ),
      GoRoute(
        name: "new_chat",
        path: '/new_chat',
        pageBuilder: (context, state) {
          return MaterialPage(key: state.pageKey, child: const NewChatPage());
        },
      ),
      GoRoute(
        name: "new_group",
        path: '/new_group',
        pageBuilder: (context, state) {
          return MaterialPage(key: state.pageKey, child: const NewGroupPage());
        },
      ),
      GoRoute(
        name: "chat_detail",
        path: '/chat_detail',
        pageBuilder: (context, state) {
          final Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return MaterialPage(
            key: state.pageKey,
            child: ChatDetailPage(
              name: args['name'] ?? "User",
              avatarColor:
                  args['color'] != null
                      ? "0xFF${(args['color'] as Color).value.toRadixString(16).substring(2)}"
                      : "0xFF3B82F6",
              isGroup: args['isGroup'] ?? false, // Check if it is a group
            ),
          );
        },
      ),
      GoRoute(
        name: "profile_detail",
        path: '/profile_detail',
        pageBuilder: (context, state) {
          final Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return MaterialPage(
            key: state.pageKey,
            child: ProfileDetailPage(name: args['name'] ?? "User"),
          );
        },
      ),
      GoRoute(
        name: "new_contact",
        path: '/new_contact',
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const NewContactPage(),
          );
        },
      ),
      GoRoute(
        name: "group_profile",
        path: '/group_profile',
        pageBuilder: (context, state) {
          final Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return MaterialPage(
            key: state.pageKey,
            child: GroupProfilePage(
              name: args['name'] ?? "Group",
              avatarColor: args['color'] ?? "0xFF8B5CF6",
            ),
          );
        },
      ),
      GoRoute(
        name: "signup",
        path: '/signup',
        pageBuilder: (context, state) {
          return MaterialPage(key: state.pageKey, child: const SignupPage());
        },
      ),
      GoRoute(
        name: "login",
        path: '/login',
        pageBuilder: (context, state) {
          return MaterialPage(key: state.pageKey, child: const LoginPage());
        },
      ),
      GoRoute(
        name: "reset_password",
        path: '/reset-password',
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const ResetPasswordPage(),
          );
        },
      ),
    ],
  );
}
