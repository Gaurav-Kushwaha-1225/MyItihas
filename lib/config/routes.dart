import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myitihas/pages/home_page.dart';
import 'package:myitihas/pages/splash.dart';

class MyItihasRouter {
  GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
          name: "splash",
          path: '/',
          pageBuilder: (context, state) {
            return MaterialPage(
                key: state.pageKey, child: const SplashScreen());
          }),
      GoRoute(
          name: "homepage",
          path: '/homepage',
          pageBuilder: (context, state) {
            return MaterialPage(
                key: state.pageKey, child: const HomePage());
          }),
    ],
  );
}