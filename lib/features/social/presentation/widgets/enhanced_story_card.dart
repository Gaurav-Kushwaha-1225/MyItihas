import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myitihas/config/theme/gradient_extension.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/features/social/presentation/widgets/author_info_bar.dart';
import 'package:myitihas/features/social/presentation/widgets/engagement_bar.dart';
import 'package:myitihas/features/social/presentation/widgets/quote_callout.dart';
import 'package:myitihas/features/social/presentation/widgets/story_attribute_chip.dart';
import 'package:myitihas/features/social/presentation/widgets/swipeable_content_section.dart';
import 'package:myitihas/i18n/strings.g.dart';

class EnhancedStoryCard extends StatefulWidget {
  final Story story;
  final bool isVisible;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final VoidCallback? onBookmark;
  final VoidCallback? onProfileTap;
  final VoidCallback? onFollowTap;
  final VoidCallback? onContinueReading;
  final bool isFollowLoading;

  const EnhancedStoryCard({
    super.key,
    required this.story,
    this.isVisible = true,
    this.onLike,
    this.onComment,
    this.onShare,
    this.onBookmark,
    this.onProfileTap,
    this.onFollowTap,
    this.onContinueReading,
    this.isFollowLoading = false,
  });

  @override
  State<EnhancedStoryCard> createState() => _EnhancedStoryCardState();
}

class _EnhancedStoryCardState extends State<EnhancedStoryCard>
    with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  late Animation<double> _authorFade;
  late Animation<double> _titleFade;
  late Animation<double> _quoteFade;
  late Animation<double> _contentFade;
  late Animation<double> _actionsFade;

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

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(
          CurvedAnimation(parent: _entranceController, curve: Curves.easeOut),
        );

    _authorFade = _createStaggeredFade(0.0, 0.4);
    _titleFade = _createStaggeredFade(0.1, 0.5);
    _quoteFade = _createStaggeredFade(0.2, 0.6);
    _contentFade = _createStaggeredFade(0.3, 0.7);
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
  void didUpdateWidget(EnhancedStoryCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !oldWidget.isVisible) {
      _entranceController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gradients = theme.extension<GradientExtension>();
    final story = widget.story;
    final screenSize = MediaQuery.of(context).size;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          height: screenSize.height,
          width: screenSize.width,
          color: Colors.black,
          child: Stack(
            fit: StackFit.expand,
            children: [
              _HeroImageSection(story: story, gradients: gradients),

              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: screenSize.height * 0.65,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.95),
                        Colors.black.withValues(alpha: 0.7),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.6, 1.0],
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 0,
                right: 40,
                bottom: 0,
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 8, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (story.authorUser != null)
                          FadeTransition(
                            opacity: _authorFade,
                            child: AuthorInfoBar(
                              author: story.authorUser!,
                              onProfileTap: widget.onProfileTap,
                              onFollowTap: widget.onFollowTap,
                              isFollowLoading: widget.isFollowLoading,
                              compact: false,
                              darkOverlay: true,
                            ),
                          ),
                        const SizedBox(height: 8),

                        // Title
                        FadeTransition(
                          opacity: _titleFade,
                          child: Text(
                            story.title,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 8),

                        FadeTransition(
                          opacity: _titleFade,
                          child: Row(
                            children: [
                              Flexible(
                                child: StoryAttributeChip.scripture(
                                  story.scripture,
                                  darkOverlay: true,
                                ),
                              ),
                              if (story.attributes.theme.isNotEmpty) ...[
                                const SizedBox(width: 4),
                                Flexible(
                                  child: StoryAttributeChip.theme(
                                    story.attributes.theme,
                                    darkOverlay: true,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),

                        if (story.quotes.isNotEmpty)
                          FadeTransition(
                            opacity: _quoteFade,
                            child: QuoteCallout(
                              quote: story.quotes,
                              attribution: story.scripture,
                              maxLines: 2,
                              darkOverlay: true,
                            ),
                          ),
                        if (story.quotes.isNotEmpty) const SizedBox(height: 10),

                        FadeTransition(
                          opacity: _contentFade,
                          child: SizedBox(
                            height: 184,
                            child: SwipeableContentSection(
                              storyExcerpt: story.story,
                              trivia: story.trivia,
                              lesson: story.lesson,
                              activity: story.activity,
                              maxLines: 8,
                              darkOverlay: true,
                              onContinueReadingTap: widget.onContinueReading,
                            ),
                          ),
                        ),
                        // const SizedBox(height: 8),

                        // Continue Reading button
                        // FadeTransition(
                        //   opacity: _actionsFade,
                        //   child: _ContinueReadingButton(
                        //     onTap: widget.onContinueReading,
                        //     gradients: gradients,
                        //     colorScheme: colorScheme,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                right: 12,
                bottom: 48,
                child: SafeArea(
                  top: false,
                  child: FadeTransition(
                    opacity: _actionsFade,
                    child: EngagementBar(
                      likeCount: story.likes,
                      commentCount: story.commentCount,
                      shareCount: story.shareCount,
                      isLiked: story.isLikedByCurrentUser,
                      isBookmarked: story.isFavorite,
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
    );
  }
}

class _HeroImageSection extends StatelessWidget {
  final Story story;
  final GradientExtension? gradients;

  const _HeroImageSection({required this.story, this.gradients});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (story.imageUrl != null && story.imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: story.imageUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) => _Placeholder(colorScheme: colorScheme),
        errorWidget: (context, url, error) =>
            _Placeholder(colorScheme: colorScheme),
      );
    }

    return _Placeholder(colorScheme: colorScheme);
  }
}

class _Placeholder extends StatelessWidget {
  final ColorScheme colorScheme;

  const _Placeholder({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/logo.png',
            width: 96,
            height: 96,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.auto_stories,
              size: 64,
              color: colorScheme.primary.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            t.app.name,
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
