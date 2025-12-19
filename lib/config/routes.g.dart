// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $splashRoute,
  $homeRoute,
  $loginRoute,
  $signupRoute,
  $resetPasswordRoute,
  $newChatRoute,
  $newGroupRoute,
  $newContactRoute,
  $chatDetailRoute,
  $profileDetailRoute,
  $groupProfileRoute,
];

RouteBase get $splashRoute =>
    GoRouteData.$route(path: '/', factory: $SplashRouteExtension._fromState);

extension $SplashRouteExtension on SplashRoute {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  String get location => GoRouteData.$location('/');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $homeRoute => GoRouteData.$route(
  path: '/homepage',

  factory: $HomeRouteExtension._fromState,
);

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location('/homepage');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute => GoRouteData.$route(
  path: '/login',

  factory: $LoginRouteExtension._fromState,
);

extension $LoginRouteExtension on LoginRoute {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  String get location => GoRouteData.$location('/login');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signupRoute => GoRouteData.$route(
  path: '/signup',

  factory: $SignupRouteExtension._fromState,
);

extension $SignupRouteExtension on SignupRoute {
  static SignupRoute _fromState(GoRouterState state) => const SignupRoute();

  String get location => GoRouteData.$location('/signup');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $resetPasswordRoute => GoRouteData.$route(
  path: '/reset-password',

  factory: $ResetPasswordRouteExtension._fromState,
);

extension $ResetPasswordRouteExtension on ResetPasswordRoute {
  static ResetPasswordRoute _fromState(GoRouterState state) =>
      const ResetPasswordRoute();

  String get location => GoRouteData.$location('/reset-password');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $newChatRoute => GoRouteData.$route(
  path: '/new_chat',

  factory: $NewChatRouteExtension._fromState,
);

extension $NewChatRouteExtension on NewChatRoute {
  static NewChatRoute _fromState(GoRouterState state) => const NewChatRoute();

  String get location => GoRouteData.$location('/new_chat');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $newGroupRoute => GoRouteData.$route(
  path: '/new_group',

  factory: $NewGroupRouteExtension._fromState,
);

extension $NewGroupRouteExtension on NewGroupRoute {
  static NewGroupRoute _fromState(GoRouterState state) => const NewGroupRoute();

  String get location => GoRouteData.$location('/new_group');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $newContactRoute => GoRouteData.$route(
  path: '/new_contact',

  factory: $NewContactRouteExtension._fromState,
);

extension $NewContactRouteExtension on NewContactRoute {
  static NewContactRoute _fromState(GoRouterState state) =>
      const NewContactRoute();

  String get location => GoRouteData.$location('/new_contact');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $chatDetailRoute => GoRouteData.$route(
  path: '/chat_detail',

  factory: $ChatDetailRouteExtension._fromState,
);

extension $ChatDetailRouteExtension on ChatDetailRoute {
  static ChatDetailRoute _fromState(GoRouterState state) =>
      ChatDetailRoute($extra: state.extra as Map<String, dynamic>);

  String get location => GoRouteData.$location('/chat_detail');

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $profileDetailRoute => GoRouteData.$route(
  path: '/profile_detail',

  factory: $ProfileDetailRouteExtension._fromState,
);

extension $ProfileDetailRouteExtension on ProfileDetailRoute {
  static ProfileDetailRoute _fromState(GoRouterState state) =>
      ProfileDetailRoute($extra: state.extra as Map<String, dynamic>);

  String get location => GoRouteData.$location('/profile_detail');

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $groupProfileRoute => GoRouteData.$route(
  path: '/group_profile',

  factory: $GroupProfileRouteExtension._fromState,
);

extension $GroupProfileRouteExtension on GroupProfileRoute {
  static GroupProfileRoute _fromState(GoRouterState state) =>
      GroupProfileRoute($extra: state.extra as Map<String, dynamic>);

  String get location => GoRouteData.$location('/group_profile');

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}
