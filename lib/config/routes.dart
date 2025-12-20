import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myitihas/pages/Map/akhanda_bharat_map_page.dart';
import 'package:myitihas/pages/home_page.dart';
import 'package:myitihas/pages/splash.dart';
import 'package:myitihas/pages/stories_page.dart';
import 'package:myitihas/pages/story_generator.dart';
import 'package:myitihas/features/social/presentation/pages/social_feed_page.dart';
import 'package:myitihas/features/social/presentation/pages/profile_page.dart';
import 'package:myitihas/features/social/presentation/pages/notification_page.dart';
import 'package:myitihas/features/chat/presentation/pages/chat_list_page.dart';
import 'package:myitihas/features/chat/presentation/pages/chat_view_page.dart';
import 'package:myitihas/features/stories/presentation/pages/story_detail_route_page.dart';

part 'routes.g.dart';

@TypedGoRoute<SplashRoute>(path: '/')
class SplashRoute extends GoRouteData with $SplashRoute {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashScreen();
  }
}

@TypedGoRoute<HomeRoute>(
  path: '/home',
  routes: [
    TypedGoRoute<StoriesRoute>(
      path: 'stories',
      routes: [TypedGoRoute<StoryDetailRoute>(path: ':id')],
    ),
    TypedGoRoute<StoryGeneratorRoute>(path: 'story-generator'),
  ],
)
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

class StoriesRoute extends GoRouteData with $StoriesRoute {
  const StoriesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const StoriesPage();
  }
}

class StoryDetailRoute extends GoRouteData with $StoryDetailRoute {
  final String id;

  const StoryDetailRoute({required this.id});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return StoryDetailRoutePage(id: id);
  }
}

class StoryGeneratorRoute extends GoRouteData with $StoryGeneratorRoute {
  const StoryGeneratorRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const StoryGeneratorPage();
  }
}

@TypedGoRoute<SocialFeedRoute>(path: '/social-feed')
class SocialFeedRoute extends GoRouteData with $SocialFeedRoute {
  const SocialFeedRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SocialFeedPage();
  }
}

@TypedGoRoute<ProfileRoute>(path: '/profile/:userId')
class ProfileRoute extends GoRouteData with $ProfileRoute {
  final String userId;

  const ProfileRoute({required this.userId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProfilePage(userId: userId);
  }
}

@TypedGoRoute<NotificationRoute>(path: '/notifications')
class NotificationRoute extends GoRouteData with $NotificationRoute {
  const NotificationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NotificationPage();
  }
}

@TypedGoRoute<ChatListRoute>(
  path: '/chat',
  routes: [TypedGoRoute<ChatViewRoute>(path: ':conversationId')],
)
class ChatListRoute extends GoRouteData with $ChatListRoute {
  const ChatListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ChatListPage();
  }
}

class ChatViewRoute extends GoRouteData with $ChatViewRoute {
  final String conversationId;

  const ChatViewRoute({required this.conversationId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ChatViewPage(conversationId: conversationId);
  }
}

@TypedGoRoute<MapRoute>(path: '/map')
class MapRoute extends GoRouteData {
  const MapRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AkhandaBharatMapPage();
  }
}

class MyItihasRouter {
  GoRouter get router => GoRouter(initialLocation: '/', routes: $appRoutes);
}
