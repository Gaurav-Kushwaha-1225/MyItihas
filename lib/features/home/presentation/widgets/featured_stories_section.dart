import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myitihas/config/theme/gradient_extension.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/i18n/strings.g.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// Featured stories carousel with page indicator and animations
class FeaturedStoriesSection extends StatefulWidget {
  final List<Story> stories;
  final bool isLoading;
  final void Function(Story story)? onStoryTap;

  const FeaturedStoriesSection({
    super.key,
    required this.stories,
    this.isLoading = false,
    this.onStoryTap,
  });

  @override
  State<FeaturedStoriesSection> createState() => _FeaturedStoriesSectionState();
}

class _FeaturedStoriesSectionState extends State<FeaturedStoriesSection> {
  late PageController _pageController;
  // ignore: unused_field
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (widget.isLoading) {
      return _buildShimmer(context, isDark);
    }

    if (widget.stories.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            t.homeScreen.featuredStories,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
        ),

        SizedBox(height: 16.h),

        // Stories carousel
        SizedBox(
          height: 220.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
              HapticFeedback.selectionClick();
            },
            itemCount: widget.stories.length,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = (_pageController.page! - index).abs();
                    value = (1 - (value * 0.15)).clamp(0.85, 1.0);
                  }
                  return Center(
                    child: Transform.scale(
                      scale: value,
                      child: Opacity(
                        opacity: value.clamp(0.7, 1.0),
                        child: child,
                      ),
                    ),
                  );
                },
                child: _FeaturedStoryCard(
                  story: widget.stories[index],
                  onTap: () => widget.onStoryTap?.call(widget.stories[index]),
                ),
              );
            },
          ),
        ),

        SizedBox(height: 16.h),

        // Page indicator
        Center(
          child: SmoothPageIndicator(
            controller: _pageController,
            count: widget.stories.length,
            effect: ExpandingDotsEffect(
              activeDotColor: colorScheme.primary,
              dotColor: colorScheme.outlineVariant,
              dotHeight: 8.h,
              dotWidth: 8.w,
              expansionFactor: 3,
              spacing: 6.w,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmer(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Shimmer.fromColors(
            baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
            highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
            child: Container(
              width: 150.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 220.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: Shimmer.fromColors(
                  baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
                  highlightColor: isDark
                      ? Colors.grey[700]!
                      : Colors.grey[100]!,
                  child: Container(
                    width: 280.w,
                    height: 220.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16.h),
        Center(
          child: Shimmer.fromColors(
            baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
            highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
            child: Container(
              width: 40.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Individual featured story card
class _FeaturedStoryCard extends StatefulWidget {
  final Story story;
  final VoidCallback? onTap;

  const _FeaturedStoryCard({required this.story, this.onTap});

  @override
  State<_FeaturedStoryCard> createState() => _FeaturedStoryCardState();
}

class _FeaturedStoryCardState extends State<_FeaturedStoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final gradients = theme.extension<GradientExtension>();

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 6.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background image
                if (widget.story.imageUrl != null)
                  CachedNetworkImage(
                    imageUrl: widget.story.imageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: colorScheme.surfaceContainerHighest,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.image_not_supported_rounded,
                        color: colorScheme.onSurfaceVariant,
                        size: 48.sp,
                      ),
                    ),
                  )
                else
                  Container(
                    decoration: BoxDecoration(
                      gradient:
                          gradients?.heroBackgroundGradient ??
                          LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              colorScheme.primary.withValues(alpha: 0.8),
                              colorScheme.secondary.withValues(alpha: 0.8),
                            ],
                          ),
                    ),
                  ),

                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.3),
                        Colors.black.withValues(alpha: 0.8),
                      ],
                      stops: const [0.3, 0.6, 1.0],
                    ),
                  ),
                ),

                // Content
                Positioned(
                  left: 16.w,
                  right: 16.w,
                  bottom: 16.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Scripture chip
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          widget.story.scripture,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      SizedBox(height: 8.h),

                      // Title
                      Text(
                        widget.story.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      // Meta info row
                      Row(
                        children: [
                          Icon(
                            Icons.auto_stories_rounded,
                            size: 14.sp,
                            color: Colors.white70,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            widget.story.attributes.storyType,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Icon(
                            Icons.schedule_rounded,
                            size: 14.sp,
                            color: Colors.white70,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            widget.story.attributes.storyLength,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Play/Read indicator
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: 18.sp,
                      color: Colors.white,
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
