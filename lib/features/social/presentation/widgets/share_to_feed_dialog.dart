import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/i18n/strings.g.dart';
import 'package:myitihas/services/post_service.dart';

/// Shows a bottom sheet dialog for sharing a story to the social feed
Future<void> showShareToFeedDialog({
  required BuildContext context,
  required Story story,
}) async {
  final captionController = TextEditingController();

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (bottomSheetContext) {
      return _ShareToFeedDialogContent(
        story: story,
        captionController: captionController,
      );
    },
  );

  captionController.dispose();
}

class _ShareToFeedDialogContent extends StatelessWidget {
  final Story story;
  final TextEditingController captionController;

  const _ShareToFeedDialogContent({
    required this.story,
    required this.captionController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = Translations.of(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t.homeScreen.shareStoryTitle,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Story preview
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: colorScheme.tertiary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: story.imageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.network(
                              story.imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, _) => Icon(
                                Icons.auto_stories,
                                color: colorScheme.tertiary,
                              ),
                            ),
                          )
                        : Icon(
                            Icons.auto_stories,
                            color: colorScheme.tertiary,
                          ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          story.title,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          story.scripture,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Caption input
            Text(
              t.homeScreen.shareStoryMessage,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: captionController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: t.homeScreen.shareStoryHint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // Share button
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await _shareStoryToFeed(
                    context,
                    story,
                    captionController.text,
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Text(t.homeScreen.shareToFeed),
                ),
              ),
            ),

            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  Future<void> _shareStoryToFeed(
    BuildContext context,
    Story story,
    String caption,
  ) async {
    final t = Translations.of(context);
    final postService = getIt<PostService>();

    try {
      await postService.createPost(
        postType: PostType.storyShare,
        content: caption.isNotEmpty ? caption : story.lesson,
        title: story.title,
        sharedStoryId: story.id,
        metadata: {
          'story_title': story.title,
          'story_scripture': story.scripture,
          'story_image_url': story.imageUrl,
          'story_lesson': story.lesson,
        },
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.homeScreen.sharedToFeed),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to share: ${e.toString()}'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}
