import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myitihas/features/story_generator/domain/entities/generator_options.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

/// Bottom sheet for selecting additional generator options (language, format, length)
class MoreOptionsBottomSheet extends StatefulWidget {
  final GeneratorOptions currentOptions;

  const MoreOptionsBottomSheet({super.key, required this.currentOptions});

  /// Show the bottom sheet and return updated options
  static Future<GeneratorOptions?> show({
    required BuildContext context,
    required GeneratorOptions currentOptions,
  }) {
    return Navigator.of(context).push<GeneratorOptions>(
      ModalSheetRoute(
        swipeDismissible: true,
        builder: (context) =>
            MoreOptionsBottomSheet(currentOptions: currentOptions),
      ),
    );
  }

  @override
  State<MoreOptionsBottomSheet> createState() => _MoreOptionsBottomSheetState();
}

class _MoreOptionsBottomSheetState extends State<MoreOptionsBottomSheet> {
  late StoryLanguage _language;
  late StoryFormat _format;
  late StoryLength _length;

  @override
  void initState() {
    super.initState();
    _language = widget.currentOptions.language;
    _format = widget.currentOptions.format;
    _length = widget.currentOptions.length;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Sheet(
      scrollConfiguration: const SheetScrollConfiguration(),
      decoration: MaterialSheetDecoration(
        size: SheetSize.stretch,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        clipBehavior: Clip.antiAlias,
        color: colorScheme.surface,
      ),
      snapGrid: SheetSnapGrid(snaps: [SheetOffset(1)]),
      initialOffset: const SheetOffset(1),
      child: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            // Title
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 8.h),
              child: Row(
                children: [
                  Icon(Icons.tune_rounded, color: colorScheme.primary),
                  SizedBox(width: 12.w),
                  Text(
                    'More Options',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
            Divider(color: colorScheme.outlineVariant.withValues(alpha: 0.2)),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Language selection
                    _buildSectionTitle(
                      context,
                      'Language',
                      Icons.language_rounded,
                    ),
                    SizedBox(height: 12.h),
                    _buildLanguageChips(colorScheme),
                    SizedBox(height: 24.h),

                    // Format selection
                    _buildSectionTitle(
                      context,
                      'Story Format',
                      Icons.article_rounded,
                    ),
                    SizedBox(height: 12.h),
                    _buildFormatChips(colorScheme),
                    SizedBox(height: 24.h),

                    // Length selection
                    _buildSectionTitle(
                      context,
                      'Story Length',
                      Icons.straighten_rounded,
                    ),
                    SizedBox(height: 12.h),
                    _buildLengthChips(colorScheme),
                    SizedBox(height: 32.h),

                    // Apply button
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          Navigator.of(context).pop(
                            GeneratorOptions(
                              language: _language,
                              format: _format,
                              length: _length,
                            ),
                          );
                        },
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          'Apply Options',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h + MediaQuery.of(context).padding.bottom,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, size: 18.sp, color: colorScheme.onSurfaceVariant),
        SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageChips(ColorScheme colorScheme) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: StoryLanguage.values.map((lang) {
        final isSelected = lang == _language;
        return ChoiceChip(
          label: Text(lang.displayName),
          selected: isSelected,
          onSelected: (selected) {
            if (selected) {
              HapticFeedback.selectionClick();
              setState(() => _language = lang);
            }
          },
          backgroundColor: colorScheme.surfaceContainerHighest.withValues(
            alpha: 0.5,
          ),
          selectedColor: colorScheme.primaryContainer,
          labelStyle: TextStyle(
            color: isSelected ? colorScheme.primary : colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
            side: BorderSide(
              color: isSelected
                  ? colorScheme.primary.withValues(alpha: 0.5)
                  : Colors.transparent,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFormatChips(ColorScheme colorScheme) {
    return Column(
      children: StoryFormat.values.map((format) {
        final isSelected = format == _format;
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _format = format);
              },
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: isSelected
                      ? colorScheme.primaryContainer.withValues(alpha: 0.5)
                      : colorScheme.surfaceContainerHighest.withValues(
                          alpha: 0.3,
                        ),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isSelected
                        ? colorScheme.primary.withValues(alpha: 0.5)
                        : colorScheme.outlineVariant.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Radio<StoryFormat>(
                      value: format,
                      groupValue: _format,
                      onChanged: (value) {
                        if (value != null) {
                          HapticFeedback.selectionClick();
                          setState(() => _format = value);
                        }
                      },
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            format.displayName,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: isSelected
                                  ? colorScheme.primary
                                  : colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            format.description,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: colorScheme.onSurfaceVariant,
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
      }).toList(),
    );
  }

  Widget _buildLengthChips(ColorScheme colorScheme) {
    return Row(
      children: StoryLength.values.map((length) {
        final isSelected = length == _length;
        final isFirst = length == StoryLength.values.first;
        final isLast = length == StoryLength.values.last;

        return Expanded(
          child: GestureDetector(
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() => _length = length);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? colorScheme.primaryContainer
                    : colorScheme.surfaceContainerHighest.withValues(
                        alpha: 0.5,
                      ),
                borderRadius: BorderRadius.horizontal(
                  left: isFirst ? Radius.circular(12.r) : Radius.zero,
                  right: isLast ? Radius.circular(12.r) : Radius.zero,
                ),
                border: Border.all(
                  color: isSelected
                      ? colorScheme.primary.withValues(alpha: 0.5)
                      : colorScheme.outlineVariant.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    length.displayName,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    length.description,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
