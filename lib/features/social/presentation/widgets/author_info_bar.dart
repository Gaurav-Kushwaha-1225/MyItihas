import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myitihas/config/theme/gradient_extension.dart';
import 'package:myitihas/features/social/domain/entities/user.dart';
import 'package:myitihas/features/social/presentation/widgets/svg_avatar.dart';
import 'package:myitihas/i18n/strings.g.dart';

class AuthorInfoBar extends StatelessWidget {
  final User author;
  final VoidCallback? onProfileTap;
  final VoidCallback? onFollowTap;
  final bool isFollowLoading;
  final bool showFollowButton;
  final bool compact;
  final bool darkOverlay;

  const AuthorInfoBar({
    super.key,
    required this.author,
    this.onProfileTap,
    this.onFollowTap,
    this.isFollowLoading = false,
    this.showFollowButton = true,
    this.compact = false,
    this.darkOverlay = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gradients = theme.extension<GradientExtension>();
    final colorScheme = theme.colorScheme;

    return Semantics(
      label:
          '${author.displayName}, @${author.username}, ${_formatFollowerCount(author.followerCount)} ${t.profile.followers}',
      button: onProfileTap != null,
      child: InkWell(
        onTap: onProfileTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: compact ? 4 : 8,
            horizontal: 4,
          ),
          child: Row(
            children: [
              Semantics(
                image: true,
                label: '${author.displayName} profile picture',
                child: SvgAvatar(
                  imageUrl: author.avatarUrl,
                  radius: compact ? 16 : 20,
                  fallbackText: author.displayName,
                ),
              ),
              SizedBox(width: compact ? 8 : 12),
              // Name and username
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            author.displayName,
                            style:
                                (compact
                                        ? theme.textTheme.labelLarge
                                        : theme.textTheme.titleSmall)
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: darkOverlay
                                          ? Colors.white
                                          : colorScheme.onSurface,
                                    ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (!compact) ...[
                          const SizedBox(width: 4),
                          Text(
                            '@${author.username}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: darkOverlay
                                  ? Colors.white70
                                  : colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                    if (!compact) ...[
                      const SizedBox(height: 2),
                      Semantics(
                        label:
                            '${author.followerCount} ${t.profile.followers}, ${author.followingCount} ${t.profile.following}',
                        child: Text(
                          '${_formatFollowerCount(author.followerCount)} ${t.profile.followers}',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: darkOverlay
                                ? Colors.white70
                                : colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (showFollowButton && !author.isCurrentUser) ...[
                const SizedBox(width: 8),
                _FollowButton(
                  isFollowing: author.isFollowing,
                  isLoading: isFollowLoading,
                  onTap: onFollowTap,
                  gradients: gradients,
                  colorScheme: colorScheme,
                  compact: compact,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _formatFollowerCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}

class _FollowButton extends StatelessWidget {
  final bool isFollowing;
  final bool isLoading;
  final VoidCallback? onTap;
  final GradientExtension? gradients;
  final ColorScheme colorScheme;
  final bool compact;

  const _FollowButton({
    required this.isFollowing,
    required this.isLoading,
    this.onTap,
    this.gradients,
    required this.colorScheme,
    required this.compact,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      button: true,
      label: isFollowing ? t.profile.unfollow : t.profile.follow,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading
              ? null
              : () {
                  HapticFeedback.lightImpact();
                  onTap?.call();
                },
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(
              horizontal: compact ? 10 : 14,
              vertical: compact ? 4 : 6,
            ),
            decoration: BoxDecoration(
              gradient: isFollowing
                  ? null
                  : gradients?.primaryButtonGradient ??
                        LinearGradient(
                          colors: [colorScheme.primary, colorScheme.secondary],
                        ),
              color: isFollowing ? colorScheme.surfaceContainerHighest : null,
              borderRadius: BorderRadius.circular(16),
              border: isFollowing
                  ? Border.all(color: colorScheme.outline)
                  : null,
            ),
            child: isLoading
                ? SizedBox(
                    width: compact ? 12 : 16,
                    height: compact ? 12 : 16,
                    child: CircularProgressIndicator.adaptive(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(
                        isFollowing
                            ? colorScheme.onSurface
                            : colorScheme.onPrimary,
                      ),
                    ),
                  )
                : Text(
                    isFollowing ? t.profile.following : t.profile.follow,
                    style:
                        (compact
                                ? theme.textTheme.labelSmall
                                : theme.textTheme.labelMedium)
                            ?.copyWith(
                              color: isFollowing
                                  ? colorScheme.onSurface
                                  : colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                  ),
          ),
        ),
      ),
    );
  }
}
