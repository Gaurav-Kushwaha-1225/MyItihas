import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/svg_avatar.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/config/routes.dart';
import 'package:myitihas/config/theme/gradient_extension.dart';
import 'package:myitihas/features/social/presentation/bloc/profile_bloc.dart';
import 'package:myitihas/features/social/presentation/bloc/profile_event.dart';
import 'package:myitihas/features/social/presentation/bloc/profile_state.dart';
import 'package:myitihas/i18n/strings.g.dart';

class ProfilePage extends StatelessWidget {
  final String userId;

  const ProfilePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<ProfileBloc>()..add(ProfileEvent.loadProfile(userId)),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded:
                (
                  user,
                  followers,
                  following,
                  isLoadingFollowers,
                  isLoadingFollowing,
                ) {
                  return CustomScrollView(
                    slivers: [
                      // Profile header card
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 40, 16, 24),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Avatar on left
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Theme.of(context).colorScheme.surface,
                                      width: 3,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.1),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: SvgAvatar(
                                    key: ValueKey('avatar_${user.id}_${user.avatarUrl}'),
                                    imageUrl: user.avatarUrl,
                                    radius: 50,
                                    fallbackText: user.displayName,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                // Name and username on right
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.displayName,
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSurface,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        '@${user.username}',
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Profile info
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Modern stats card
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _ModernStatItem(
                                      label: t.profile.followers,
                                      count: user.followerCount,
                                      onTap: () {
                                        context.read<ProfileBloc>().add(
                                          ProfileEvent.loadFollowers(user.id),
                                        );
                                        _showFollowersSheet(
                                          context,
                                          followers,
                                          isLoadingFollowers,
                                        );
                                      },
                                    ),
                                    Container(
                                      width: 1,
                                      height: 40,
                                      color: Theme.of(context).colorScheme.outlineVariant,
                                    ),
                                    _ModernStatItem(
                                      label: t.profile.following,
                                      count: user.followingCount,
                                      onTap: () {
                                        context.read<ProfileBloc>().add(
                                          ProfileEvent.loadFollowing(user.id),
                                        );
                                        _showFollowingSheet(
                                          context,
                                          following,
                                          isLoadingFollowing,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 24),

                              // Edit Profile button for current user
                              if (user.isCurrentUser)
                                Container(
                                  width: double.infinity,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    gradient: Theme.of(context)
                                          .extension<GradientExtension>()!
                                          .primaryButtonGradient,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                                        blurRadius: 12,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton.icon(
                                    onPressed: () async {
                                      final result = await EditProfileRoute(
                                        userId: user.id,
                                        displayName: user.displayName,
                                        bio: user.bio,
                                        avatarUrl: user.avatarUrl,
                                      ).push<bool>(context);
                                      
                                      // Reload profile if changes were saved
                                      if (result == true && context.mounted) {
                                        context.read<ProfileBloc>().add(
                                          ProfileEvent.loadProfile(user.id),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      elevation: 0,
                                    ),
                                    icon: const Icon(Icons.edit_rounded, size: 22),
                                    label: const Text(
                                      'Edit Profile',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                ),

                              // Follow/Unfollow button for other users
                              if (!user.isCurrentUser)
                                Container(
                                  width: double.infinity,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    gradient: user.isFollowing
                                        ? null
                                        : Theme.of(context)
                                              .extension<GradientExtension>()!
                                              .primaryButtonGradient,
                                    color: user.isFollowing
                                        ? Theme.of(context).colorScheme.surfaceContainerHighest
                                        : null,
                                    borderRadius: BorderRadius.circular(16),
                                    border: user.isFollowing
                                        ? Border.all(
                                            color: Theme.of(context).colorScheme.outline,
                                            width: 1.5,
                                          )
                                        : null,
                                    boxShadow: !user.isFollowing
                                        ? [
                                            BoxShadow(
                                              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                                              blurRadius: 12,
                                              offset: const Offset(0, 6),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context.read<ProfileBloc>().add(
                                        ProfileEvent.toggleFollow(user.id),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      foregroundColor: user.isFollowing
                                          ? Theme.of(context).colorScheme.onSurface
                                          : Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          user.isFollowing ? Icons.person_remove_rounded : Icons.person_add_rounded,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          user.isFollowing
                                              ? t.profile.unfollow
                                              : t.profile.follow,
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              const SizedBox(height: 24),

                              if (user.bio.isNotEmpty) ...[
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.info_outline_rounded,
                                            size: 20,
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            t.profile.about,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context).colorScheme.onSurface,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        user.bio,
                                        style: TextStyle(
                                          fontSize: 15,
                                          height: 1.5,
                                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),
                              ],

                              Row(
                                children: [
                                  Icon(
                                    Icons.auto_stories_rounded,
                                    size: 20,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    t.profile.stories,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).colorScheme.onSurface,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),

                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            return Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Theme.of(context).colorScheme.surfaceContainerHighest,
                                    Theme.of(context).colorScheme.surfaceContainer,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.auto_stories_rounded,
                                  size: 40,
                                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
                                ),
                              ),
                            );
                          }, childCount: 6),
                        ),
                      ),
                    ],
                  );
                },
            error: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${t.notification.errorPrefix} $message',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Retry loading
                    },
                    child: Text(t.notification.retry),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showFollowersSheet(
    BuildContext context,
    List followers,
    bool isLoading,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              t.profile.followers,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const Divider(),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: followers.length,
                      itemBuilder: (context, index) {
                        final follower = followers[index];
                        return ListTile(
                          leading: SvgAvatar(
                            imageUrl: follower.avatarUrl ?? '',
                            radius: 20,
                            fallbackText: follower.displayName,
                          ),
                          title: Text(follower.displayName),
                          subtitle: Text('@${follower.username}'),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFollowingSheet(
    BuildContext context,
    List following,
    bool isLoading,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              t.profile.following,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const Divider(),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: following.length,
                      itemBuilder: (context, index) {
                        final user = following[index];
                        return ListTile(
                          leading: SvgAvatar(
                            imageUrl: user.avatarUrl ?? '',
                            radius: 20,
                            fallbackText: user.displayName,
                          ),
                          title: Text(user.displayName),
                          subtitle: Text('@${user.username}'),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModernStatItem extends StatelessWidget {
  final String label;
  final int count;
  final VoidCallback onTap;

  const _ModernStatItem({
    required this.label,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          children: [
            Text(
              _formatCount(count),
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}
