// ignore_for_file: unused_element, unused_field

import 'dart:math' as math;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:go_router/go_router.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/core/logging/talker_setup.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/features/story_generator/domain/entities/generator_options.dart';
import 'package:myitihas/features/story_generator/presentation/widgets/generating_overlay.dart';
import 'package:myitihas/features/story_generator/presentation/bloc/story_detail_bloc.dart';
import 'package:myitihas/utils/functions.dart';
import 'package:rich_readmore/rich_readmore.dart';
import 'package:share_plus/share_plus.dart';

class GeneratedStoryDetailPage extends StatefulWidget {
  final Story story;

  const GeneratedStoryDetailPage({super.key, required this.story});

  @override
  State<GeneratedStoryDetailPage> createState() =>
      _GeneratedStoryDetailPageState();
}

class _GeneratedStoryDetailPageState extends State<GeneratedStoryDetailPage> {
  late final StoryDetailBloc _detailBloc;
  final FlutterTts _tts = FlutterTts();
  late final Future<void> _ttsInitFuture;

  String _ttsText = '';
  int _ttsOffset = 0;
  int _utteranceBaseOffset = 0;
  int _maxSpeechInputLength = 3500;
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
    _detailBloc = getIt<StoryDetailBloc>()
      ..add(StoryDetailStarted(widget.story));
    _ttsText = _buildReadAloudText(widget.story);
    _ttsInitFuture = _initializeTts();
  }

  Future<void> _initializeTts() async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.5);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);

    final maxLen = await _tts.getMaxSpeechInputLength;
    if (maxLen is int && maxLen > 0) {
      _maxSpeechInputLength = maxLen;
    }

    _tts.setStartHandler(() {
      setState(() => _isSpeaking = true);
    });

    _tts.setCompletionHandler(() {
      setState(() => _isSpeaking = false);
    });

    _tts.setCancelHandler(() {
      setState(() => _isSpeaking = false);
    });

    _tts.setPauseHandler(() {
      setState(() {
        _isSpeaking = false;
        _isPaused = true;
      });
    });

    _tts.setContinueHandler(() {
      setState(() {
        _isSpeaking = true;
        _isPaused = false;
      });
    });

    _tts.setProgressHandler((String text, int start, int end, String word) {
      final absolute = _utteranceBaseOffset + end;
      _ttsOffset = absolute;
    });
  }

  Future<void> _toggleSpeech(Story story) async {
    await _ttsInitFuture;

    if (_isSpeaking) {
      _ttsRunId++;
      await _tts.pause();
      setState(() {
        _isSpeaking = false;
        _isPaused = true;
      });
      return;
    }

    if (_isPaused) {
      setState(() {
        _isPaused = false;
        _isSpeaking = true;
      });
      _ttsRunId++;
      await _speakFromOffset();
      return;
    }

    _ttsRunId++;
    setState(() {
      _isPaused = false;
      _isSpeaking = true;
    });
    await _speakFromOffset();
  }

  Future<void> _speakFromOffset() async {
    final runId = _ttsRunId;

    _ttsOffset = _skipWhitespace(_ttsText, _ttsOffset);

    while (_ttsOffset < _ttsText.length) {
      if (runId != _ttsRunId) return;

      final chunk = _nextTtsChunk(_ttsText, _ttsOffset, _maxSpeechInputLength);
      _utteranceBaseOffset = _ttsOffset;

      await _tts.speak(chunk);

      while (_isSpeaking) {
        if (runId != _ttsRunId) return;
        await Future.delayed(const Duration(milliseconds: 120));
      }

      if (_isPaused) return;

      _ttsOffset = _utteranceBaseOffset + chunk.length;
      _ttsOffset = _skipWhitespace(_ttsText, _ttsOffset);
    }

    setState(() {
      _isSpeaking = false;
      _isPaused = false;
      _ttsOffset = 0;
    });
  }

  Future<void> _stopSpeech({required bool resetPosition}) async {
    _ttsRunId++;
    await _tts.stop();

    setState(() {
      _isSpeaking = false;
      _isPaused = false;
      if (resetPosition) {
        _ttsOffset = 0;
      }
    });
  }

  @override
  void dispose() {
    _stopSpeech(resetPosition: true);
    _tts.stop();
    _detailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocConsumer<StoryDetailBloc, StoryDetailState>(
      bloc: _detailBloc,
      listenWhen: (prev, curr) =>
          prev.story?.story != curr.story?.story ||
          prev.story?.title != curr.story?.title,
      listener: (context, state) async {
        final story = state.story;
        if (story == null) return;

        await _stopSpeech(resetPosition: true);
        _ttsText = _buildReadAloudText(story);

        if (state.errorMessage != null && context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      builder: (context, state) {
        final story = state.story;

        if (story == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

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
                        isDark
                            ? const Color(0xFF1E293B)
                            : const Color(0xFFF1F5F9),
                      ],
                      transform: const GradientRotation(3.14 / 1.5),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
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
                              message: _isSpeaking
                                  ? 'Pause reading'
                                  : 'Read aloud',
                              child: IconButton(
                                icon: Icon(
                                  _isSpeaking
                                      ? Icons.pause_circle_rounded
                                      : Icons.play_circle_rounded,
                                  size: 28,
                                ),
                                onPressed: () => _toggleSpeech(story),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                story.isFavorite
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                              ),
                              onPressed: () => _detailBloc.add(
                                const StoryDetailToggleFavorite(),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.share),
                              onPressed: () => _shareStory(story),
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
                            child: _buildStoryImage(story, state),
                          ),
                          Container(
                            width: screenSize.width,
                            height: screenSize.height * 0.4,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.black, Colors.transparent],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: _buildStoryMetadata(
                              story,
                              screenSize,
                              theme,
                              isDark,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: screenSize.height * 0.01),

                      // Story content (Chapters)
                      _buildStoryContent(state, screenSize, theme),

                      // Bottom actions
                      _buildBottomActionButtons(state, story, theme, isDark),

                      SizedBox(height: screenSize.height * 0.02),

                      // Language selector (BLoC)
                      _buildLanguageSelector(state, theme, isDark),

                      SizedBox(height: screenSize.height * 0.02),

                      // Story Insights & Interactions
                      _buildStoryInsightsSection(
                        state,
                        theme,
                        isDark,
                        screenSize,
                      ),

                      SizedBox(height: screenSize.height * 0.03),
                    ],
                  ),
                ),
              ),
              if (state.isRegenerating)
                const GeneratingOverlay(message: "Regenerating your story..."),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStoryImage(Story story, StoryDetailState state) {
    if (story.imageUrl != null) {
      return Image.memory(
        base64Decode(
          story.imageUrl!.split(',').length > 1
              ? story.imageUrl!.split(',')[1]
              : story.imageUrl!,
        ),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            Image.asset("assets/logo.png", fit: BoxFit.cover),
      );
    } else if (state.isGeneratingImage) {
      return const Center(
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
      );
    }
    return Image.asset("assets/logo.png", fit: BoxFit.cover);
  }

  Widget _buildStoryMetadata(
    Story story,
    Size screenSize,
    ThemeData theme,
    bool isDark,
  ) {
    return Container(
      width: screenSize.width,
      height: screenSize.height * 0.3,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (story.attributes.storyType.isNotEmpty)
                Chip(
                  label: Text(story.attributes.storyType),
                  labelStyle: theme.textTheme.labelSmall,
                  visualDensity: VisualDensity.compact,
                ),
              SizedBox(width: screenSize.width * 0.02),
              if (story.attributes.theme.isNotEmpty)
                Chip(
                  label: Text(story.attributes.theme),
                  labelStyle: theme.textTheme.labelSmall,
                  visualDensity: VisualDensity.compact,
                ),
            ],
          ),
          Text(
            story.title,
            maxLines: 2,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: screenSize.height * 0.005),
          Text(
            story.scripture,
            maxLines: 1,
            style: theme.textTheme.bodySmall?.copyWith(
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: screenSize.height * 0.005),
          Row(
            children: [
              Text(
                "By ${story.authorUser?.displayName ?? story.author ?? 'MyItihas AI'}",
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStoryContent(
    StoryDetailState state,
    Size screenSize,
    ThemeData theme,
  ) {
    final story = state.story!;
    final chaptersToShow = state.chapters.take(state.visibleChapters).toList();

    return Column(
      children: [
        // Chapters list
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < chaptersToShow.length; i++) ...[
                _buildChapterCard(
                  chapter: chaptersToShow[i],
                  theme: theme,
                  isLastVisible: i == chaptersToShow.length - 1,
                  canReadMore: true,
                  numberOfChapters: chaptersToShow.length,
                ),
                SizedBox(height: screenSize.height * 0.02),
              ],
            ],
          ),
        ),

        // Trivia section
        if (story.trivia.isNotEmpty) ...[
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
                    text: story.trivia,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],

        // Lesson section
        if (story.lesson.isNotEmpty) ...[
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
                    text: story.lesson,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],

        if (story.attributes.references.isNotEmpty) ...[
          SizedBox(height: screenSize.height * 0.01),
          const Divider(),
          SizedBox(height: screenSize.height * 0.01),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: story.attributes.references[0],
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],

        SizedBox(height: screenSize.height * 0.02),
      ],
    );
  }

  Widget _buildChapterCard({
    required StoryChapter chapter,
    required ThemeData theme,
    required bool isLastVisible,
    required bool canReadMore,
    required int numberOfChapters,
  }) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (numberOfChapters > 1)
          Text(
            chapter.title,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: theme.textTheme.bodyLarge!.fontSize! * 2,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        SizedBox(height: screenSize.height * 0.01),
        if (numberOfChapters == 1)
          RichReadMoreText(
            TextSpan(
              text: chapter.content[0],
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: theme.textTheme.bodyLarge!.fontSize! * 2,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
              children: [
                TextSpan(
                  text: chapter.content.substring(1),
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
            settings: LineModeSettings(
              trimLines: 14,
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
        if (numberOfChapters != 1)
          RichReadMoreText(
            TextSpan(
              text: chapter.content
                  .replaceAll(RegExp(r'---[^-]*---  \n\n'), '')
                  .replaceAll(RegExp(r'  \n\n---'), ''),
              style: theme.textTheme.bodyMedium,
            ),
            settings: LineModeSettings(
              trimLines: 14,
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
      ],
    );
  }

  Widget _buildLanguageSelector(
    StoryDetailState state,
    ThemeData theme,
    bool isDark,
  ) {
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
            value: state.selectedLanguage,
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
                _detailBloc.add(StoryDetailLanguageChanged(newValue));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStoryInsightsSection(
    StoryDetailState state,
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
            buttonText: state.isExpanding ? 'Continuing...' : 'Continue Story',
            onTap: state.isExpanding
                ? null
                : () => _detailBloc.add(const StoryDetailReadMorePressed()),
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
            onTap: null,
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
            onTap: null,
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
    required VoidCallback? onTap,
    required Size screenSize,
    bool showDropdown = false,
  }) {
    final story = _detailBloc.state.story;
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
          if (showDropdown && story != null) ...[
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
                  items: story.attributes.characters.map((char) {
                    return DropdownMenuItem<String>(
                      value: char,
                      child: Text(char, style: theme.textTheme.bodySmall),
                    );
                  }).toList(),
                  onChanged: (_) {},
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

  Widget _buildBottomActionButtons(
    StoryDetailState state,
    Story story,
    ThemeData theme,
    bool isDark,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            Icons.refresh_rounded,
            () => _detailBloc.add(const StoryDetailRegenerateRequested()),
            isDark,
            isSelected: state.isRegenerating,
          ),
          _buildActionButton(
            Icons.download_rounded,
            () async {
              if (state.isDownloading) return;

              _detailBloc.add(const StoryDetailDownloadStatusChanged(true));

              final completeStory =
                  '''
${story.title}

${story.story}

---
${story.quotes}

Generated with MyItihas - Discover Indian Mythology
                ''';

              await downloadTextFile(
                textContent: completeStory,
                fileName: story.title,
                onStatusChange: (message, color) {
                  talker.info(message);
                  _detailBloc.add(
                    const StoryDetailDownloadStatusChanged(false),
                  );
                },
              );
            },
            isDark,
            isSelected: state.isDownloading,
          ),
          _buildActionButton(Icons.content_copy_rounded, () {
            final completeStory =
                '''
${story.title}

${story.story}

---
${story.quotes}

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

  void _shareStory(Story story) {
    HapticFeedback.lightImpact();
    final shareText =
        '''
${story.title}

${story.story}

---
${story.quotes}

Generated with MyItihas - Discover Indian Mythology
''';

    Share.share(shareText, subject: story.title);
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
  final moral = (s.lesson).trim();

  final parts = <String>[
    if (title.isNotEmpty) title,
    if (story.isNotEmpty) story,
    if (moral.isNotEmpty) moral,
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

  int cut = window.lastIndexOf('\n');
  if (cut < 0) {
    final matches = RegExp(r'[.!?]\s').allMatches(window).toList();
    if (matches.isNotEmpty) {
      cut = matches.last.start + 1;
    }
  }
  if (cut < 0) cut = window.lastIndexOf(' ');

  if (cut > 200) {
    end = start + cut + 1;
  }

  return text.substring(start, end);
}
