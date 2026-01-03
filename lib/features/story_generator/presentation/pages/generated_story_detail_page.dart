import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/utils/constants.dart';
import 'package:rich_readmore/rich_readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/features/story_generator/domain/usecases/generate_story_image.dart';
import 'package:myitihas/features/story_generator/domain/usecases/update_generated_story.dart';
import 'package:myitihas/core/logging/talker_setup.dart';

/// Page for displaying a generated story with save and share options
class GeneratedStoryDetailPage extends StatefulWidget {
  final Story story;

  const GeneratedStoryDetailPage({super.key, required this.story});

  @override
  State<GeneratedStoryDetailPage> createState() =>
      _GeneratedStoryDetailPageState();
}

class _GeneratedStoryDetailPageState extends State<GeneratedStoryDetailPage> {
  late Story _story;
  bool _isGeneratingImage = false;

  @override
  void initState() {
    super.initState();
    _story = widget.story;
    _initializeData();
  }

  Future<void> _initializeData() async {
    if (_story.imageUrl == null) {
      await _generateImage();
    }

    // Both now use the same upsert logic in the repository
    await _saveOrUpdateStory();
  }

  Future<void> _generateImage() async {
    setState(() {
      _isGeneratingImage = true;
    });

    try {
      final generateImage = getIt<GenerateStoryImage>();
      final result = await generateImage(
        GenerateStoryImageParams(
          title: _story.title,
          story: _story.story,
          moral: _story.lesson,
        ),
      );

      result.fold(
        (failure) {
          talker.error('Failed to generate image: ${failure.message}');
          setState(() {
            _isGeneratingImage = false;
          });
        },
        (imageUrl) {
          if (!mounted) return;
          setState(() {
            imageUrl = imageUrl.split(',')[1];
            _story = _story.copyWith(imageUrl: imageUrl);
            _isGeneratingImage = false;
          });
        },
      );
    } catch (e) {
      talker.error('Error in image generation flow: $e');
      if (mounted) {
        setState(() {
          _isGeneratingImage = false;
        });
      }
    }
  }

  Future<void> _saveOrUpdateStory() async {
    try {
      final upsertStory = getIt<UpdateGeneratedStory>();
      final result = await upsertStory(_story);
      result.fold(
        (failure) => talker.error('Failed to save story: ${failure.message}'),
        (savedStory) {
          talker.info('Story saved/updated successfully');
          if (mounted) {
            setState(() {
              _story = savedStory;
            });
          }
        },
      );
    } catch (e) {
      talker.error('Error saving story: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    bool isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Theme.of(context).primaryColor.withAlpha(5),
                Theme.of(context).brightness == Brightness.dark
                    ? Color(0xFF1E293B)
                    : Color(0xFFF1F5F9),
              ],
              transform: GradientRotation(3.14 / 1.5),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: screenSize.height * 0.115,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                    Spacer(),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        _shareStory();
                      },
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: screenSize.width,
                    height: screenSize.height * 0.4,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.15),
                          blurRadius: 100,
                          spreadRadius: 0,
                          offset: const Offset(0, -6),
                        ),
                      ],
                    ),
                    child: _story.imageUrl != null
                        ? Image.memory(
                            _story.imageUrl != null &&
                                    _story.imageUrl!.split(',').length > 1
                                ? base64Decode(_story.imageUrl!.split(',')[1])
                                : base64Decode(_story.imageUrl!),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                                  "assets/logo.png",
                                  fit: BoxFit.cover,
                                ),
                          )
                        : _isGeneratingImage
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(color: Colors.white),
                                SizedBox(height: 16),
                                Text(
                                  "Painting your story...",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Image.asset(
                            ("assets/logo.png"),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Center(
                                  child: Icon(
                                    Icons.error_outline_rounded,
                                    color: Colors.red.shade200,
                                  ),
                                ),
                          ),
                  ),
                  Container(
                    width: screenSize.width,
                    height: screenSize.height * 0.4,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black, Colors.transparent],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: screenSize.width,
                      height: screenSize.height * 0.3,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (widget.story.attributes.storyType.isNotEmpty)
                                Chip(
                                  padding: EdgeInsets.zero,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  label: Text(
                                    widget.story.attributes.storyType,
                                  ),
                                  labelStyle: Theme.of(
                                    context,
                                  ).textTheme.labelSmall,
                                  visualDensity: VisualDensity.compact,
                                  backgroundColor: Colors.transparent,
                                  side: BorderSide(width: 0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      20,
                                    ),
                                  ),
                                ),
                              SizedBox(width: screenSize.width * 0.02),
                              if (widget.story.attributes.theme.isNotEmpty)
                                Chip(
                                  padding: EdgeInsets.zero,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  label: Text(widget.story.attributes.theme),
                                  labelStyle: Theme.of(
                                    context,
                                  ).textTheme.labelSmall,
                                  visualDensity: VisualDensity.compact,
                                  backgroundColor: Colors.transparent,
                                  side: BorderSide(width: 0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      20,
                                    ),
                                  ),
                                ),

                              SizedBox(width: screenSize.width * 0.02),
                              if (widget
                                  .story
                                  .attributes
                                  .mainCharacterType
                                  .isNotEmpty)
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Chip(
                                    padding: EdgeInsets.zero,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    label: Text(
                                      widget.story.attributes.mainCharacterType,
                                    ),
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                    visualDensity: VisualDensity.compact,
                                    backgroundColor: Colors.transparent,
                                    side: BorderSide(width: 0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(20),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Text(
                            widget.story.title,
                            maxLines: 2,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.005),
                          Text(
                            widget.story.scripture,
                            maxLines: 1,
                            style: theme.textTheme.bodySmall?.copyWith(
                              overflow: TextOverflow.ellipsis,
                              color: isDark
                                  ? DarkColors.textSecondary
                                  : LightColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.005),
                          Row(
                            children: [
                              Text(
                                "By ${_story.authorUser?.displayName ?? _story.author ?? "MyItihas AI StoryTeller"}",
                                maxLines: 1,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  overflow: TextOverflow.ellipsis,
                                  color: isDark
                                      ? DarkColors.textPrimary
                                      : LightColors.textPrimary,
                                ),
                              ),
                              Text(
                                "  •  ",
                                maxLines: 1,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  overflow: TextOverflow.ellipsis,
                                  color: isDark
                                      ? DarkColors.textPrimary
                                      : LightColors.textPrimary,
                                ),
                              ),
                              Text(
                                "${estimateReadingTimeMinutes(widget.story.story)} min read",
                                maxLines: 1,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  overflow: TextOverflow.ellipsis,
                                  color: isDark
                                      ? DarkColors.textPrimary
                                      : LightColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenSize.height * 0.01),
              // Story content
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: RichReadMoreText(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: widget.story.story.isNotEmpty
                            ? widget.story.story[0]
                            : '',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontSize:
                              theme.textTheme.bodyLarge!.fontSize! *
                              2, // bigger
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      TextSpan(
                        text: widget.story.story.length > 1
                            ? widget.story.story.substring(1)
                            : '',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  settings: LineModeSettings(
                    trimLines: 15,
                    trimCollapsedText: '...Read more',
                    trimExpandedText: ' Read less ',
                  ),
                ),
              ),

              // Quotes section
              if (widget.story.quotes.isNotEmpty)
                SizedBox(height: screenSize.height * 0.02),
              if (widget.story.quotes.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Quote\n",
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontSize:
                                theme.textTheme.bodyLarge!.fontSize! *
                                2, // bigger
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        TextSpan(
                          text: widget.story.quotes,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),

              // Trivia section
              if (widget.story.trivia.isNotEmpty)
                SizedBox(height: screenSize.height * 0.02),
              if (widget.story.trivia.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Trivia\n",
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontSize:
                                theme.textTheme.bodyLarge!.fontSize! *
                                2, // bigger
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        TextSpan(
                          text: widget.story.trivia,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),

              // Lesson section
              if (widget.story.lesson.isNotEmpty)
                SizedBox(height: screenSize.height * 0.02),
              if (widget.story.lesson.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Lesson\n",
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontSize:
                                theme.textTheme.bodyLarge!.fontSize! *
                                2, // bigger
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        TextSpan(
                          text: widget.story.lesson,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),

              // Activity section
              if (widget.story.activity.isNotEmpty)
                SizedBox(height: screenSize.height * 0.02),
              if (widget.story.activity.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Activity\n",
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontSize:
                                theme.textTheme.bodyLarge!.fontSize! *
                                2, // bigger
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        TextSpan(
                          text: widget.story.activity,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: screenSize.height * 0.02),
            ],
          ),
        ),
      ),
    );
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

int estimateReadingTimeMinutes(String text, {int wordsPerMinute = 150}) {
  if (text.trim().isEmpty || wordsPerMinute <= 0) {
    return 0;
  }

  final words = text.trim().split(RegExp(r'\s+'));
  final wordCount = words.length;

  return (wordCount / wordsPerMinute).ceil();
}
