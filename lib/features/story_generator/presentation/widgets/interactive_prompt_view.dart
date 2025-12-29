import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myitihas/features/story_generator/domain/entities/story_prompt.dart';

/// Interactive prompt view with tappable highlighted options - inline flow
class InteractivePromptView extends StatelessWidget {
  final StoryPrompt prompt;
  final VoidCallback onScriptureTap;
  final VoidCallback onStoryTypeTap;
  final VoidCallback onThemeTap;
  final VoidCallback onMainCharacterTap;
  final VoidCallback onSettingTap;
  final VoidCallback onRandomize;
  final bool isLoading;

  const InteractivePromptView({
    super.key,
    required this.prompt,
    required this.onScriptureTap,
    required this.onStoryTypeTap,
    required this.onThemeTap,
    required this.onMainCharacterTap,
    required this.onSettingTap,
    required this.onRandomize,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(Icons.auto_stories, color: colorScheme.primary, size: 18.sp),
              SizedBox(width: 6.w),
              Text(
                'Your Story Prompt',
                style: textTheme.titleSmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                ),
              ),
              const Spacer(),
              _RandomizeButton(onTap: onRandomize, isLoading: isLoading),
            ],
          ),
          SizedBox(height: 10.h),
          Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: 14.sp,
                color: colorScheme.onSurface.withValues(alpha: 0.85),
                height: 1.8,
              ),
              children: [
                const TextSpan(text: 'Generate me a story from '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: _InlineOptionChip(
                    label: prompt.scripture ?? 'Select Scripture',
                    isSelected: prompt.scripture != null,
                    onTap: onScriptureTap,
                  ),
                ),
                const TextSpan(text: ' with story type as '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: _InlineOptionChip(
                    label: prompt.storyType ?? 'Select Type',
                    isSelected: prompt.storyType != null,
                    onTap: onStoryTypeTap,
                  ),
                ),
                const TextSpan(text: ' and with '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: _InlineOptionChip(
                    label: prompt.theme ?? 'Select Theme',
                    isSelected: prompt.theme != null,
                    onTap: onThemeTap,
                  ),
                ),
                const TextSpan(text: ' theme, main character as a '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: _InlineOptionChip(
                    label: prompt.mainCharacter ?? 'Select Character',
                    isSelected: prompt.mainCharacter != null,
                    onTap: onMainCharacterTap,
                  ),
                ),
                const TextSpan(text: ' and story setting as in '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: _InlineOptionChip(
                    label: prompt.setting ?? 'Select Setting',
                    isSelected: prompt.setting != null,
                    onTap: onSettingTap,
                  ),
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InlineOptionChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _InlineOptionChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primaryContainer
              : colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary.withValues(alpha: 0.4)
                : colorScheme.outlineVariant.withValues(alpha: 0.4),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dotted,
                decorationColor: isSelected
                    ? colorScheme.primary.withValues(alpha: 0.4)
                    : colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
              ),
            ),
            SizedBox(width: 3.w),
            Icon(
              Icons.edit,
              size: 10.sp,
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

class _RandomizeButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLoading;

  const _RandomizeButton({required this.onTap, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: isLoading
          ? null
          : () {
              HapticFeedback.mediumImpact();
              onTap();
            },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLoading)
              SizedBox(
                width: 14.sp,
                height: 14.sp,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colorScheme.onSecondaryContainer,
                ),
              )
            else
              Icon(
                Icons.casino_rounded,
                size: 14.sp,
                color: colorScheme.onSecondaryContainer,
              ),
            SizedBox(width: 6.w),
            Text(
              'Random',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSecondaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
