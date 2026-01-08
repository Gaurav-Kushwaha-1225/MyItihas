// ignore_for_file: unused_element, unused_field

import 'dart:math' as math;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:go_router/go_router.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/features/story_generator/domain/entities/generator_options.dart';
import 'package:myitihas/features/story_generator/presentation/widgets/generating_overlay.dart';
import 'package:myitihas/utils/functions.dart';
import 'package:rich_readmore/rich_readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/features/story_generator/domain/usecases/generate_story_image.dart';
import 'package:myitihas/features/story_generator/domain/usecases/update_generated_story.dart';
import 'package:myitihas/features/story_generator/domain/usecases/regenerate_story.dart';
import 'package:myitihas/features/story_generator/domain/repositories/story_generator_repository.dart';
import 'package:myitihas/features/story_generator/domain/entities/story_prompt.dart';
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
  bool _isRegenerating = false;
  String? selectedLanguage;
  bool _isDownloading = false;
  final FlutterTts _tts = FlutterTts();

  late final Future<void> _ttsInitFuture;

  // The exact text we are reading right now
  String _ttsText = '';

  // Current position (character offset) in _ttsText
  int _ttsOffset = 0;

  // Base offset of the currently spoken chunk inside _ttsText
  int _utteranceBaseOffset = 0;

  // Chunk size (Android can tell us the true max; fallback works cross-platform)
  int _maxSpeechInputLength = 3500;

  // Used to cancel an in-flight speak loop when user pauses/stops
  int _ttsRunId = 0;

  bool _isPaused = false;
  bool _isSpeaking = false;

  final List<Map<String, String>> languages = StoryLanguage.values.map((lang) {
    return {
      'name': "${lang.name[0].toUpperCase()}${lang.name.substring(1)}",
      'code': lang.code,
    };
  }).toList();

  @override
  void initState() {
    super.initState();
    _story = widget.story;

    _ttsText = _buildReadAloudText(_story);

    _initializeData();
    selectedLanguage = _story.attributes.languageStyle;

    _ttsInitFuture = _initializeTts();
  }

  Future<void> _initializeTts() async {
    await _tts.setLanguage('en-US');
    await _tts.setPitch(1.0);
    await _tts.setSpeechRate(0.5);

    // IMPORTANT: allows us to await speak completion so we can queue chunks safely
    await _tts.awaitSpeakCompletion(true);

    // Try to get Android max input length (safe to fail on iOS/web/etc)
    try {
      final v = await _tts.getMaxSpeechInputLength;
      if (v is int && v > 0) {
        _maxSpeechInputLength = v;
      }
    } catch (_) {
      // ignore
    }

    // Progress is per-utterance (chunk), so we convert it into global offsets
    _tts.setProgressHandler((String text, int start, int end, String word) {
      final global = (_utteranceBaseOffset + end).clamp(0, _ttsText.length);
      if (global > _ttsOffset) {
        _ttsOffset = global;
      }
    });

    _tts.setStartHandler(() {
      if (!mounted) return;
      setState(() {
        _isSpeaking = true;
        _isPaused = false;
      });
    });

    // Don't set _isSpeaking=false here, because we speak multiple chunks sequentially.
    _tts.setCompletionHandler(() {});

    _tts.setCancelHandler(() {
      if (!mounted) return;
      setState(() {
        _isSpeaking = false;
      });
    });

    _tts.setErrorHandler((msg) {
      talker.error('TTS error: $msg');
      if (!mounted) return;
      setState(() {
        _isSpeaking = false;
        _isPaused = false;
      });
    });
  }

  Future<void> _toggleSpeech() async {
    await _ttsInitFuture;

    // Always build from the latest story shown on screen
    final newText = _buildReadAloudText(_story);

    // If story content changed, reset to start (your requirement)
    if (newText != _ttsText) {
      await _stopSpeech(resetPosition: true);
      _ttsText = newText;
    }

    if (_isSpeaking) {
      await _pauseSpeech();
      return;
    }

    // If we reached the end previously, restart from beginning
    if (_ttsOffset >= _ttsText.length) {
      _ttsOffset = 0;
    }

    await _speakFrom(_ttsOffset);
  }

  Future<void> _stopSpeech({bool resetPosition = false}) async {
    _ttsRunId++; // cancels any running speak loop
    await _tts.stop();

    if (!mounted) return;
    setState(() {
      _isSpeaking = false;
      _isPaused = false;
      if (resetPosition) _ttsOffset = 0;
    });
  }

  Future<void> _pauseSpeech() async {
    // We use stop() for a reliable pause across engines,
    // then resume by speaking from _ttsOffset.
    _ttsRunId++;
    await _tts.stop();

    if (!mounted) return;
    setState(() {
      _isSpeaking = false;
      _isPaused = true;
    });
  }

  Future<void> _speakFrom(int startOffset) async {
    final runId = ++_ttsRunId;

    if (!mounted) return;
    setState(() {
      _isSpeaking = true;
      _isPaused = false;
    });

    var pos = startOffset.clamp(0, _ttsText.length);

    try {
      while (pos < _ttsText.length && runId == _ttsRunId) {
        pos = _skipWhitespace(_ttsText, pos);
        if (pos >= _ttsText.length) break;

        final chunk = _nextTtsChunk(_ttsText, pos, _maxSpeechInputLength);

        _utteranceBaseOffset = pos;

        await _tts.speak(chunk);

        if (runId != _ttsRunId) return;

        // Ensure we advance even if some engines don't fire progress perfectly
        final expected = (pos + chunk.length).clamp(0, _ttsText.length);
        if (_ttsOffset < expected) _ttsOffset = expected;

        pos = _ttsOffset;
      }
    } catch (e) {
      talker.error('TTS speak loop error: $e');
    } finally {
      if (mounted && runId == _ttsRunId) {
        setState(() {
          _isSpeaking = false;
          _isPaused = false;
        });
      }
    }
  }

  Future<void> _initializeData() async {
    if (_story.imageUrl == null) {
      await _generateImage();
      // Both now use the same upsert logic in the repository
      await _saveOrUpdateStory();
    }
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

  Future<void> _regenerateStory() async {
    if (_isRegenerating) return;
    setState(() {
      _isRegenerating = true;
    });

    try {
      final regen = RegenerateStory(getIt<StoryGeneratorRepository>());

      final prompt = StoryPrompt(
        scripture: _story.scripture.isNotEmpty ? _story.scripture : null,
        storyType: _story.attributes.storyType.isNotEmpty
            ? _story.attributes.storyType
            : null,
        theme: _story.attributes.theme.isNotEmpty
            ? _story.attributes.theme
            : null,
        mainCharacter: _story.attributes.mainCharacterType.isNotEmpty
            ? _story.attributes.mainCharacterType
            : null,
        setting: _story.attributes.storySetting.isNotEmpty
            ? _story.attributes.storySetting
            : null,
        isRawPrompt: false,
      );

      final options = GeneratorOptions(
        language: StoryLanguage.values.firstWhere(
          (lang) =>
              lang.name.toLowerCase() ==
              selectedLanguage?.toLowerCase().replaceAll(' ', ''),
          orElse: () => StoryLanguage.english,
        ),
        length: _story.attributes.storyLength.isNotEmpty
            ? StoryLength.values.firstWhere(
                (len) =>
                    len.name.toLowerCase() ==
                    _story.attributes.storyLength.toLowerCase(),
                orElse: () => StoryLength.medium,
              )
            : StoryLength.medium,
        format: _story.attributes.narrativeStyle.isNotEmpty
            ? StoryFormat.values.firstWhere(
                (fmt) =>
                    fmt.name.toLowerCase() ==
                    _story.attributes.narrativeStyle.toLowerCase(),
                orElse: () => StoryFormat.narrative,
              )
            : StoryFormat.narrative,
      );

      final result = await regen(
        RegenerateStoryParams(
          original: _story,
          prompt: prompt,
          options: options,
        ),
      );

      result.fold(
        (failure) {
          talker.error('Regenerate failed: ${failure.message}');
        },
        (generated) async {
          await _stopSpeech(resetPosition: true);
          if (!mounted) return;

          setState(() {
            _story = generated;
            _ttsText = _buildReadAloudText(_story); // new story => new TTS text
          });

          await _generateImage();
          await _saveOrUpdateStory();
        },
      );
    } catch (e) {
      talker.error('Error during regenerate: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isRegenerating = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _stopSpeech(resetPosition: true);
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    bool isDark = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Theme.of(context).primaryColor.withAlpha(5),
                    Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF1E293B)
                        : const Color(0xFFF1F5F9),
                  ],
                  transform: GradientRotation(3.14 / 1.5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with back and share
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
                          onPressed: () => context.pop(),
                        ),
                        const Spacer(),
                        Tooltip(
                          message: _isSpeaking ? 'Pause reading' : 'Read aloud',
                          child: IconButton(
                            icon: Icon(
                              _isSpeaking
                                  ? Icons.pause_circle_rounded
                                  : Icons.play_circle_rounded,
                              size: 28,
                            ),
                            onPressed: _toggleSpeech,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _story.isFavorite
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                          ),
                          onPressed: () async {
                            setState(() {
                              _story = _story.copyWith(
                                isFavorite: !_story.isFavorite,
                              );
                            });
                            await _saveOrUpdateStory();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.share),
                          onPressed: _shareStory,
                        ),
                      ],
                    ),
                  ),

                  // Story image with overlay
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
                        child: _buildStoryImage(),
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
                        child: _buildStoryMetadata(screenSize, theme, isDark),
                      ),
                    ],
                  ),

                  SizedBox(height: screenSize.height * 0.01),

                  // Story content sections
                  _buildStoryContent(screenSize, theme),

                  // Bottom Action Buttons
                  _buildBottomActionButtons(theme, isDark),
                  SizedBox(height: screenSize.height * 0.02),

                  // Language selector
                  _buildLanguageSelector(theme, isDark),
                  SizedBox(height: screenSize.height * 0.02),

                  // Story Insights & Interactions
                  _buildStoryInsightsSection(theme, isDark, screenSize),

                  SizedBox(height: screenSize.height * 0.03),
                ],
              ),
            ),
          ),
          if (_isRegenerating)
            GeneratingOverlay(message: "Regenerating your story..."),
        ],
      ),
    );
  }

  Widget _buildStoryImage() {
    if (_story.imageUrl != null) {
      return Image.memory(
        base64Decode(
          _story.imageUrl!.split(',').length > 1
              ? _story.imageUrl!.split(',')[1]
              : _story.imageUrl!,
        ),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            Image.asset("assets/logo.png", fit: BoxFit.cover),
      );
    } else if (_isGeneratingImage) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: Colors.white),
            const SizedBox(height: 16),
            Text(
              "Painting your story...",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }
    return Image.asset("assets/logo.png", fit: BoxFit.cover);
  }

  Widget _buildStoryMetadata(Size screenSize, ThemeData theme, bool isDark) {
    return Container(
      width: screenSize.width,
      height: screenSize.height * 0.3,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chips for attributes
          Row(
            children: [
              if (widget.story.attributes.storyType.isNotEmpty)
                Chip(
                  label: Text(widget.story.attributes.storyType),
                  labelStyle: theme.textTheme.labelSmall,
                  visualDensity: VisualDensity.compact,
                ),
              SizedBox(width: screenSize.width * 0.02),
              if (widget.story.attributes.theme.isNotEmpty)
                Chip(
                  label: Text(widget.story.attributes.theme),
                  labelStyle: theme.textTheme.labelSmall,
                  visualDensity: VisualDensity.compact,
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
            ),
          ),
          SizedBox(height: screenSize.height * 0.005),
          Row(
            children: [
              Text(
                "By ${_story.authorUser?.displayName ?? _story.author ?? 'MyItihas AI'}",
                style: theme.textTheme.bodyMedium,
              ),
              // Text(" • ", style: theme.textTheme.bodyMedium),
              // Text(
              //   "${estimateReadingTimeMinutes(_story.story).toString()} min read",
              //   style: theme.textTheme.bodyMedium,
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStoryContent(Size screenSize, ThemeData theme) {
    return Column(
      children: [
        // Main story
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: RichReadMoreText(
            TextSpan(
              children: [
                TextSpan(
                  text: _story.story.isNotEmpty ? _story.story[0] : '',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: theme.textTheme.bodyLarge!.fontSize! * 2,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                TextSpan(
                  text: _story.story.length > 1
                      ? _story.story.substring(1)
                      : '',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
            settings: LineModeSettings(
              trimLines: 15,
              trimCollapsedText: "read more",
              trimExpandedText: "read less",
              textAlign: TextAlign.justify,
              moreStyle: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              lessStyle: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // // Trivia section
        if (_story.trivia.isNotEmpty) ...[
          SizedBox(height: screenSize.height * 0.02),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Trivia\n',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontSize: theme.textTheme.bodyLarge!.fontSize! * 2,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  TextSpan(
                    text: _story.trivia,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],

        // Lesson section
        if (_story.lesson.isNotEmpty) ...[
          SizedBox(height: screenSize.height * 0.02),
          Container(
            width: screenSize.width,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Moral\n',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontSize: theme.textTheme.bodyLarge!.fontSize! * 2,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  TextSpan(
                    text: _story.lesson,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],

        if (_story.attributes.references.isNotEmpty) ...[
          SizedBox(height: screenSize.height * 0.01),
          Divider(),
          SizedBox(height: screenSize.height * 0.01),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: RichText(
              text: TextSpan(
                children: [
                  // TextSpan(
                  //   text: 'Source\n',
                  //   style: theme.textTheme.bodyMedium!.copyWith(
                  //     fontSize: theme.textTheme.bodyLarge!.fontSize! * 2,
                  //     fontWeight: FontWeight.bold,
                  //     color: theme.colorScheme.primary,
                  //   ),
                  // ),
                  TextSpan(
                    text: _story.attributes.references[0],
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],

        // Activity section
        // if (_story.activity.isNotEmpty) ...[
        //   SizedBox(height: screenSize.height * 0.02),
        //   Container(
        //     padding: const EdgeInsets.symmetric(horizontal: 10),
        //     child: RichText(
        //       text: TextSpan(
        //         children: [
        //           TextSpan(
        //             text: 'Activities\n',
        //             style: theme.textTheme.bodyMedium!.copyWith(
        //               fontSize: theme.textTheme.bodyLarge!.fontSize! * 2,
        //               fontWeight: FontWeight.bold,
        //               color: theme.colorScheme.primary,
        //             ),
        //           ),
        //           TextSpan(
        //             text: _story.activity,
        //             style: theme.textTheme.bodyMedium,
        //           ),
        //         ],
        //       ),
        //       textAlign: TextAlign.justify
        //     ),
        //   ),
        // ],
        SizedBox(height: screenSize.height * 0.02),
      ],
    );
  }

  Widget _buildLanguageSelector(ThemeData theme, bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E293B).withOpacity(0.5)
            : Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.05),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.translate, size: 18, color: theme.colorScheme.primary),
              const SizedBox(width: 12),
              Text(
                'Translation',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          DropdownButton<String>(
            value: selectedLanguage,
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: theme.colorScheme.primary,
            ),
            underline: const SizedBox(),
            borderRadius: BorderRadius.circular(15),
            dropdownColor: isDark ? const Color(0xFF1E293B) : Colors.white,
            items: languages.map((lang) {
              return DropdownMenuItem<String>(
                value: lang['name'],
                child: Text(lang['name']!, style: theme.textTheme.bodyMedium),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() => selectedLanguage = newValue);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStoryInsightsSection(
    ThemeData theme,
    bool isDark,
    Size screenSize,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Story Insights & Interactions',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenSize.height * 0.02),
          _buildInsightCard(
            theme: theme,
            isDark: isDark,
            icon: Icons.zoom_out_map_rounded,
            title: 'Expand Story',
            description:
                'Continue the narrative with the next chapter of your tale',
            buttonText: 'Continue Story',
            onTap: () {},
            screenSize: screenSize,
          ),
          SizedBox(height: screenSize.height * 0.02),
          _buildInsightCard(
            theme: theme,
            isDark: isDark,
            icon: Icons.person_pin_rounded,
            title: 'Character Details',
            description:
                'Explore the personalities and roles of story characters',
            buttonText: 'Get Details',
            showDropdown: true,
            onTap: () {},
            screenSize: screenSize,
          ),
          SizedBox(height: screenSize.height * 0.02),
          _buildInsightCard(
            theme: theme,
            isDark: isDark,
            icon: Icons.forum_rounded,
            title: 'Discuss Story',
            description: 'Chat about themes, meanings, and interpretations',
            buttonText: 'Start Discussion',
            onTap: () {},
            screenSize: screenSize,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard({
    required ThemeData theme,
    required bool isDark,
    required IconData icon,
    required String title,
    required String description,
    required String buttonText,
    required VoidCallback onTap,
    required Size screenSize,
    bool showDropdown = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B).withOpacity(0.3) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.05)
              : Colors.black.withOpacity(0.05),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 32, color: const Color(0xFFA78BFA)),
          SizedBox(height: screenSize.height * 0.01),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenSize.height * 0.005),
          Text(
            description,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.secondaryHeaderColor,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: screenSize.height * 0.01),
          if (showDropdown) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: isDark ? Colors.black26 : Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.1),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Text(
                    'Select character',
                    style: theme.textTheme.bodySmall,
                  ),
                  iconSize: 18,
                  value: null,
                  items: _story.attributes.characters.map((char) {
                    return DropdownMenuItem<String>(
                      value: char,
                      child: Text(char, style: theme.textTheme.bodySmall),
                    );
                  }).toList(),
                  onChanged: (v) {},
                ),
              ),
            ),
            SizedBox(height: screenSize.height * 0.01),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              height: screenSize.height * 0.05,
              decoration: BoxDecoration(
                color: isDark ? Colors.black26 : Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.1),
                ),
              ),
              alignment: Alignment.center,
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  hintText: 'Or enter character',
                  hintStyle: theme.textTheme.bodySmall?.copyWith(fontSize: 10),
                  border: InputBorder.none,
                  isDense: true,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                ),
                style: theme.textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 12),
          ],
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00B4DB), Color(0xFF9055FF)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              child: Text(
                buttonText,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionButtons(ThemeData theme, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            Icons.refresh_rounded,
            () async {
              if (_isRegenerating) return;
              await _regenerateStory();
            },
            isDark,
            isSelected: _isRegenerating,
          ),
          _buildActionButton(Icons.download_rounded, () async {
            // Download story
            if (_isDownloading) return;
            _isDownloading = true;
            final completeStory =
                '''
${widget.story.title}

${widget.story.story}

---
${_story.quotes}

Generated with MyItihas - Discover Indian Mythology
                ''';
            await downloadTextFile(
              textContent: completeStory,
              fileName: _story.title,
              onStatusChange: (message, color) {
                setState(() {
                  print(message);
                  _isDownloading = false;
                });
              },
            );
          }, isDark),
          _buildActionButton(Icons.content_copy_rounded, () {
            // Copy to clipboard
            final completeStory =
                '''
${widget.story.title}

${widget.story.story}

---
${_story.quotes}

Generated with MyItihas - Discover Indian Mythology
                ''';
            Clipboard.setData(ClipboardData(text: completeStory));
          }, isDark),
          _buildActionButton(Icons.publish_rounded, () {}, isDark),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    VoidCallback onTap,
    bool isDark, {
    bool isSelected = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark
                    ? Colors.white.withOpacity(0.15)
                    : Colors.black.withOpacity(0.1))
              : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.05),
          ),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isDark ? Colors.white : Colors.black87,
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
${_story.quotes}

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

String _buildReadAloudText(Story s) {
  final title = s.title.trim();
  final story = s.story.trim();
  final quotes = (s.quotes).trim();

  final parts = <String>[
    if (title.isNotEmpty) title,
    if (story.isNotEmpty) story,
    if (quotes.isNotEmpty) '---\n$quotes',
  ];

  return parts.join('\n\n');
}

int _skipWhitespace(String text, int pos) {
  while (pos < text.length && RegExp(r'\s').hasMatch(text[pos])) {
    pos++;
  }
  return pos;
}

String _nextTtsChunk(String text, int start, int maxLen) {
  final remaining = text.length - start;
  final take = math.min(maxLen, remaining);

  var end = start + take;
  if (end >= text.length) return text.substring(start);

  final window = text.substring(start, end);

  // Prefer paragraph breaks, then sentence ends, then spaces
  int cut = window.lastIndexOf('\n');
  if (cut < 0) {
    final matches = RegExp(r'[.!?]\s').allMatches(window).toList();
    if (matches.isNotEmpty) {
      cut = matches.last.start + 1; // keep punctuation
    }
  }
  if (cut < 0) cut = window.lastIndexOf(' ');

  // Avoid tiny chunks
  if (cut > 200) {
    end = start + cut + 1;
  }

  return text.substring(start, end);
}
