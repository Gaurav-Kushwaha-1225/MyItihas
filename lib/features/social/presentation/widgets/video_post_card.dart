import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myitihas/features/social/domain/entities/video_post.dart';
import 'package:myitihas/features/social/presentation/widgets/author_info_bar.dart';
import 'package:myitihas/features/social/presentation/widgets/engagement_bar.dart';
import 'package:myitihas/i18n/strings.g.dart';

/// A full-screen card for displaying video posts in the social feed.
/// Features a tappable caption that shows/hides on tap.
class VideoPostCard extends StatefulWidget {
  final VideoPost post;
  final bool isVisible;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final VoidCallback? onBookmark;
  final VoidCallback? onProfileTap;
  final VoidCallback? onFollowTap;
  final bool isFollowLoading;

  const VideoPostCard({
    super.key,
    required this.post,
    this.isVisible = true,
    this.onLike,
    this.onComment,
    this.onShare,
    this.onBookmark,
    this.onProfileTap,
    this.onFollowTap,
    this.isFollowLoading = false,
  });

  @override
  State<VideoPostCard> createState() => _VideoPostCardState();
}

class _VideoPostCardState extends State<VideoPostCard>
    with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late AnimationController _captionController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _authorFade;
  late Animation<double> _captionFade;
  late Animation<double> _actionsFade;

  bool _isCaptionVisible = true;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    if (widget.isVisible) {
      _entranceController.forward();
    }
  }

  void _setupAnimations() {
    _entranceController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _captionController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
      value: 1.0, // Start visible
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(
          CurvedAnimation(parent: _entranceController, curve: Curves.easeOut),
        );

    _authorFade = _createStaggeredFade(0.0, 0.4);
    _captionFade = _createStaggeredFade(0.2, 0.6);
    _actionsFade = _createStaggeredFade(0.4, 0.8);
  }

  Animation<double> _createStaggeredFade(double begin, double end) {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: Interval(begin, end, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void didUpdateWidget(VideoPostCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !oldWidget.isVisible) {
      _entranceController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _captionController.dispose();
    super.dispose();
  }

  void _toggleCaption() {
    setState(() {
      _isCaptionVisible = !_isCaptionVisible;
      if (_isCaptionVisible) {
        _captionController.forward();
      } else {
        _captionController.reverse();
      }
    });
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String _formatViewCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final post = widget.post;
    final screenSize = MediaQuery.of(context).size;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: GestureDetector(
          onTap: _toggleCaption,
          child: Container(
            height: screenSize.height,
            width: screenSize.width,
            color: Colors.black,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Video thumbnail (placeholder for actual video player)
                _VideoThumbnailSection(post: post),

                // Play button overlay
                Center(
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),

                // Duration badge
                Positioned(
                  top: 100,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      _formatDuration(post.durationSeconds),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // View count badge
                Positioned(
                  top: 100,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.visibility_outlined,
                          color: Colors.white,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatViewCount(post.viewCount),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Top gradient for header
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Bottom gradient for content
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: FadeTransition(
                    opacity: _captionController,
                    child: Container(
                      height: screenSize.height * 0.45,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.95),
                            Colors.black.withValues(alpha: 0.6),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  ),
                ),

                // Content overlay (toggleable)
                Positioned(
                  left: 0,
                  right: 40,
                  bottom: 0,
                  child: FadeTransition(
                    opacity: _captionController,
                    child: SafeArea(
                      top: false,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 8, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Author info
                            if (post.authorUser != null)
                              FadeTransition(
                                opacity: _authorFade,
                                child: AuthorInfoBar(
                                  author: post.authorUser!,
                                  onProfileTap: widget.onProfileTap,
                                  onFollowTap: widget.onFollowTap,
                                  isFollowLoading: widget.isFollowLoading,
                                  compact: false,
                                  darkOverlay: true,
                                ),
                              ),
                            const SizedBox(height: 12),

                            // Location badge
                            if (post.location != null &&
                                post.location!.isNotEmpty)
                              FadeTransition(
                                opacity: _captionFade,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 16,
                                      color: Colors.white.withValues(
                                        alpha: 0.8,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Flexible(
                                      child: Text(
                                        post.location!,
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                              color: Colors.white.withValues(
                                                alpha: 0.8,
                                              ),
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (post.location != null &&
                                post.location!.isNotEmpty)
                              const SizedBox(height: 8),

                            // Caption
                            if (post.caption != null &&
                                post.caption!.isNotEmpty)
                              FadeTransition(
                                opacity: _captionFade,
                                child: Text(
                                  post.caption!,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                    height: 1.4,
                                  ),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            const SizedBox(height: 12),

                            // Tags
                            if (post.tags.isNotEmpty)
                              FadeTransition(
                                opacity: _captionFade,
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 4,
                                  children: post.tags.take(4).map((tag) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.15,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.white.withValues(
                                            alpha: 0.2,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        '#$tag',
                                        style: theme.textTheme.labelSmall
                                            ?.copyWith(
                                              color: Colors.white.withValues(
                                                alpha: 0.9,
                                              ),
                                            ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Tap hint indicator (when caption is hidden)
                if (!_isCaptionVisible)
                  Positioned(
                    left: 16,
                    bottom: 120,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.touch_app_outlined,
                            size: 16,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            t.feed.tapToShowCaption,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Vertical engagement bar (always visible)
                Positioned(
                  right: 12,
                  bottom: 48,
                  child: SafeArea(
                    top: false,
                    child: FadeTransition(
                      opacity: _actionsFade,
                      child: EngagementBar(
                        likeCount: post.likes,
                        commentCount: post.commentCount,
                        shareCount: post.shareCount,
                        isLiked: post.isLikedByCurrentUser,
                        isBookmarked: post.isFavorite,
                        onLike: widget.onLike,
                        onComment: widget.onComment,
                        onShare: widget.onShare,
                        onBookmark: widget.onBookmark,
                        vertical: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _VideoThumbnailSection extends StatelessWidget {
  final VideoPost post;

  const _VideoThumbnailSection({required this.post});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (post.thumbnailUrl != null && post.thumbnailUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: post.thumbnailUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            _VideoPlaceholder(colorScheme: colorScheme),
        errorWidget: (context, url, error) =>
            _VideoPlaceholder(colorScheme: colorScheme),
      );
    }

    return _VideoPlaceholder(colorScheme: colorScheme);
  }
}

class _VideoPlaceholder extends StatelessWidget {
  final ColorScheme colorScheme;

  const _VideoPlaceholder({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.videocam_outlined,
            size: 64,
            color: colorScheme.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 8),
          Text(
            t.feed.tabs.videos,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
