import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myitihas/config/routes.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/i18n/strings.g.dart';
import 'package:timeago/timeago.dart' as timeago;

/// Page displaying all saved/bookmarked stories
class SavedStoriesPage extends StatelessWidget {
  final List<Story> stories;

  const SavedStoriesPage({super.key, required this.stories});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.homeScreen.savedStories),
        centerTitle: false,
      ),
      body: stories.isEmpty
          ? _buildEmptyState(context)
          : ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              itemCount: stories.length,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final story = stories[index];
                return GestureDetector(
                  onTap: () {
                    GeneratedStoryResultRoute($extra: story).push(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest.withOpacity(
                        0.5,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: colorScheme.outlineVariant.withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Thumbnail
                        Container(
                          width: 60.w,
                          height: 60.w,
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: story.imageUrl == null
                              ? Icon(
                                  Icons.image_not_supported_rounded,
                                  color: colorScheme.primary.withOpacity(0.5),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: Image.memory(
                                    story.imageUrl != null &&
                                            story.imageUrl!.split(',').length >
                                                1
                                        ? base64Decode(
                                            story.imageUrl!.split(',')[1],
                                          )
                                        : base64Decode(story.imageUrl!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        SizedBox(width: 12.w),
                        // Content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                story.title,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                story.scripture,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                              if (story.updatedAt != null) ...[
                                SizedBox(height: 4.h),
                                Text(
                                  timeago.format(story.updatedAt!),
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14.sp,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_border_rounded,
            size: 64.sp,
            color: colorScheme.onSurfaceVariant.withOpacity(0.5),
          ),
          SizedBox(height: 16.h),
          Text(
            t.homeScreen.saveForLater,
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Tap the bookmark icon on any story to save it here',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
