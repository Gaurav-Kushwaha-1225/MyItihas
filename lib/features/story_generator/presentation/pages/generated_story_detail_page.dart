// ignore_for_file: unused_element, unused_field

import 'dart:math' as math;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/core/logging/talker_setup.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/features/story_generator/domain/entities/generator_options.dart';
import 'package:myitihas/features/story_generator/presentation/widgets/generating_overlay.dart';
import 'package:myitihas/features/story_generator/presentation/bloc/story_detail_bloc.dart';
import 'package:myitihas/features/story_generator/presentation/bloc/story_tts_cubit.dart';
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
  bool isTranslated = false;

  late final StoryTtsCubit _ttsCubit;
  String? selectedCharacter;
  late final TextEditingController selectedCharacterController;

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
    selectedCharacterController = TextEditingController();

    _ttsCubit = StoryTtsCubit();
    final baseLangCode = languageNameToCode(
      widget.story.attributes.languageStyle,
    );
    _ttsCubit.initialize(language: ttsLocaleForLangCode(baseLangCode));

    _ttsCubit.setText(_buildReadAloudText(widget.story), stopIfSpeaking: false);
  }

  Future<void> _toggleSpeech() => _ttsCubit.toggle();

  @override
  void dispose() {
    selectedCharacterController.dispose();
    _ttsCubit.close();
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
          prev.story?.title != curr.story?.title ||
          prev.selectedLanguage != curr.selectedLanguage,
      listener: (context, state) async {
        final story = state.story;
        if (story == null) return;

        final selectedCode = languageNameToCode(state.selectedLanguage);
        final hasTranslation = story.attributes.translations.containsKey(
          selectedCode,
        );

        final effectiveCode = hasTranslation
            ? selectedCode
            : languageNameToCode(story.attributes.languageStyle);

        await _ttsCubit.setLanguageByCode(effectiveCode);
        await _ttsCubit.setText(_buildReadAloudTextForState(story, state));

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
                            BlocBuilder<StoryTtsCubit, StoryTtsState>(
                              bloc: _ttsCubit,
                              builder: (context, ttsState) {
                                return Tooltip(
                                  message: ttsState.isSpeaking
                                      ? 'Pause reading'
                                      : 'Read aloud',
                                  child: IconButton(
                                    icon: Icon(
                                      ttsState.isSpeaking
                                          ? Icons.pause_circle_rounded
                                          : Icons.play_circle_rounded,
                                      size: 28,
                                    ),
                                    onPressed: () => _toggleSpeech(),
                                  ),
                                );
                              },
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
                              state,
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
                        context,
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
              if (state.isTranslating)
                const GeneratingOverlay(message: "Translating your story..."),
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
    dynamic state,
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
            isTranslated
                ? story
                          .attributes
                          .translations[languageNameToCode(
                            state.selectedLanguage,
                          )]
                          ?.title ??
                      story.title
                : story.title,
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
                    text: isTranslated
                        ? story
                                  .attributes
                                  .translations[languageNameToCode(
                                    state.selectedLanguage,
                                  )]
                                  ?.moral ??
                              story.lesson
                        : story.lesson,
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
            onChanged: state.isTranslating
                ? null
                : (String? newValue) {
                    if (newValue != null) {
                      _detailBloc.add(StoryDetailLanguageChanged(newValue));
                      isTranslated = true;
                    }
                  },
          ),
        ],
      ),
    );
  }

  Widget _buildStoryInsightsSection(
    BuildContext context,
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
          _buildCharacterDetailsCard(
            state: state,
            theme: theme,
            isDark: isDark,
            screenSize: screenSize,
            context: context,
          ),
          SizedBox(height: screenSize.height * 0.02),
          _buildInsightCard(
            theme: theme,
            isDark: isDark,
            icon: Icons.forum_rounded,
            title: 'Discuss Story',
            description: 'Chat about themes, meanings, and interpretations',
            buttonText: 'Start Discussion',
            onTap: () => _openDiscussStoryBottomSheet(
              context,
              theme: theme,
              isDark: isDark,
            ),
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

  Widget _buildCharacterDetailsCard({
    required BuildContext context,
    required StoryDetailState state,
    required ThemeData theme,
    required bool isDark,
    required Size screenSize,
  }) {
    final story = state.story;
    final characters = story?.attributes.characters ?? const <String>[];
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
          const Icon(
            Icons.person_pin_rounded,
            size: 32,
            color: Color(0xFFA78BFA),
          ),
          SizedBox(height: screenSize.height * 0.005),
          Text(
            'Character Details',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: screenSize.height * 0.01),
          Text(
            'Explore the personalities and roles of story characters',
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.secondaryHeaderColor,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: screenSize.height * 0.01),
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
                value: selectedCharacter,
                items: characters.map((char) {
                  return DropdownMenuItem<String>(
                    value: char,
                    child: Text(char, style: theme.textTheme.bodySmall),
                  );
                }).toList(),
                onChanged: (char) {
                  setState(() {
                    selectedCharacter = char;
                    selectedCharacterController.text = char ?? '';
                  });
                },
              ),
            ),
          ),
          SizedBox(height: screenSize.height * 0.01),
          Container(
            height: screenSize.height * 0.06,
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
              controller: selectedCharacterController,
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                hintText: 'Or enter character',
                hintStyle: theme.textTheme.bodySmall,
                border: InputBorder.none,
                isDense: true,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
              ),
              autofocus: false,
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00B4DB), Color(0xFF9055FF)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ElevatedButton(
              onPressed:
                  (selectedCharacter != null ||
                      selectedCharacterController.text.isNotEmpty)
                  ? () => _openCharacterDetailsBottomSheet(
                      context,
                      characterName:
                          selectedCharacter ?? selectedCharacterController.text,
                      theme: theme,
                      isDark: isDark,
                    )
                  : () => {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              child: Text(
                'Get Character Details',
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

  Future<void> _openCharacterDetailsBottomSheet(
    BuildContext context, {
    required String characterName,
    required ThemeData theme,
    required bool isDark,
  }) async {
    HapticFeedback.lightImpact();
    _detailBloc.add(StoryDetailCharacterDetailsRequested(characterName));

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: _detailBloc,
          child: _CharacterDetailsBottomSheet(isDark: isDark, theme: theme),
        );
      },
    );

    if (mounted) {
      _detailBloc.add(const StoryDetailCharacterDetailsClosed());
    }
  }

  Future<void> _openDiscussStoryBottomSheet(
    BuildContext context, {
    required ThemeData theme,
    required bool isDark,
  }) async {
    HapticFeedback.lightImpact();
    _detailBloc.add(const StoryDetailChatOpened());

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: _detailBloc,
          child: _DiscussStoryBottomSheet(isDark: isDark, theme: theme),
        );
      },
    );

    if (mounted) {
      _detailBloc.add(const StoryDetailChatClosed());
    }
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

class _CharacterDetailsBottomSheet extends StatelessWidget {
  final bool isDark;
  final ThemeData theme;

  const _CharacterDetailsBottomSheet({
    required this.isDark,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? const Color(0xFF0B1220) : Colors.white;
    final Size screenSize = MediaQuery.of(context).size;

    return DraggableScrollableSheet(
      initialChildSize: 0.78,
      minChildSize: 0.4,
      maxChildSize: 0.92,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.08)
                  : Colors.black.withOpacity(0.08),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.35),
                blurRadius: 25,
                offset: const Offset(0, -6),
              ),
            ],
          ),
          child: BlocBuilder<StoryDetailBloc, StoryDetailState>(
            builder: (context, state) {
              final details = state.selectedCharacterDetails;
              final title =
                  (details?['name'] ??
                          state.selectedCharacterName ??
                          'Character')
                      .toString();

              return Column(
                children: [
                  SizedBox(height: screenSize.height * 0.015),
                  Container(
                    width: 42,
                    height: 5,
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withOpacity(0.2)
                          : Colors.black.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.015),
                  Text(
                    "$title's Character Details",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF00B4DB),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenSize.height * 0.02),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: _buildBody(
                        context,
                        state,
                        details,
                        scrollController,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    StoryDetailState state,
    Map<String, dynamic>? details,
    ScrollController scrollController,
  ) {
    final Size screenSize = MediaQuery.of(context).size;
    if (state.isFetchingCharacter) {
      return Center(
        child: Column(
          children: [
            SizedBox(height: screenSize.height * 0.2),
            Center(child: CircularProgressIndicator()),
            SizedBox(height: screenSize.height * 0.05),
            Center(child: Text('Loading character details...')),
          ],
        ),
      );
    }

    if ((details == null) || (details.length == 2)) {
      return Center(
        child: Column(
          children: [
            Text(
              state.errorMessage ?? 'Select a character to view details.',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    final appearance = (details['appearance'] ?? '').toString();
    final role = (details['role'] ?? '').toString();
    final scripture = (details['scripture_background'] ?? '').toString();

    final traits =
        (details['personality_traits'] as List?)
            ?.map((e) => e.toString())
            .toList() ??
        const <String>[];
    final actions =
        (details['key_actions'] as List?)?.map((e) => e.toString()).toList() ??
        const <String>[];
    final divine =
        (details['divine_attributes'] as List?)
            ?.map((e) => e.toString())
            .toList() ??
        const <String>[];
    final relationships =
        (details['relationships'] as List?)
            ?.map((e) => e.toString())
            .toList() ??
        const <String>[];

    return ListView(
      controller: scrollController,
      children: [
        if (appearance.isNotEmpty)
          _InfoCard(
            isDark: isDark,
            theme: theme,
            icon: Icons.remove_red_eye_outlined,
            title: 'Appearance',
            child: Text(appearance, style: theme.textTheme.bodyMedium),
          ),
        SizedBox(height: screenSize.height * 0.01),
        if (traits.isNotEmpty)
          _ListCard(
            isDark: isDark,
            theme: theme,
            icon: Icons.favorite_rounded,
            title: 'Personality Traits',
            items: traits,
          ),
        if (traits.isNotEmpty) SizedBox(height: screenSize.height * 0.01),
        if (actions.isNotEmpty)
          _ListCard(
            isDark: isDark,
            theme: theme,
            icon: Icons.star_rounded,
            title: 'Key Actions in the Story',
            items: actions,
          ),
        if (actions.isNotEmpty) SizedBox(height: screenSize.height * 0.01),
        if (role.isNotEmpty)
          _InfoCard(
            isDark: isDark,
            theme: theme,
            icon: Icons.theater_comedy_rounded,
            title: 'Role in the Narrative',
            child: Text(role, style: theme.textTheme.bodyMedium),
          ),
        if (role.isNotEmpty) SizedBox(height: screenSize.height * 0.01),
        if (scripture.isNotEmpty)
          _InfoCard(
            isDark: isDark,
            theme: theme,
            icon: Icons.menu_book_rounded,
            title: 'Scripture Background',
            child: Text(scripture, style: theme.textTheme.bodyMedium),
          ),
        if (scripture.isNotEmpty) SizedBox(height: screenSize.height * 0.01),
        if (divine.isNotEmpty)
          _ListCard(
            isDark: isDark,
            theme: theme,
            icon: Icons.auto_awesome_rounded,
            title: 'Divine Attributes',
            items: divine,
          ),
        if (divine.isNotEmpty) SizedBox(height: screenSize.height * 0.01),
        if (relationships.isNotEmpty)
          _ListCard(
            isDark: isDark,
            theme: theme,
            icon: Icons.link_rounded,
            title: 'Relationships',
            items: relationships,
          ),
        SizedBox(height: screenSize.height * 0.02),
      ],
    );
  }
}

class _DiscussStoryBottomSheet extends StatefulWidget {
  final bool isDark;
  final ThemeData theme;

  const _DiscussStoryBottomSheet({required this.isDark, required this.theme});

  @override
  State<_DiscussStoryBottomSheet> createState() =>
      _DiscussStoryBottomSheetState();
}

class _DiscussStoryBottomSheetState extends State<_DiscussStoryBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _send(BuildContext context) {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    context.read<StoryDetailBloc>().add(StoryDetailChatMessageSubmitted(text));
    _controller.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final Color bg = widget.isDark ? const Color(0xFF0B1220) : Colors.white;
    final Size screenSize = MediaQuery.of(context).size;
    return DraggableScrollableSheet(
      initialChildSize: 0.78,
      minChildSize: 0.4,
      maxChildSize: 0.92,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
            border: Border.all(
              color: widget.isDark
                  ? Colors.white.withOpacity(0.08)
                  : Colors.black.withOpacity(0.08),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.35),
                blurRadius: 25,
                offset: const Offset(0, -6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
            child: BlocBuilder<StoryDetailBloc, StoryDetailState>(
              builder: (context, state) {
                final conv = state.chatConversation;
                final messages = conv?.messages ?? const [];

                return Column(
                  children: [
                    SizedBox(height: screenSize.height * 0.015),
                    Container(
                      width: 42,
                      height: 5,
                      decoration: BoxDecoration(
                        color: widget.isDark
                            ? Colors.white.withOpacity(0.2)
                            : Colors.black.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.015),
                    Text(
                      'Discuss Story',
                      style: widget.theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF00B4DB),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.02),

                    if (state.chatError != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: _ChatErrorBanner(
                          isDark: widget.isDark,
                          theme: widget.theme,
                          text: state.chatError!,
                        ),
                      ),

                    Expanded(
                      child: state.isChatLoading && conv == null
                          ? ListView(
                              controller: scrollController,
                              children: [
                                SizedBox(height: screenSize.height * 0.2),
                                Center(child: CircularProgressIndicator()),
                                SizedBox(height: screenSize.height * 0.05),
                                Center(child: Text('Loading discussion...')),
                              ],
                            )
                          : ListView.builder(
                              controller: scrollController,
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                              itemCount:
                                  messages.length +
                                  (state.isChatSending ? 1 : 0),
                              itemBuilder: (context, index) {
                                // typing indicator
                                if (state.isChatSending &&
                                    index == messages.length) {
                                  return _ChatBubble(
                                    isDark: widget.isDark,
                                    theme: widget.theme,
                                    isUser: false,
                                    text: '...',
                                    isTyping: true,
                                  );
                                }

                                final m = messages[index];
                                final isUser = m.sender.toLowerCase() == 'user';
                                return _ChatBubble(
                                  isDark: widget.isDark,
                                  theme: widget.theme,
                                  isUser: isUser,
                                  text: m.text,
                                );
                              },
                            ),
                    ),

                    _ChatComposer(
                      isDark: widget.isDark,
                      theme: widget.theme,
                      controller: _controller,
                      focusNode: _focusNode,
                      isSending: state.isChatSending,
                      onSend: () => _send(context),
                      onSubmitted: () => _send(context),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _ChatComposer extends StatelessWidget {
  final bool isDark;
  final ThemeData theme;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isSending;
  final VoidCallback onSend;
  final VoidCallback onSubmitted;

  const _ChatComposer({
    required this.isDark,
    required this.theme,
    required this.controller,
    required this.focusNode,
    required this.isSending,
    required this.onSend,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final border = isDark
        ? Colors.white.withOpacity(0.08)
        : Colors.black.withOpacity(0.08);

    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      top: false,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(bottom: bottomInset),
        child: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: border)),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 6,
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    textInputAction: TextInputAction.send,
                    minLines: 1,
                    maxLines: 4,
                    onSubmitted: (_) => onSubmitted(),

                    scrollPadding: EdgeInsets.only(bottom: bottomInset + 80),

                    decoration: InputDecoration(
                      hintText: 'Ask about the story...',
                      hintStyle: theme.textTheme.bodySmall?.copyWith(
                        color: theme.secondaryHeaderColor,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width: 50,
                  child: GestureDetector(
                    onTap: isSending ? null : onSend,
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00B4DB), Color(0xFF9055FF)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Center(
                        child: isSending
                            ? const SizedBox(
                                width: 23,
                                height: 23,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                                size: 23,
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final bool isDark;
  final ThemeData theme;
  final bool isUser;
  final String text;
  final bool isTyping;

  const _ChatBubble({
    required this.isDark,
    required this.theme,
    required this.isUser,
    required this.text,
    this.isTyping = false,
  });

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 0.78;

    final userGradient = const LinearGradient(
      colors: [Color(0xFF00B4DB), Color(0xFF9055FF)],
    );

    final botColor = isDark ? const Color(0xFF111C33) : const Color(0xFFF1F5F9);

    final bubble = Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        gradient: isUser ? userGradient : null,
        color: isUser ? null : botColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isUser
              ? Colors.white.withOpacity(0.10)
              : (isDark
                    ? Colors.white.withOpacity(0.06)
                    : Colors.black.withOpacity(0.06)),
        ),
      ),
      child: Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: isUser ? Colors.white : null,
          fontStyle: isTyping ? FontStyle.italic : FontStyle.normal,
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: bubble,
      ),
    );
  }
}

class _ChatErrorBanner extends StatelessWidget {
  final bool isDark;
  final ThemeData theme;
  final String text;

  const _ChatErrorBanner({
    required this.isDark,
    required this.theme,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.red.withOpacity(0.12)
            : Colors.red.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark
              ? Colors.red.withOpacity(0.25)
              : Colors.red.withOpacity(0.18),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline_rounded, size: 18, color: Colors.red),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDark ? Colors.red[200] : Colors.red[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final bool isDark;
  final ThemeData theme;
  final IconData icon;
  final String title;
  final Widget child;

  const _InfoCard({
    required this.isDark,
    required this.theme,
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.black.withOpacity(0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF00B4DB)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF00B4DB),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.01),
          child,
        ],
      ),
    );
  }
}

class _ListCard extends StatelessWidget {
  final bool isDark;
  final ThemeData theme;
  final IconData icon;
  final String title;
  final List<String> items;

  const _ListCard({
    required this.isDark,
    required this.theme,
    required this.icon,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return _InfoCard(
      isDark: isDark,
      theme: theme,
      icon: icon,
      title: title,
      child: Column(
        children: [
          for (final item in items)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Icon(
                    Icons.chevron_right_rounded,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(item, style: theme.textTheme.bodyMedium),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

String _buildReadAloudTextForState(Story s, StoryDetailState state) {
  final selectedCode = languageNameToCode(state.selectedLanguage);
  final translated = s.attributes.translations[selectedCode];

  final title = (translated?.title ?? s.title).trim();
  final story = (translated?.story ?? s.story).trim();
  final moral = (translated?.moral ?? s.lesson).trim();

  final parts = <String>[
    if (title.isNotEmpty) title,
    if (story.isNotEmpty) story,
    if (moral.isNotEmpty) moral,
  ];

  return parts.join('\n\n');
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

String languageNameToCode(String name) {
  final lower = name.toLowerCase();
  if (lower.contains('english')) return 'en';
  if (lower.contains('hindi')) return 'hi';
  if (lower.contains('tamil')) return 'ta';
  if (lower.contains('telugu')) return 'te';
  if (lower.contains('bengali')) return 'bn';
  if (lower.contains('marathi')) return 'mr';
  if (lower.contains('gujarati')) return 'gu';
  return 'en';
}
