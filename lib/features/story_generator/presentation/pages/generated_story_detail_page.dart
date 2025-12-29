import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/i18n/strings.g.dart';
import 'package:share_plus/share_plus.dart';

/// Page for displaying a generated story with save and share options
class GeneratedStoryDetailPage extends StatefulWidget {
  final Story story;

  const GeneratedStoryDetailPage({super.key, required this.story});

  @override
  State<GeneratedStoryDetailPage> createState() =>
      _GeneratedStoryDetailPageState();
}

class _GeneratedStoryDetailPageState extends State<GeneratedStoryDetailPage> {
  bool _isSaved = false;
  bool _showFullStory = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar with gradient
          SliverAppBar(
            expandedHeight: 200.h,
            pinned: true,
            stretch: true,
            backgroundColor: colorScheme.surface,
            leading: IconButton(
              icon: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: colorScheme.surface.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: colorScheme.onSurface,
                ),
              ),
              onPressed: () => context.pop(),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: colorScheme.surface.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.share_rounded,
                    color: colorScheme.onSurface,
                  ),
                ),
                onPressed: _shareStory,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [colorScheme.primary, colorScheme.secondary],
                  ),
                ),
                child: Stack(
                  children: [
                    // Pattern overlay
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.1,
                        child: Image.network(
                          'https://www.transparenttextures.com/patterns/cubes.png',
                          repeat: ImageRepeat.repeat,
                          errorBuilder: (_, __, ___) => const SizedBox(),
                        ),
                      ),
                    ),
                    // Content
                    Positioned(
                      bottom: 60.h,
                      left: 20.w,
                      right: 20.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.auto_awesome,
                                  size: 14.sp,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  'AI Generated',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            widget.story.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(color: Colors.black26, blurRadius: 4),
                              ],
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
          // Story content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Attributes chips
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      _AttributeChip(
                        icon: Icons.book_rounded,
                        label: widget.story.scripture,
                      ),
                      _AttributeChip(
                        icon: Icons.category_rounded,
                        label: widget.story.attributes.storyType,
                      ),
                      _AttributeChip(
                        icon: Icons.lightbulb_rounded,
                        label: widget.story.attributes.theme,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  // Story section
                  _SectionHeader(title: 'Story', icon: Icons.auto_stories),
                  SizedBox(height: 12.h),
                  AnimatedCrossFade(
                    firstChild: Text(
                      widget.story.story.length > 500
                          ? '${widget.story.story.substring(0, 500)}...'
                          : widget.story.story,
                      style: TextStyle(
                        fontSize: 15.sp,
                        height: 1.7,
                        color: colorScheme.onSurface.withValues(alpha: 0.85),
                      ),
                    ),
                    secondChild: Text(
                      widget.story.story,
                      style: TextStyle(
                        fontSize: 15.sp,
                        height: 1.7,
                        color: colorScheme.onSurface.withValues(alpha: 0.85),
                      ),
                    ),
                    crossFadeState: _showFullStory
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  ),
                  if (widget.story.story.length > 500)
                    TextButton(
                      onPressed: () {
                        setState(() => _showFullStory = !_showFullStory);
                      },
                      child: Text(
                        _showFullStory
                            ? t.stories.readLess
                            : t.stories.readMore,
                      ),
                    ),
                  SizedBox(height: 24.h),

                  // Quote section
                  if (widget.story.quotes.isNotEmpty) ...[
                    _QuoteCard(quote: widget.story.quotes),
                    SizedBox(height: 24.h),
                  ],

                  // Lesson section
                  if (widget.story.lesson.isNotEmpty) ...[
                    _SectionHeader(title: 'Lesson', icon: Icons.school_rounded),
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: colorScheme.tertiaryContainer.withValues(
                          alpha: 0.3,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        widget.story.lesson,
                        style: TextStyle(
                          fontSize: 14.sp,
                          height: 1.6,
                          color: colorScheme.onTertiaryContainer,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],

                  // Trivia section
                  if (widget.story.trivia.isNotEmpty) ...[
                    _SectionHeader(
                      title: 'Did You Know?',
                      icon: Icons.tips_and_updates_rounded,
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: colorScheme.secondaryContainer.withValues(
                          alpha: 0.3,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.lightbulb_outline_rounded,
                            color: colorScheme.secondary,
                            size: 20.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              widget.story.trivia,
                              style: TextStyle(
                                fontSize: 14.sp,
                                height: 1.5,
                                color: colorScheme.onSecondaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],

                  // Activity section
                  if (widget.story.activity.isNotEmpty) ...[
                    _SectionHeader(
                      title: 'Activity',
                      icon: Icons.edit_note_rounded,
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer.withValues(
                          alpha: 0.3,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: colorScheme.primary.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Text(
                        widget.story.activity,
                        style: TextStyle(
                          fontSize: 14.sp,
                          height: 1.5,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: _BottomActions(
        isSaved: _isSaved,
        onSave: _saveStory,
        onGenerateAnother: () => context.pop(),
      ),
    );
  }

  void _saveStory() {
    HapticFeedback.mediumImpact();
    setState(() => _isSaved = true);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle_rounded, color: Colors.white),
            SizedBox(width: 12.w),
            Text('Story saved to your library'),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );

    // TODO: Implement actual save to local storage
  }

  void _shareStory() {
    HapticFeedback.lightImpact();
    final shareText =
        '''
${widget.story.title}

${widget.story.story}

---
${widget.story.quotes}

Generated with MyItihas - Discover Indian Mythology
''';

    Share.share(shareText, subject: widget.story.title);
  }
}

class _AttributeChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _AttributeChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: colorScheme.primary),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, size: 20.sp, color: colorScheme.primary),
        SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

class _QuoteCard extends StatelessWidget {
  final String quote;

  const _QuoteCard({required this.quote});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primaryContainer.withValues(alpha: 0.5),
            colorScheme.secondaryContainer.withValues(alpha: 0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Icon(
            Icons.format_quote_rounded,
            size: 32.sp,
            color: colorScheme.primary.withValues(alpha: 0.5),
          ),
          SizedBox(height: 12.h),
          Text(
            quote,
            style: TextStyle(
              fontSize: 15.sp,
              fontStyle: FontStyle.italic,
              height: 1.6,
              color: colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  final bool isSaved;
  final VoidCallback onSave;
  final VoidCallback onGenerateAnother;

  const _BottomActions({
    required this.isSaved,
    required this.onSave,
    required this.onGenerateAnother,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return Container(
      padding: EdgeInsets.fromLTRB(
        16.w,
        12.h,
        16.w,
        12.h + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: isSaved ? null : onSave,
              icon: Icon(
                isSaved ? Icons.check_rounded : Icons.bookmark_add_outlined,
              ),
              label: Text(isSaved ? 'Saved' : t.storyGenerator.saveStory),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: FilledButton.icon(
              onPressed: onGenerateAnother,
              icon: Icon(Icons.add_rounded),
              label: Text('New Story'),
              style: FilledButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
