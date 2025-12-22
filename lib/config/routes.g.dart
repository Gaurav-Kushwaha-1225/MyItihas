// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $splashRoute,
  $homeRoute,
  $discoverRoute,
  $loginRoute,
  $signupRoute,
  $resetPasswordRoute,
  $newChatRoute,
  $newGroupRoute,
  $newContactRoute,
  $chatDetailRoute,
  $profileDetailRoute,
  $groupProfileRoute,
  $settingsRoute,
  $editProfileRoute,
  $socialFeedRoute,
  $profileRoute,
  $followersRoute,
  $followingRoute,
  $notificationRoute,
  $chatListRoute,
];

RouteBase get $splashRoute =>
    GoRouteData.$route(path: '/', factory: $SplashRoute._fromState);

mixin $SplashRoute on GoRouteData {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $homeRoute => GoRouteData.$route(
  path: '/home',
  factory: $HomeRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: 'stories',
      factory: $StoriesRoute._fromState,
      routes: [
        GoRouteData.$route(path: ':id', factory: $StoryDetailRoute._fromState),
      ],
    ),
    GoRouteData.$route(
      path: 'story-generator',
      factory: $StoryGeneratorRoute._fromState,
    ),
  ],
);

mixin $HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location('/home');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $StoriesRoute on GoRouteData {
  static StoriesRoute _fromState(GoRouterState state) => const StoriesRoute();

  @override
  String get location => GoRouteData.$location('/home/stories');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $StoryDetailRoute on GoRouteData {
  static StoryDetailRoute _fromState(GoRouterState state) =>
      StoryDetailRoute(id: state.pathParameters['id']!);

  StoryDetailRoute get _self => this as StoryDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/home/stories/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $StoryGeneratorRoute on GoRouteData {
  static StoryGeneratorRoute _fromState(GoRouterState state) =>
      const StoryGeneratorRoute();

  @override
  String get location => GoRouteData.$location('/home/story-generator');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $discoverRoute =>
    GoRouteData.$route(path: '/discover', factory: $DiscoverRoute._fromState);

mixin $DiscoverRoute on GoRouteData {
  static DiscoverRoute _fromState(GoRouterState state) => const DiscoverRoute();

  @override
  String get location => GoRouteData.$location('/discover');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute =>
    GoRouteData.$route(path: '/login', factory: $LoginRoute._fromState);

mixin $LoginRoute on GoRouteData {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  @override
  String get location => GoRouteData.$location('/login');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signupRoute =>
    GoRouteData.$route(path: '/signup', factory: $SignupRoute._fromState);

mixin $SignupRoute on GoRouteData {
  static SignupRoute _fromState(GoRouterState state) => const SignupRoute();

  @override
  String get location => GoRouteData.$location('/signup');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $resetPasswordRoute => GoRouteData.$route(
  path: '/reset-password',
  factory: $ResetPasswordRoute._fromState,
);

mixin $ResetPasswordRoute on GoRouteData {
  static ResetPasswordRoute _fromState(GoRouterState state) =>
      const ResetPasswordRoute();

  @override
  String get location => GoRouteData.$location('/reset-password');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $newChatRoute =>
    GoRouteData.$route(path: '/new-chat', factory: $NewChatRoute._fromState);

mixin $NewChatRoute on GoRouteData {
  static NewChatRoute _fromState(GoRouterState state) => const NewChatRoute();

  @override
  String get location => GoRouteData.$location('/new-chat');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $newGroupRoute =>
    GoRouteData.$route(path: '/new-group', factory: $NewGroupRoute._fromState);

mixin $NewGroupRoute on GoRouteData {
  static NewGroupRoute _fromState(GoRouterState state) => const NewGroupRoute();

  @override
  String get location => GoRouteData.$location('/new-group');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $newContactRoute => GoRouteData.$route(
  path: '/new-contact',
  factory: $NewContactRoute._fromState,
);

mixin $NewContactRoute on GoRouteData {
  static NewContactRoute _fromState(GoRouterState state) =>
      const NewContactRoute();

  @override
  String get location => GoRouteData.$location('/new-contact');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $chatDetailRoute => GoRouteData.$route(
  path: '/chat_detail',
  factory: $ChatDetailRoute._fromState,
);

mixin $ChatDetailRoute on GoRouteData {
  static ChatDetailRoute _fromState(GoRouterState state) =>
      ChatDetailRoute($extra: state.extra as Map<String, dynamic>);

  ChatDetailRoute get _self => this as ChatDetailRoute;

  @override
  String get location => GoRouteData.$location('/chat_detail');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $profileDetailRoute => GoRouteData.$route(
  path: '/profile_detail',
  factory: $ProfileDetailRoute._fromState,
);

mixin $ProfileDetailRoute on GoRouteData {
  static ProfileDetailRoute _fromState(GoRouterState state) =>
      ProfileDetailRoute($extra: state.extra as Map<String, dynamic>);

  ProfileDetailRoute get _self => this as ProfileDetailRoute;

  @override
  String get location => GoRouteData.$location('/profile_detail');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $groupProfileRoute => GoRouteData.$route(
  path: '/group_profile',
  factory: $GroupProfileRoute._fromState,
);

mixin $GroupProfileRoute on GoRouteData {
  static GroupProfileRoute _fromState(GoRouterState state) =>
      GroupProfileRoute($extra: state.extra as Map<String, dynamic>);

  GroupProfileRoute get _self => this as GroupProfileRoute;

  @override
  String get location => GoRouteData.$location('/group_profile');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $settingsRoute =>
    GoRouteData.$route(path: '/settings', factory: $SettingsRoute._fromState);

mixin $SettingsRoute on GoRouteData {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $editProfileRoute => GoRouteData.$route(
  path: '/edit-profile/:userId',
  factory: $EditProfileRoute._fromState,
);

mixin $EditProfileRoute on GoRouteData {
  static EditProfileRoute _fromState(GoRouterState state) => EditProfileRoute(
    userId: state.pathParameters['userId']!,
    displayName: state.uri.queryParameters['display-name']!,
    bio: state.uri.queryParameters['bio'] ?? '',
    avatarUrl: state.uri.queryParameters['avatar-url'] ?? '',
  );

  EditProfileRoute get _self => this as EditProfileRoute;

  @override
  String get location => GoRouteData.$location(
    '/edit-profile/${Uri.encodeComponent(_self.userId)}',
    queryParams: {
      'display-name': _self.displayName,
      if (_self.bio != '') 'bio': _self.bio,
      if (_self.avatarUrl != '') 'avatar-url': _self.avatarUrl,
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $socialFeedRoute => GoRouteData.$route(
  path: '/social-feed',
  factory: $SocialFeedRoute._fromState,
);

mixin $SocialFeedRoute on GoRouteData {
  static SocialFeedRoute _fromState(GoRouterState state) =>
      const SocialFeedRoute();

  @override
  String get location => GoRouteData.$location('/social-feed');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $profileRoute => GoRouteData.$route(
  path: '/profile/:userId',
  factory: $ProfileRoute._fromState,
);

mixin $ProfileRoute on GoRouteData {
  static ProfileRoute _fromState(GoRouterState state) =>
      ProfileRoute(userId: state.pathParameters['userId']!);

  ProfileRoute get _self => this as ProfileRoute;

  @override
  String get location =>
      GoRouteData.$location('/profile/${Uri.encodeComponent(_self.userId)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $followersRoute => GoRouteData.$route(
  path: '/followers/:userId',
  factory: $FollowersRoute._fromState,
);

mixin $FollowersRoute on GoRouteData {
  static FollowersRoute _fromState(GoRouterState state) =>
      FollowersRoute(userId: state.pathParameters['userId']!);

  FollowersRoute get _self => this as FollowersRoute;

  @override
  String get location =>
      GoRouteData.$location('/followers/${Uri.encodeComponent(_self.userId)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $followingRoute => GoRouteData.$route(
  path: '/following/:userId',
  factory: $FollowingRoute._fromState,
);

mixin $FollowingRoute on GoRouteData {
  static FollowingRoute _fromState(GoRouterState state) =>
      FollowingRoute(userId: state.pathParameters['userId']!);

  FollowingRoute get _self => this as FollowingRoute;

  @override
  String get location =>
      GoRouteData.$location('/following/${Uri.encodeComponent(_self.userId)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $notificationRoute => GoRouteData.$route(
  path: '/notifications',
  factory: $NotificationRoute._fromState,
);

mixin $NotificationRoute on GoRouteData {
  static NotificationRoute _fromState(GoRouterState state) =>
      const NotificationRoute();

  @override
  String get location => GoRouteData.$location('/notifications');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $chatListRoute => GoRouteData.$route(
  path: '/chat',
  factory: $ChatListRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: ':conversationId',
      factory: $ChatViewRoute._fromState,
    ),
  ],
);

mixin $ChatListRoute on GoRouteData {
  static ChatListRoute _fromState(GoRouterState state) => const ChatListRoute();

  @override
  String get location => GoRouteData.$location('/chat');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ChatViewRoute on GoRouteData {
  static ChatViewRoute _fromState(GoRouterState state) =>
      ChatViewRoute(conversationId: state.pathParameters['conversationId']!);

  ChatViewRoute get _self => this as ChatViewRoute;

  @override
  String get location => GoRouteData.$location(
    '/chat/${Uri.encodeComponent(_self.conversationId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
