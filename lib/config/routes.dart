import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myitihas/pages/Chat/Widget/chat_detail_page.dart';
import 'package:myitihas/pages/Chat/Widget/group_profile_page.dart';
import 'package:myitihas/pages/Chat/Widget/new_chat_page.dart';
import 'package:myitihas/pages/Chat/Widget/new_contact_page.dart';
import 'package:myitihas/pages/Chat/Widget/new_group_page.dart';
import 'package:myitihas/pages/Chat/Widget/profile_detail_page.dart';
import 'package:myitihas/pages/home_page.dart';
import 'package:myitihas/pages/login_page.dart';
import 'package:myitihas/pages/signup_page.dart';
import 'package:myitihas/pages/splash.dart';

class MyItihasRouter {
  GoRouter router = GoRouter(
    initialLocation: '/',
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
          return MaterialPage(
            key: state.pageKey,
            child: const SignupPage(),
          );
        },
      ),
      GoRoute(
        name: "login",
        path: '/login',
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const LoginPage(),
          );
        },
      ),
    ],
  );
}
