import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/i18n/strings.g.dart';
import 'package:shimmer/shimmer.dart';

/// Section displaying user's generated stories
class MyGeneratedStoriesSection extends StatelessWidget {
  final List<Story> stories;
  final bool isLoading;
  final void Function(Story story)? onStoryTap;
  final void Function(Story story)? onShareToFeed;
  final VoidCallback? onSeeAll;
  final VoidCallback? onCreateNew;

  const MyGeneratedStoriesSection({
    super.key,
    required this.stories,
    this.isLoading = false,
    this.onStoryTap,
    this.onShareToFeed,
    this.onSeeAll,
    this.onCreateNew,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (isLoading) {
      return _buildShimmer(context, isDark);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: colorScheme.tertiary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.wandMagicSparkles,
                      size: 16.sp,
                      color: colorScheme.tertiary,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    t.homeScreen.myGeneratedStories,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              if (stories.isNotEmpty)
                TextButton(
                  onPressed: onSeeAll,
                  child: Text(
                    t.homeScreen.seeAll,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),

        SizedBox(height: 12.h),

        if (stories.isEmpty)
          _buildEmptyState(context)
        else
          SizedBox(
            height: 180.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: stories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: _GeneratedStoryCard(
                    story: stories[index],
                    onTap: () => onStoryTap?.call(stories[index]),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.tertiary.withValues(alpha: 0.08),
            colorScheme.primary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colorScheme.tertiary.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: colorScheme.tertiary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: FaIcon(
              FontAwesomeIcons.wandMagicSparkles,
              size: 24.sp,
              color: colorScheme.tertiary,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.homeScreen.noGeneratedStoriesYet,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  t.homeScreen.createYourFirstStory,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          FilledButton(
            onPressed: onCreateNew,
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.tertiary,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(FontAwesomeIcons.plus, size: 12.sp),
                SizedBox(width: 6.w),
                Text(t.homeScreen.generateStory),
              ],
            ),
          ),
        ],
      ),
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
              width: 180.w,
              height: 24.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 180.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                    width: 150.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Individual generated story card - clean design without share button
class _GeneratedStoryCard extends StatefulWidget {
  final Story story;
  final VoidCallback? onTap;

  const _GeneratedStoryCard({required this.story, this.onTap});

  @override
  State<_GeneratedStoryCard> createState() => _GeneratedStoryCardState();
}

class _GeneratedStoryCardState extends State<_GeneratedStoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.96,
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
    final t = Translations.of(context);

    return GestureDetector(
      onTapDown: (_) {
        _controller.forward();
        HapticFeedback.selectionClick();
      },
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: 150.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withValues(alpha: 0.12),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background image
                if (widget.story.imageUrl != null)
                  // CachedNetworkImage(
                  //   imageUrl: widget.story.imageUrl!,
                  //   fit: BoxFit.cover,
                  //   placeholder: (context, url) =>
                  //       Container(color: colorScheme.surfaceContainerHighest),
                  //   errorWidget: (context, url, error) =>
                  //       _buildPlaceholderImage(colorScheme),
                  // )
                  Image.memory(
                    widget.story.imageUrl!.split(',').length > 1
                        ? base64Decode(widget.story.imageUrl!.split(',')[1])
                        : base64Decode(widget.story.imageUrl!),
                    fit: BoxFit.fitHeight,
                  )
                else
                  _buildPlaceholderImage(colorScheme),

                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.75),
                      ],
                      stops: const [0.4, 1.0],
                    ),
                  ),
                ),

                // AI Generated badge
                Positioned(
                  top: 8.h,
                  left: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.wandMagicSparkles,
                          size: 10.sp,
                          color: colorScheme.onTertiary,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          t.storyGenerator.aiGenerated,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.onTertiary,
                            fontWeight: FontWeight.w600,
                            fontSize: 9.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Content overlay
                Positioned(
                  left: 10.w,
                  right: 10.w,
                  bottom: 10.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Scripture tag
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          widget.story.scripture,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 9.sp,
                          ),
                        ),
                      ),

                      SizedBox(height: 6.h),

                      // Title
                      Text(
                        widget.story.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
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
    );
  }

  Widget _buildPlaceholderImage(ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.tertiary.withValues(alpha: 0.5),
            colorScheme.primary.withValues(alpha: 0.4),
          ],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.auto_stories_rounded,
          size: 40.sp,
          color: Colors.white.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
