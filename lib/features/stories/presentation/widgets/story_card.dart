import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/i18n/strings.g.dart';

class StoryCard extends StatelessWidget {
  final Story story;
  final VoidCallback onTap;
  final VoidCallback? onFavorite;

  const StoryCard({
    super.key,
    required this.story,
    required this.onTap,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      story.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (onFavorite != null)
                    IconButton(
                      icon: Icon(
                        story.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: story.isFavorite
                            ? theme.colorScheme.error
                            : null,
                      ),
                      onPressed: onFavorite,
                    ),
                ],
              ),

              SizedBox(height: 8.h),

              Wrap(
                spacing: 8.w,
                runSpacing: 4.h,
                children: [
                  Chip(
                    label: Text(
                      story.scripture,
                      style: theme.textTheme.bodySmall,
                    ),
                    backgroundColor: theme.primaryColor.withValues(alpha: 0.1),
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                  ),
                ],
              ),

              SizedBox(height: 12.h),

              Text(
                story.story,
                style: theme.textTheme.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: 12.h),

              // Attributes row
              Wrap(
                spacing: 8.w,
                runSpacing: 4.h,
                children: [
                  if (story.attributes.storyType.isNotEmpty)
                    _buildAttributeChip(
                      context,
                      Icons.category,
                      story.attributes.storyType,
                    ),
                  if (story.attributes.theme.isNotEmpty)
                    _buildAttributeChip(
                      context,
                      Icons.palette,
                      story.attributes.theme,
                    ),
                ],
              ),

              SizedBox(height: 8.h),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: onTap,
                  icon: const Icon(Icons.arrow_forward),
                  label: Text(t.stories.readMore),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttributeChip(
    BuildContext context,
    IconData icon,
    String label,
  ) {
    final theme = Theme.of(context);
    return Chip(
      visualDensity: .compact,
      avatar: Icon(
        icon,
        size: 16.sp,
        color: theme.colorScheme.onSecondaryContainer,
      ),
      label: Text(
        label,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSecondaryContainer,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      backgroundColor: theme.colorScheme.secondaryContainer,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
    );
  }
}
