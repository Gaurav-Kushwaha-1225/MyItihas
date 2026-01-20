import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:myitihas/core/logging/talker_setup.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/features/story_generator/domain/entities/generator_options.dart';
import 'package:myitihas/features/story_generator/domain/entities/story_chat_message.dart';
import 'package:myitihas/features/story_generator/domain/entities/story_prompt.dart';
import 'package:myitihas/features/story_generator/domain/entities/story_translation.dart';
import 'package:myitihas/features/home/domain/repositories/continue_reading_repository.dart';
import 'package:myitihas/features/story_generator/domain/repositories/story_generator_repository.dart';

const Object _kUnset = Object();

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

/// Fetch character details for a given character (cache-first).
class StoryDetailCharacterDetailsRequested extends StoryDetailEvent {
  final String characterName;
  const StoryDetailCharacterDetailsRequested(this.characterName);
}

/// Clear currently selected character details (optional).
class StoryDetailCharacterDetailsClosed extends StoryDetailEvent {
  const StoryDetailCharacterDetailsClosed();
}

/// Open the story chat (loads conversation cache-first).
class StoryDetailChatOpened extends StoryDetailEvent {
  const StoryDetailChatOpened();
}

/// Send a message in the story chat.
class StoryDetailChatMessageSubmitted extends StoryDetailEvent {
  final String message;
  const StoryDetailChatMessageSubmitted(this.message);
}

/// Close chat (optional: clears errors).
class StoryDetailChatClosed extends StoryDetailEvent {
  const StoryDetailChatClosed();
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

  /// Character details bottom-sheet
  final bool isFetchingCharacter;
  final String? selectedCharacterName;
  final Map<String, dynamic>? selectedCharacterDetails;

  // Story chat bottom-sheet
  final bool isChatLoading;
  final bool isChatSending;
  final StoryChatConversation? chatConversation;
  final String? chatError;

  /// Display name shown in dropdown (e.g., "English")
  final String selectedLanguage;

  final bool isTranslating;
  final String? translationError;

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
    required this.isFetchingCharacter,
    required this.selectedCharacterName,
    required this.selectedCharacterDetails,
    required this.isChatLoading,
    required this.isChatSending,
    required this.chatConversation,
    required this.chatError,
    required this.selectedLanguage,
    required this.isTranslating,
    required this.translationError,
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
    isFetchingCharacter: false,
    selectedCharacterName: null,
    selectedCharacterDetails: null,
    isChatLoading: false,
    isChatSending: false,
    chatConversation: null,
    chatError: null,
    selectedLanguage: 'English',
    isTranslating: false,
    translationError: null,
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
    bool? isFetchingCharacter,
    String? selectedCharacterName,
    Map<String, dynamic>? selectedCharacterDetails,
    bool clearSelectedCharacterDetails = false,
    bool? isChatLoading,
    bool? isChatSending,
    Object? chatConversation = _kUnset,
    Object? chatError = _kUnset,
    String? selectedLanguage,
    bool? isTranslating,
    String? translationError,
    Object? errorMessage = _kUnset,
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
      isFetchingCharacter: isFetchingCharacter ?? this.isFetchingCharacter,
      selectedCharacterName: clearSelectedCharacterDetails
          ? null
          : (selectedCharacterName ?? this.selectedCharacterName),
      selectedCharacterDetails: clearSelectedCharacterDetails
          ? null
          : (selectedCharacterDetails ?? this.selectedCharacterDetails),
      isChatLoading: isChatLoading ?? this.isChatLoading,
      isChatSending: isChatSending ?? this.isChatSending,
      chatConversation: chatConversation == _kUnset
          ? this.chatConversation
          : chatConversation as StoryChatConversation?,
      chatError: chatError == _kUnset ? this.chatError : chatError as String?,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      isTranslating: isTranslating ?? this.isTranslating,
      translationError: translationError ?? this.translationError,
      errorMessage: errorMessage == _kUnset
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}

@injectable
class StoryDetailBloc extends Bloc<StoryDetailEvent, StoryDetailState> {
  final StoryGeneratorRepository _repo;
  final ContinueReadingRepository _continueReadingRepo;

  StoryDetailBloc(this._repo, this._continueReadingRepo)
    : super(StoryDetailState.initial()) {
    on<StoryDetailStarted>(_onStarted);
    on<StoryDetailToggleFavorite>(_onToggleFavorite);
    on<StoryDetailLanguageChanged>(_onLanguageChanged);
    on<StoryDetailRegenerateRequested>(_onRegenerate);
    on<StoryDetailGenerateImageRequested>(_onGenerateImage);
    on<StoryDetailReadMorePressed>(_onReadMorePressed);
    on<StoryDetailExpandRequested>(_onExpandRequested);
    on<StoryDetailDownloadStatusChanged>(_onDownloadStatusChanged);
    on<StoryDetailCharacterDetailsRequested>(_onCharacterDetailsRequested);
    on<StoryDetailChatOpened>(_onChatOpened);
    on<StoryDetailChatMessageSubmitted>(_onChatMessageSubmitted);
    on<StoryDetailChatClosed>(_onChatClosed);
    on<StoryDetailCharacterDetailsClosed>(_onCharacterDetailsClosed);
  }

  Future<void> _onStarted(
    StoryDetailStarted event,
    Emitter<StoryDetailState> emit,
  ) async {
    final story = event.story;

    final chapters = _parseChapters(story.story);
    final selectedLanguage = (story.attributes.languageStyle.isNotEmpty)
        ? story.attributes.languageStyle
        : 'English';

    emit(
      state.copyWith(
        story: story,
        chapters: chapters,
        visibleChapters: chapters.isEmpty ? 0 : 1,
        selectedLanguage: selectedLanguage,
        errorMessage: null,
      ),
    );

    // Auto-generate image if absent
    if (story.imageUrl == null) {
      add(const StoryDetailGenerateImageRequested());
    }

    // Add to continue reading list
    _continueReadingRepo.addStoryToContinueReading(story);
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

    final saved = await _repo.likeStory(updated, updated.isFavorite);
    saved.fold(
      (failure) {
        talker.error('Failed to update favorite: ${failure.message}');
        // rollback
        emit(
          state.copyWith(
            story: story,
            isSaving: false,
            errorMessage: failure.message,
          ),
        );
      },
      (savedStory) {
        emit(
          state.copyWith(
            story: savedStory,
            isSaving: false,
            errorMessage: null,
          ),
        );
      },
    );
  }

  String _languageNameToCode(String name) {
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

  Future<void> _onLanguageChanged(
    StoryDetailLanguageChanged event,
    Emitter<StoryDetailState> emit,
  ) async {
    final story = state.story;
    if (story == null) return;

    emit(
      state.copyWith(selectedLanguage: event.languageName, errorMessage: null),
    );

    final langCode = _languageNameToCode(event.languageName);

    // English = show original
    if (langCode == 'en') {
      emit(
        state.copyWith(
          chapters: _parseChapters(story.story),
          visibleChapters: 1,
        ),
      );
      return;
    }

    final cached = story.attributes.translations[langCode];
    if (cached != null) {
      emit(
        state.copyWith(
          chapters: _parseChapters(cached.story),
          visibleChapters: 1,
        ),
      );
      return;
    }

    emit(state.copyWith(isTranslating: true));

    final res = await _repo.translateStory(story: story, targetLang: langCode);

    await res.fold(
      (failure) async {
        emit(
          state.copyWith(isTranslating: false, errorMessage: failure.message),
        );
      },
      (translated) async {
        final updatedTranslations = Map<String, TranslatedStory>.from(
          story.attributes.translations,
        )..[langCode] = translated;

        final updatedStory = story.copyWith(
          attributes: story.attributes.copyWith(
            translations: updatedTranslations,
          ),
        );

        final saved = await _repo.updateStory(updatedStory);

        saved.fold(
          (f) => emit(
            state.copyWith(isTranslating: false, errorMessage: f.message),
          ),
          (savedStory) => emit(
            state.copyWith(
              story: savedStory,
              isTranslating: false,
              chapters: _parseChapters(translated.story),
              visibleChapters: 1,
            ),
          ),
        );
      },
    );
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
        storyType: original.attributes.storyType.isNotEmpty
            ? original.attributes.storyType
            : null,
        theme: original.attributes.theme.isNotEmpty
            ? original.attributes.theme
            : null,
        mainCharacter: original.attributes.mainCharacterType.isNotEmpty
            ? original.attributes.mainCharacterType
            : null,
        setting: original.attributes.storySetting.isNotEmpty
            ? original.attributes.storySetting
            : null,
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
          emit(
            state.copyWith(
              isRegenerating: false,
              errorMessage: failure.message,
            ),
          );
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
              clearSelectedCharacterDetails: true,
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
        emit(
          state.copyWith(
            isGeneratingImage: false,
            errorMessage: failure.message,
          ),
        );
      },
      (imageUrl) async {
        final normalized = imageUrl.contains(',')
            ? imageUrl.split(',').last
            : imageUrl;
        final updated = story.copyWith(imageUrl: normalized);

        emit(state.copyWith(story: updated, isSaving: true));

        final saved = await _repo.updateStory(updated);
        saved.fold(
          (failure) {
            talker.error('Failed to save image: ${failure.message}');
            emit(
              state.copyWith(
                isGeneratingImage: false,
                isSaving: false,
                errorMessage: failure.message,
              ),
            );
          },
          (savedStory) {
            emit(
              state.copyWith(
                story: savedStory,
                isGeneratingImage: false,
                isSaving: false,
                errorMessage: null,
              ),
            );
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
            emit(
              state.copyWith(isSaving: false, errorMessage: failure.message),
            );
          },
          (savedStory) {
            emit(
              state.copyWith(
                story: savedStory,
                isSaving: false,
                errorMessage: null,
              ),
            );
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

  Future<void> _onCharacterDetailsRequested(
    StoryDetailCharacterDetailsRequested event,
    Emitter<StoryDetailState> emit,
  ) async {
    final story = state.story;
    if (story == null || state.isFetchingCharacter) return;

    final key = _normalizeCharacterKey(event.characterName);
    final cached = story.attributes.characterDetails[key];

    // Cache hit
    if (cached != null && cached.isNotEmpty && cached.length > 2) {
      emit(
        state.copyWith(
          isFetchingCharacter: false,
          selectedCharacterName: event.characterName,
          selectedCharacterDetails: cached.cast<String, dynamic>(),
          errorMessage: null,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isFetchingCharacter: true,
        selectedCharacterName: event.characterName,
        selectedCharacterDetails: null,
        isChatLoading: false,
        isChatSending: false,
        chatConversation: null,
        chatError: null,
        errorMessage: null,
      ),
    );

    final currentChapter = state.chapters.isEmpty ? 1 : state.chapters.length;

    final result = await _repo.getCharacterDetails(
      story: story,
      characterName: event.characterName,
      currentChapter: currentChapter,
      storyLanguage: state.selectedLanguage,
    );

    await result.fold(
      (failure) async {
        talker.error('Character details failed: ${failure.message}');
        emit(
          state.copyWith(
            isFetchingCharacter: false,
            errorMessage: failure.message,
          ),
        );
      },
      (details) async {
        final updatedMap = {...story.attributes.characterDetails, key: details};

        final updatedStory = story.copyWith(
          attributes: story.attributes.copyWith(characterDetails: updatedMap),
        );

        // Optimistic update so sheet renders immediately
        emit(
          state.copyWith(
            story: updatedStory,
            isFetchingCharacter: false,
            selectedCharacterName: event.characterName,
            selectedCharacterDetails: details,
            isSaving: true,
            errorMessage: null,
          ),
        );

        final saved = await _repo.updateStory(updatedStory);
        saved.fold(
          (failure) {
            talker.error(
              'Failed to save character details: ${failure.message}',
            );
            emit(
              state.copyWith(isSaving: false, errorMessage: failure.message),
            );
          },
          (savedStory) {
            emit(
              state.copyWith(
                story: savedStory,
                isSaving: false,
                errorMessage: null,
              ),
            );
          },
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Story Chat (Discuss Story)
  // ---------------------------------------------------------------------------

  Future<void> _onChatOpened(
    StoryDetailChatOpened event,
    Emitter<StoryDetailState> emit,
  ) async {
    final story = state.story;
    if (story == null || state.isChatLoading) return;

    emit(state.copyWith(isChatLoading: true, chatError: null));

    final result = await _repo.getOrCreateStoryChat(story: story);
    result.fold(
      (failure) {
        talker.error('Chat load failed: ${failure.message}');
        emit(state.copyWith(isChatLoading: false, chatError: failure.message));
      },
      (conversation) {
        emit(
          state.copyWith(
            isChatLoading: false,
            chatConversation: conversation,
            chatError: null,
          ),
        );
      },
    );
  }

  Future<void> _onChatMessageSubmitted(
    StoryDetailChatMessageSubmitted event,
    Emitter<StoryDetailState> emit,
  ) async {
    final story = state.story;
    final conversation = state.chatConversation;
    if (story == null || conversation == null || state.isChatSending) return;

    final text = event.message.trim();
    if (text.isEmpty) return;

    emit(state.copyWith(isChatSending: true, chatError: null));

    final result = await _repo.sendStoryChatMessage(
      story: story,
      conversation: conversation,
      message: text,
      language: _languageToCode(state.selectedLanguage),
    );

    result.fold(
      (failure) {
        talker.error('Chat send failed: ${failure.message}');
        emit(state.copyWith(isChatSending: false, chatError: failure.message));
      },
      (updatedConversation) {
        emit(
          state.copyWith(
            isChatSending: false,
            chatConversation: updatedConversation,
            chatError: null,
          ),
        );
      },
    );
  }

  Future<void> _onChatClosed(
    StoryDetailChatClosed event,
    Emitter<StoryDetailState> emit,
  ) async {
    emit(state.copyWith(chatError: null));
  }

  String _languageToCode(String displayName) {
    final t = displayName.trim().toLowerCase();
    if (t.startsWith('hindi')) return 'hi';
    if (t.startsWith('english')) return 'en';
    if (t.startsWith('tamil')) return 'ta';
    if (t.startsWith('telugu')) return 'te';
    if (t.startsWith('marathi')) return 'mr';
    if (t.startsWith('bengali')) return 'bn';
    if (t.startsWith('gujarati')) return 'gu';
    if (t.startsWith('kannada')) return 'kn';
    if (t.startsWith('malayalam')) return 'ml';
    if (t.startsWith('punjabi')) return 'pa';
    if (t.startsWith('odia')) return 'or';
    if (t.startsWith('urdu')) return 'ur';
    // Default to english like the web client.
    return 'en';
  }

  Future<void> _onCharacterDetailsClosed(
    StoryDetailCharacterDetailsClosed event,
    Emitter<StoryDetailState> emit,
  ) async {
    emit(state.copyWith(clearSelectedCharacterDetails: true));
  }

  // -------------------------
  // Helpers
  // -------------------------

  String _normalizeCharacterKey(String name) {
    return name.trim().toLowerCase();
  }

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

      final m = RegExp(
        r'^Chapter\s+(\d+)\s*$',
        caseSensitive: false,
      ).firstMatch(lines.first.trim());
      if (m != null) {
        number = int.tryParse(m.group(1) ?? '') ?? number;
        startLine = 1;
      }

      final body = lines.skip(startLine).join('\n').trim();
      chapters.add(
        StoryChapter(number: number, content: body.isEmpty ? chunk : body),
      );
    }

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
      buffer.write(
        '\n\n-----\nChapter ${chapter.number}\n${chapter.content.trim()}\n',
      );
    }
    return buffer.toString().trim();
  }
}
