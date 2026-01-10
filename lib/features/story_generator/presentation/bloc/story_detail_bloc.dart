import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:myitihas/core/logging/talker_setup.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/features/story_generator/domain/entities/generator_options.dart';
import 'package:myitihas/features/story_generator/domain/entities/story_prompt.dart';
import 'package:myitihas/features/story_generator/domain/repositories/story_generator_repository.dart';

/// A lightweight view-model for chapter rendering.
class StoryChapter {
  final int number;
  final String content;

  const StoryChapter({required this.number, required this.content});

  String get title => 'Chapter $number';
}

/// Events for StoryDetailBloc (no codegen to keep it easy to integrate).
sealed class StoryDetailEvent {
  const StoryDetailEvent();
}

class StoryDetailStarted extends StoryDetailEvent {
  final Story story;
  const StoryDetailStarted(this.story);
}

class StoryDetailToggleFavorite extends StoryDetailEvent {
  const StoryDetailToggleFavorite();
}

class StoryDetailLanguageChanged extends StoryDetailEvent {
  final String languageName;
  const StoryDetailLanguageChanged(this.languageName);
}

class StoryDetailRegenerateRequested extends StoryDetailEvent {
  const StoryDetailRegenerateRequested();
}

class StoryDetailGenerateImageRequested extends StoryDetailEvent {
  const StoryDetailGenerateImageRequested();
}

class StoryDetailReadMorePressed extends StoryDetailEvent {
  const StoryDetailReadMorePressed();
}

class StoryDetailExpandRequested extends StoryDetailEvent {
  const StoryDetailExpandRequested();
}

class StoryDetailDownloadStatusChanged extends StoryDetailEvent {
  final bool isDownloading;
  const StoryDetailDownloadStatusChanged(this.isDownloading);
}

/// State for StoryDetailBloc.
class StoryDetailState {
  final Story? story;

  /// Parsed chapters (Chapter 1 is the original story content).
  final List<StoryChapter> chapters;

  /// How many chapters are currently revealed in the UI.
  final int visibleChapters;

  final bool isGeneratingImage;
  final bool isRegenerating;
  final bool isExpanding;
  final bool isSaving;
  final bool isDownloading;

  /// Display name shown in dropdown (e.g., "English")
  final String selectedLanguage;

  final String? errorMessage;

  const StoryDetailState({
    required this.story,
    required this.chapters,
    required this.visibleChapters,
    required this.isGeneratingImage,
    required this.isRegenerating,
    required this.isExpanding,
    required this.isSaving,
    required this.isDownloading,
    required this.selectedLanguage,
    required this.errorMessage,
  });

  factory StoryDetailState.initial() => const StoryDetailState(
        story: null,
        chapters: [],
        visibleChapters: 1,
        isGeneratingImage: false,
        isRegenerating: false,
        isExpanding: false,
        isSaving: false,
        isDownloading: false,
        selectedLanguage: 'English',
        errorMessage: null,
      );

  StoryDetailState copyWith({
    Story? story,
    List<StoryChapter>? chapters,
    int? visibleChapters,
    bool? isGeneratingImage,
    bool? isRegenerating,
    bool? isExpanding,
    bool? isSaving,
    bool? isDownloading,
    String? selectedLanguage,
    String? errorMessage,
  }) {
    return StoryDetailState(
      story: story ?? this.story,
      chapters: chapters ?? this.chapters,
      visibleChapters: visibleChapters ?? this.visibleChapters,
      isGeneratingImage: isGeneratingImage ?? this.isGeneratingImage,
      isRegenerating: isRegenerating ?? this.isRegenerating,
      isExpanding: isExpanding ?? this.isExpanding,
      isSaving: isSaving ?? this.isSaving,
      isDownloading: isDownloading ?? this.isDownloading,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      errorMessage: errorMessage,
    );
  }
}

@injectable
class StoryDetailBloc extends Bloc<StoryDetailEvent, StoryDetailState> {
  final StoryGeneratorRepository _repo;

  StoryDetailBloc(this._repo) : super(StoryDetailState.initial()) {
    on<StoryDetailStarted>(_onStarted);
    on<StoryDetailToggleFavorite>(_onToggleFavorite);
    on<StoryDetailLanguageChanged>(_onLanguageChanged);
    on<StoryDetailRegenerateRequested>(_onRegenerate);
    on<StoryDetailGenerateImageRequested>(_onGenerateImage);
    on<StoryDetailReadMorePressed>(_onReadMorePressed);
    on<StoryDetailExpandRequested>(_onExpandRequested);
    on<StoryDetailDownloadStatusChanged>(_onDownloadStatusChanged);
  }

  Future<void> _onStarted(
    StoryDetailStarted event,
    Emitter<StoryDetailState> emit,
  ) async {
    final story = event.story;

    final chapters = _parseChapters(story.story);
    final selectedLanguage =
        (story.attributes.languageStyle.isNotEmpty) ? story.attributes.languageStyle : 'English';

    emit(
      state.copyWith(
        story: story,
        chapters: chapters,
        visibleChapters: chapters.isEmpty ? 0 : 1,
        selectedLanguage: selectedLanguage,
        errorMessage: null,
      ),
    );

    // Auto-generate image if absent (same behaviour as your current initState)
    if (story.imageUrl == null) {
      add(const StoryDetailGenerateImageRequested());
    }
  }

  Future<void> _onToggleFavorite(
    StoryDetailToggleFavorite event,
    Emitter<StoryDetailState> emit,
  ) async {
    final story = state.story;
    if (story == null) return;

    final updated = story.copyWith(isFavorite: !story.isFavorite);

    // Optimistic update
    emit(state.copyWith(story: updated, errorMessage: null, isSaving: true));

    final saved = await _repo.updateStory(updated);
    saved.fold(
      (failure) {
        talker.error('Failed to update favorite: ${failure.message}');
        // rollback
        emit(state.copyWith(story: story, isSaving: false, errorMessage: failure.message));
      },
      (savedStory) {
        emit(state.copyWith(story: savedStory, isSaving: false, errorMessage: null));
      },
    );
  }

  Future<void> _onLanguageChanged(
    StoryDetailLanguageChanged event,
    Emitter<StoryDetailState> emit,
  ) async {
    emit(state.copyWith(selectedLanguage: event.languageName, errorMessage: null));
  }

  Future<void> _onRegenerate(
    StoryDetailRegenerateRequested event,
    Emitter<StoryDetailState> emit,
  ) async {
    final original = state.story;
    if (original == null || state.isRegenerating) return;

    emit(state.copyWith(isRegenerating: true, errorMessage: null));

    try {
      final prompt = StoryPrompt(
        scripture: original.scripture.isNotEmpty ? original.scripture : null,
        storyType: original.attributes.storyType.isNotEmpty ? original.attributes.storyType : null,
        theme: original.attributes.theme.isNotEmpty ? original.attributes.theme : null,
        mainCharacter: original.attributes.mainCharacterType.isNotEmpty
            ? original.attributes.mainCharacterType
            : null,
        setting: original.attributes.storySetting.isNotEmpty ? original.attributes.storySetting : null,
        isRawPrompt: false,
      );

      final options = GeneratorOptions(
        language: StoryLanguage.values.firstWhere(
          (lang) =>
              lang.name.toLowerCase() ==
              state.selectedLanguage.toLowerCase().replaceAll(' ', ''),
          orElse: () => StoryLanguage.english,
        ),
        length: original.attributes.storyLength.isNotEmpty
            ? StoryLength.values.firstWhere(
                (len) =>
                    len.name.toLowerCase() ==
                    original.attributes.storyLength.toLowerCase(),
                orElse: () => StoryLength.medium,
              )
            : StoryLength.medium,
        format: original.attributes.narrativeStyle.isNotEmpty
            ? StoryFormat.values.firstWhere(
                (fmt) =>
                    fmt.name.toLowerCase() ==
                    original.attributes.narrativeStyle.toLowerCase(),
                orElse: () => StoryFormat.narrative,
              )
            : StoryFormat.narrative,
      );

      final result = await _repo.regenerateStory(
        original: original,
        prompt: prompt,
        options: options,
      );

      await result.fold(
        (failure) async {
          talker.error('Regenerate failed: ${failure.message}');
          emit(state.copyWith(isRegenerating: false, errorMessage: failure.message));
        },
        (regenerated) async {
          final chapters = _parseChapters(regenerated.story);

          emit(
            state.copyWith(
              story: regenerated,
              chapters: chapters,
              visibleChapters: chapters.isEmpty ? 0 : 1,
              isRegenerating: false,
              errorMessage: null,
            ),
          );

          // After regenerate, the repo sets image_url null -> generate new image.
          add(const StoryDetailGenerateImageRequested());
        },
      );
    } catch (e) {
      talker.error('Error during regenerate: $e');
      emit(state.copyWith(isRegenerating: false, errorMessage: e.toString()));
    }
  }

  Future<void> _onGenerateImage(
    StoryDetailGenerateImageRequested event,
    Emitter<StoryDetailState> emit,
  ) async {
    final story = state.story;
    if (story == null || state.isGeneratingImage) return;

    emit(state.copyWith(isGeneratingImage: true, errorMessage: null));

    final result = await _repo.generateStoryImage(
      title: story.title,
      story: story.story,
      moral: story.lesson,
    );

    await result.fold(
      (failure) async {
        talker.error('Image gen failed: ${failure.message}');
        emit(state.copyWith(isGeneratingImage: false, errorMessage: failure.message));
      },
      (imageUrl) async {
        final normalized =
            imageUrl.contains(',') ? imageUrl.split(',').last : imageUrl;
        final updated = story.copyWith(imageUrl: normalized);

        emit(state.copyWith(story: updated, isSaving: true));

        final saved = await _repo.updateStory(updated);
        saved.fold(
          (failure) {
            talker.error('Failed to save image: ${failure.message}');
            emit(state.copyWith(isGeneratingImage: false, isSaving: false, errorMessage: failure.message));
          },
          (savedStory) {
            emit(state.copyWith(story: savedStory, isGeneratingImage: false, isSaving: false, errorMessage: null));
          },
        );
      },
    );
  }

  Future<void> _onReadMorePressed(
    StoryDetailReadMorePressed event,
    Emitter<StoryDetailState> emit,
  ) async {
    // Reveal next already-fetched chapter, else fetch a new one.
    if (state.visibleChapters < state.chapters.length) {
      emit(state.copyWith(visibleChapters: state.visibleChapters + 1));
      return;
    }
    add(const StoryDetailExpandRequested());
  }

  Future<void> _onExpandRequested(
    StoryDetailExpandRequested event,
    Emitter<StoryDetailState> emit,
  ) async {
    final story = state.story;
    if (story == null || state.isExpanding) return;

    emit(state.copyWith(isExpanding: true, errorMessage: null));

    final currentChapter = state.chapters.isEmpty ? 1 : state.chapters.length;

    final result = await _repo.expandStory(
      story: story,
      currentChapter: currentChapter,
      storyLanguage: state.selectedLanguage,
    );

    await result.fold(
      (failure) async {
        talker.error('Expand failed: ${failure.message}');
        emit(state.copyWith(isExpanding: false, errorMessage: failure.message));
      },
      (newChapterText) async {
        final nextNumber = currentChapter + 1;
        final updatedChapters = [
          ...state.chapters,
          StoryChapter(number: nextNumber, content: newChapterText.trim()),
        ];

        final updatedContent = _buildStoryContent(updatedChapters);

        final updatedStory = story.copyWith(story: updatedContent);

        final saved = await _repo.updateStory(updatedStory);

        // Optimistic update so UI opens the new chapter immediately
        emit(
          state.copyWith(
            story: updatedStory,
            chapters: updatedChapters,
            visibleChapters: state.visibleChapters + 1,
            isExpanding: false,
            isSaving: true,
          ),
        );

        saved.fold(
          (failure) {
            talker.error('Failed to save expanded story: ${failure.message}');
            emit(state.copyWith(isSaving: false, errorMessage: failure.message));
          },
          (savedStory) {
            emit(state.copyWith(story: savedStory, isSaving: false, errorMessage: null));
          },
        );
      },
    );
  }

  Future<void> _onDownloadStatusChanged(
    StoryDetailDownloadStatusChanged event,
    Emitter<StoryDetailState> emit,
  ) async {
    emit(state.copyWith(isDownloading: event.isDownloading));
  }

  // -------------------------
  // Helpers
  // -------------------------

  List<StoryChapter> _parseChapters(String full) {
    final content = full.trim();
    if (content.isEmpty) return const [];

    final parts = content.split(RegExp(r'\n\s*-----\s*\n'));

    final chapters = <StoryChapter>[];

    // First chunk => Chapter 1
    final first = parts.first.trim();
    if (first.isNotEmpty) {
      chapters.add(StoryChapter(number: 1, content: first));
    }

    for (var i = 1; i < parts.length; i++) {
      final chunk = parts[i].trim();
      if (chunk.isEmpty) continue;

      // Try to read "Chapter N" from the first line.
      final lines = chunk.split('\n');
      int number = i + 1;
      int startLine = 0;

      final m = RegExp(r'^Chapter\s+(\d+)\s*$', caseSensitive: false)
          .firstMatch(lines.first.trim());
      if (m != null) {
        number = int.tryParse(m.group(1) ?? '') ?? number;
        startLine = 1;
      }

      final body = lines.skip(startLine).join('\n').trim();
      chapters.add(StoryChapter(number: number, content: body.isEmpty ? chunk : body));
    }

    // Ensure sequential numbering for display (optional)
    chapters.sort((a, b) => a.number.compareTo(b.number));
    return chapters;
  }

  /// Build the canonical stored content format:
  ///   Chapter1Content
  ///   -----
  ///   Chapter 2
  ///   <chapter2>
  ///   -----
  ///   Chapter 3
  ///   <chapter3>
  String _buildStoryContent(List<StoryChapter> chapters) {
    if (chapters.isEmpty) return '';

    final buffer = StringBuffer();
    buffer.write(chapters.first.content.trim());

    for (final chapter in chapters.skip(1)) {
      buffer.write('\n\n-----\nChapter ${chapter.number}\n${chapter.content.trim()}\n');
    }
    return buffer.toString().trim();
  }
}
