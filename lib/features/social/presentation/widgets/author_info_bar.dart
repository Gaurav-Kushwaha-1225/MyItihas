import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:myitihas/config/theme/gradient_extension.dart';
import 'package:myitihas/features/social/domain/entities/user.dart';
import 'package:myitihas/features/social/presentation/widgets/svg_avatar.dart';
import 'package:myitihas/i18n/strings.g.dart';
import 'package:myitihas/utils/constants.dart';

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

class _FollowButton extends StatefulWidget {
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
  State<_FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<_FollowButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(_FollowButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFollowing != oldWidget.isFollowing) {
      _controller.forward().then((_) => _controller.reverse());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      button: true,
      label: widget.isFollowing ? t.profile.unfollow : t.profile.follow,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.isLoading
              ? null
              : () {
                  HapticFeedback.lightImpact();
                  widget.onTap?.call();
                },
          borderRadius: BorderRadius.circular(10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(
              horizontal: widget.compact ? 10 : 14,
              vertical: widget.compact ? 6 : 8,
            ),
            decoration: BoxDecoration(
              // gradient: !widget.isFollowing
              //     ? null
              //     : widget.gradients?.primaryButtonGradient ??
              //           LinearGradient(
              //             colors: [
              //               widget.colorScheme.primary,
              //               widget.colorScheme.secondary,
              //             ],
              //           ),
              // color: !widget.isFollowing ? Colors.transparent : null,
              borderRadius: BorderRadius.circular(10),
              border: widget.isFollowing
                  ? GradientBoxBorder(
                    width: 1.5,
                      gradient:
                          widget.gradients?.primaryButtonGradient ??
                          LinearGradient(
                            colors: [
                              widget.colorScheme.primary,
                              widget.colorScheme.secondary,
                            ],
                          ),
                    )
                  : Border.all(color: DarkColors.textPrimary, width: 1.5),
            ),
            child: widget.isLoading
                ? SizedBox(
                    width: widget.compact ? 12 : 16,
                    height: widget.compact ? 12 : 16,
                    child: CircularProgressIndicator.adaptive(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(
                        widget.colorScheme.onSurface,
                      ),
                    ),
                  )
                : Text(
                    widget.isFollowing
                        ? t.profile.following
                        : t.profile.follow,
                    style:
                        (widget.compact
                                ? theme.textTheme.labelSmall
                                : theme.textTheme.labelMedium)
                            ?.copyWith(
                              color: widget.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                  ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
