import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myitihas/pages/Map/Widget/shaktipeetha_detail_page.dart';

import 'package:myitihas/pages/Map/akhanda_bharat_map_page.dart';
import 'package:myitihas/pages/home_page.dart';
import 'package:myitihas/pages/discover_page.dart';
import 'package:myitihas/pages/splash.dart';
import 'package:myitihas/pages/auth/login_page.dart';
import 'package:myitihas/pages/auth/signup_page.dart';
import 'package:myitihas/pages/auth/reset_password_page.dart';

import 'package:myitihas/pages/Chat/Widget/chat_detail_page.dart';
import 'package:myitihas/pages/Chat/Widget/group_profile_page.dart';
import 'package:myitihas/pages/Chat/Widget/new_chat_page.dart';
import 'package:myitihas/pages/Chat/Widget/new_contact_page.dart';
import 'package:myitihas/pages/Chat/Widget/new_group_page.dart';
import 'package:myitihas/pages/Chat/Widget/profile_detail_page.dart';

import 'package:myitihas/pages/stories_page.dart';
import 'package:myitihas/pages/settings_page.dart';
import 'package:myitihas/features/social/presentation/pages/social_feed_page.dart';
import 'package:myitihas/features/social/presentation/pages/profile_page.dart';
import 'package:myitihas/features/social/presentation/pages/edit_profile_page.dart';
import 'package:myitihas/features/social/presentation/pages/notification_page.dart';
import 'package:myitihas/features/social/presentation/pages/followers_page.dart';
import 'package:myitihas/features/social/presentation/pages/following_page.dart';
import 'package:myitihas/features/chat/presentation/pages/chat_list_page.dart';
import 'package:myitihas/features/chat/presentation/pages/chat_view_page.dart';
import 'package:myitihas/features/stories/presentation/pages/story_detail_route_page.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/features/story_generator/presentation/pages/story_generator_page.dart';
import 'package:myitihas/features/story_generator/presentation/pages/generated_story_detail_page.dart';
import 'package:myitihas/services/supabase_service.dart';
import 'package:myitihas/config/go_router_refresh.dart';

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
  ],
)
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

/// Discover
@TypedGoRoute<DiscoverRoute>(path: '/discover')
class DiscoverRoute extends GoRouteData with $DiscoverRoute {
  const DiscoverRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DiscoverPage();
  }
}

/// Login
@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginPage();
  }
}

/// Signup
@TypedGoRoute<SignupRoute>(path: '/signup')
class SignupRoute extends GoRouteData with $SignupRoute {
  const SignupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignupPage();
  }
}

/// Reset password
@TypedGoRoute<ResetPasswordRoute>(path: '/reset-password')
class ResetPasswordRoute extends GoRouteData with $ResetPasswordRoute {
  const ResetPasswordRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ResetPasswordPage();
  }
}

/// New chat
@TypedGoRoute<NewChatRoute>(path: '/new-chat')
class NewChatRoute extends GoRouteData with $NewChatRoute {
  const NewChatRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NewChatPage();
  }
}

/// New group
@TypedGoRoute<NewGroupRoute>(path: '/new-group')
class NewGroupRoute extends GoRouteData with $NewGroupRoute {
  const NewGroupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NewGroupPage();
  }
}

/// New contact
@TypedGoRoute<NewContactRoute>(path: '/new-contact')
class NewContactRoute extends GoRouteData with $NewContactRoute {
  const NewContactRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NewContactPage();
  }
}

/// Chat detail page route - requires parameters passed via $extra
@TypedGoRoute<ChatDetailRoute>(path: '/chat_detail')
class ChatDetailRoute extends GoRouteData with $ChatDetailRoute {
  const ChatDetailRoute({required this.$extra});

  final Map<String, dynamic> $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ChatDetailPage(
      name: $extra['name'] ?? "User",
      avatarColor: $extra['color'] != null
          // ignore: deprecated_member_use
          ? "0xFF${($extra['color'] as Color).value.toRadixString(16).substring(2)}"
          : "0xFF3B82F6",
      isGroup: $extra['isGroup'] ?? false,
    );
  }
}

/// Profile detail page route - requires name parameter via $extra
@TypedGoRoute<ProfileDetailRoute>(path: '/profile_detail')
class ProfileDetailRoute extends GoRouteData with $ProfileDetailRoute {
  const ProfileDetailRoute({required this.$extra});

  final Map<String, dynamic> $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ProfileDetailPage(name: $extra['name'] ?? "User");
  }
}

/// Group profile page route - requires parameters via $extra
@TypedGoRoute<GroupProfileRoute>(path: '/group_profile')
class GroupProfileRoute extends GoRouteData with $GroupProfileRoute {
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

/// Settings page
@TypedGoRoute<SettingsRoute>(path: '/settings')
class SettingsRoute extends GoRouteData with $SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPage();
  }
}

/// Edit Profile page
@TypedGoRoute<EditProfileRoute>(path: '/edit-profile/:userId')
class EditProfileRoute extends GoRouteData with $EditProfileRoute {
  final String userId;
  final String displayName;
  final String bio;
  final String avatarUrl;

  const EditProfileRoute({
    required this.userId,
    required this.displayName,
    this.bio = '',
    this.avatarUrl = '',
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EditProfilePage(
      userId: userId,
      currentDisplayName: displayName,
      currentBio: bio,
      currentAvatarUrl: avatarUrl,
    );
  }
}

// ============================================================================
// MyItihasRouter - GoRouter Configuration
// ============================================================================
class MyItihasRouter {
  final GoRouterRefreshStream _refreshStream = GoRouterRefreshStream();

  MyItihasRouter() {
    // Register refresh stream with SupabaseService so AuthService can access it
    SupabaseService.setRefreshStream(_refreshStream);
  }

  GoRouter get router => GoRouter(
    initialLocation: '/',
    routes: $appRoutes,
    refreshListenable: _refreshStream,
    redirect: (context, state) {
      final isAuthenticated = SupabaseService.getCurrentSession() != null;
      final isRecovering = _refreshStream.isRecovering;

      final currentPath = state.matchedLocation;
      final isOnLogin = currentPath == '/login';
      final isOnSignup = currentPath == '/signup';
      final isOnSplash = currentPath == '/';
      final isOnResetPassword = currentPath == '/reset-password';

      // HIGHEST PRIORITY: Password recovery flow
      // If user is in recovery mode, FORCE them to /reset-password
      if (isRecovering) {
        if (!isOnResetPassword) {
          return '/reset-password';
        }
        return null;
      }

      // Authenticated user trying to access login/signup
      if (isAuthenticated && (isOnLogin || isOnSignup)) {
        return '/home';
      }

      // Splash screen handles its own logic
      if (isOnSplash) return null;

      // Reset password page without recovery mode
      if (isOnResetPassword && !isRecovering) {
        return '/login';
      }

      // Unauthenticated access to protected routes
      if (!isAuthenticated && !isOnLogin && !isOnSignup && !isOnResetPassword) {
        return '/login';
      }

      return null;
    },
  );
}

// ============================================================================
// Feature Routes (TypedGoRoute – from main branch)
// ============================================================================

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

@TypedGoRoute<FollowersRoute>(path: '/followers/:userId')
class FollowersRoute extends GoRouteData with $FollowersRoute {
  final String userId;

  const FollowersRoute({required this.userId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return FollowersPage(userId: userId);
  }
}

@TypedGoRoute<FollowingRoute>(path: '/following/:userId')
class FollowingRoute extends GoRouteData with $FollowingRoute {
  final String userId;

  const FollowingRoute({required this.userId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return FollowingPage(userId: userId);
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
class MapRoute extends GoRouteData with $MapRoute {
  const MapRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AkhandaBharatMapPage();
  }
}

/// Story Generator route with result sub-route
@TypedGoRoute<StoryGeneratorRoute>(
  path: '/story-generator',
  routes: [TypedGoRoute<GeneratedStoryResultRoute>(path: 'result')],
)
class StoryGeneratorRoute extends GoRouteData with $StoryGeneratorRoute {
  const StoryGeneratorRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const StoryGeneratorPage();
  }
}

/// Generated story result page - receives Story via $extra
class GeneratedStoryResultRoute extends GoRouteData
    with $GeneratedStoryResultRoute {
  final Story $extra;

  const GeneratedStoryResultRoute({required this.$extra});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return GeneratedStoryDetailPage(story: $extra);
  }
}

@TypedGoRoute<ShaktiPeethaRoute>(path: '/shakti-peetha')
class ShaktiPeethaRoute extends GoRouteData with $ShaktiPeethaRoute {
  const ShaktiPeethaRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ShaktiPeethaDetailPage();
  }
}
