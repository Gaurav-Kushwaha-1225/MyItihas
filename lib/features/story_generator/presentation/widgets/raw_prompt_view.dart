import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myitihas/features/story_generator/domain/entities/story_prompt.dart';

/// Raw prompt input view with fading hint suggestions
class RawPromptView extends StatefulWidget {
  final StoryPrompt prompt;
  final ValueChanged<String> onPromptChanged;
  final VoidCallback onScriptureTap;
  final VoidCallback onStoryTypeTap;
  final VoidCallback onThemeTap;
  final VoidCallback onMainCharacterTap;
  final VoidCallback onSettingTap;

  const RawPromptView({
    super.key,
    required this.prompt,
    required this.onPromptChanged,
    required this.onScriptureTap,
    required this.onStoryTypeTap,
    required this.onThemeTap,
    required this.onMainCharacterTap,
    required this.onSettingTap,
  });

  @override
  State<RawPromptView> createState() => _RawPromptViewState();
}

class _RawPromptViewState extends State<RawPromptView> {
  late TextEditingController _controller;
  final List<String> _hints = [
    'Tell me a story about Krishna teaching Arjuna...',
    'Write an epic tale of a warrior seeking redemption...',
    'Create a story about the wisdom of the sages...',
    'Narrate the journey of a devoted seeker...',
    'Share the legend of divine intervention...',
  ];
  int _currentHintIndex = 0;
  Timer? _hintTimer;
  bool _showOptions = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.prompt.rawPrompt);
    _startHintRotation();
  }

  @override
  void dispose() {
    _controller.dispose();
    _hintTimer?.cancel();
    super.dispose();
  }

  void _startHintRotation() {
    _hintTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {
          _currentHintIndex = (_currentHintIndex + 1) % _hints.length;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: colorScheme.outlineVariant.withValues(alpha: 0.3),
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 8.h),
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_note_rounded,
                      color: colorScheme.primary,
                      size: 18.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Write Your Prompt',
                      style: textTheme.titleSmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Stack(
                  children: [
                    // Fading hint
                    if (_controller.text.isEmpty)
                      Padding(
                        padding: EdgeInsets.all(8.w),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: Text(
                            _hints[_currentHintIndex],
                            key: ValueKey(_currentHintIndex),
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: colorScheme.onSurface.withValues(
                                alpha: 0.4,
                              ),
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                    // Text field
                    TextField(
                      controller: _controller,
                      maxLines: 5,
                      minLines: 3,
                      onChanged: widget.onPromptChanged,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: colorScheme.onSurface,
                        height: 1.5,
                      ),
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        hintText: '',
                        contentPadding: EdgeInsets.all(4.w),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Divider(
                color: colorScheme.outlineVariant.withValues(alpha: 0.2),
                height: 1,
              ),
              // Optional options toggle
              InkWell(
                onTap: () => setState(() => _showOptions = !_showOptions),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    children: [
                      Icon(
                        Icons.tune_rounded,
                        size: 18.sp,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Optional: Refine with options',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const Spacer(),
                      AnimatedRotation(
                        turns: _showOptions ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Collapsible options
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: _buildOptionalOptions(context),
                crossFadeState: _showOptions
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOptionalOptions(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
      child: Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: [
          _OptionalChip(
            label: widget.prompt.scripture ?? 'Scripture',
            isSelected: widget.prompt.scripture != null,
            onTap: widget.onScriptureTap,
            colorScheme: colorScheme,
          ),
          _OptionalChip(
            label: widget.prompt.storyType ?? 'Story Type',
            isSelected: widget.prompt.storyType != null,
            onTap: widget.onStoryTypeTap,
            colorScheme: colorScheme,
          ),
          _OptionalChip(
            label: widget.prompt.theme ?? 'Theme',
            isSelected: widget.prompt.theme != null,
            onTap: widget.onThemeTap,
            colorScheme: colorScheme,
          ),
          _OptionalChip(
            label: widget.prompt.mainCharacter ?? 'Character',
            isSelected: widget.prompt.mainCharacter != null,
            onTap: widget.onMainCharacterTap,
            colorScheme: colorScheme,
          ),
          _OptionalChip(
            label: widget.prompt.setting ?? 'Setting',
            isSelected: widget.prompt.setting != null,
            onTap: widget.onSettingTap,
            colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }
}

class _OptionalChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final ColorScheme colorScheme;

  const _OptionalChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primaryContainer.withValues(alpha: 0.5)
              : colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary.withValues(alpha: 0.3)
                : colorScheme.outlineVariant.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(width: 4.w),
            Icon(
              isSelected ? Icons.check_circle : Icons.add_circle_outline,
              size: 14.sp,
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
