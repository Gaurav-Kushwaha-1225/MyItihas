import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../widgets/svg_avatar.dart';
import 'package:myitihas/core/di/injection_container.dart';
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
                      // Profile header
                      SliverToBoxAdapter(
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            gradient: Theme.of(context)
                                .extension<GradientExtension>()!
                                .primaryButtonGradient,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgAvatar(
                                imageUrl: user.avatarUrl,
                                radius: 50,
                                fallbackText: user.displayName,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                user.displayName,
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '@${user.username}',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimary
                                      .withValues(alpha: 0.7),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Profile info
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Stats row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _StatItem(
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
                                  _StatItem(
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

                              const SizedBox(height: 20),

                              if (!user.isCurrentUser)
                                Container(
                                  width: double.infinity,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    gradient: user.isFollowing
                                        ? null
                                        : Theme.of(context)
                                              .extension<GradientExtension>()!
                                              .primaryButtonGradient,
                                    color: user.isFollowing
                                        ? Theme.of(
                                            context,
                                          ).colorScheme.surfaceContainerHighest
                                        : null,
                                    borderRadius: BorderRadius.circular(12),
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
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.onSurface
                                          : Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text(
                                      user.isFollowing
                                          ? t.profile.unfollow
                                          : t.profile.follow,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),

                              const SizedBox(height: 20),

                              if (user.bio.isNotEmpty) ...[
                                Text(
                                  t.profile.about,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  user.bio,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],

                              const Divider(),

                              const SizedBox(height: 16),

                              Text(
                                t.profile.stories,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SliverPadding(
                        padding: const EdgeInsets.all(16),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.auto_stories,
                                  size: 40,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
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

class _StatItem extends StatelessWidget {
  final String label;
  final int count;
  final VoidCallback onTap;

  const _StatItem({
    required this.label,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Text(
              _formatCount(count),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
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
