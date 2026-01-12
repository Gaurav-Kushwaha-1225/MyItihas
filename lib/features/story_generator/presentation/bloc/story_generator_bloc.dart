import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:myitihas/core/logging/talker_setup.dart';
import 'package:myitihas/core/usecases/usecase.dart';
import 'package:myitihas/features/story_generator/domain/entities/generator_options.dart';
import 'package:myitihas/features/story_generator/domain/entities/story_prompt.dart';
import 'package:myitihas/features/story_generator/domain/usecases/generate_story.dart';
import 'package:myitihas/features/story_generator/domain/usecases/generate_story_image.dart';
import 'package:myitihas/features/story_generator/domain/usecases/get_generated_stories.dart';
import 'package:myitihas/features/story_generator/domain/usecases/randomize_options.dart';

import 'story_generator_event.dart';
import 'story_generator_state.dart';

export 'story_generator_event.dart';
export 'story_generator_state.dart';

/// BLoC for managing story generation state
@injectable
class StoryGeneratorBloc
    extends Bloc<StoryGeneratorEvent, StoryGeneratorState> {
  final GenerateStory generateStory;
  final GenerateStoryImage generateStoryImage;
  final GetGeneratedStories getGeneratedStories;
  final RandomizeOptions randomizeOptions;

  StoryGeneratorBloc({
    required this.generateStory,
    required this.generateStoryImage,
    required this.getGeneratedStories,
    required this.randomizeOptions,
  }) : super(const StoryGeneratorState()) {
    on<StoryGeneratorEvent>((event, emit) async {
      await event.when(
        initialize: () => _onInitialize(emit),
        togglePromptType: (isRawPrompt) =>
            _onTogglePromptType(isRawPrompt, emit),
        selectOption: (category, value, parentValue) =>
            _onSelectOption(category, value, parentValue, emit),
        updateRawPrompt: (text) => _onUpdateRawPrompt(text, emit),
        applyQuickPrompt: (quickPrompt) =>
            _onApplyQuickPrompt(quickPrompt, emit),
        randomize: () => _onRandomize(emit),
        updateGeneratorOptions: (language, format, length) =>
            _onUpdateGeneratorOptions(language, format, length, emit),
        generate: () => _onGenerate(emit),
        reset: () => _onReset(emit),
        generateImage: () => _onGenerateImage(emit),
        loadHistory: () => _onLoadHistory(emit),
      );
    });
  }

  Future<void> _onLoadHistory(Emitter<StoryGeneratorState> emit) async {
    talker.info('Loading generated stories history');
    emit(state.copyWith(isLoadingHistory: true));

    final result = await getGeneratedStories(NoParams());

    result.fold(
      (failure) {
        talker.error('Failed to load history: ${failure.message}');
        emit(state.copyWith(isLoadingHistory: false));
      },
      (stories) {
        talker.info('Loaded ${stories.length} stories from history');
        emit(state.copyWith(isLoadingHistory: false, history: stories));
      },
    );
  }

  Future<void> _onGenerateImage(Emitter<StoryGeneratorState> emit) async {
    final story = state.generatedStory;
    if (story == null) {
      talker.warning('Cannot generate image: no story generated yet');
      return;
    }

    talker.info('Starting story image generation');
    emit(state.copyWith(isGeneratingImage: true, imageGenerationError: null));

    final result = await generateStoryImage(
      GenerateStoryImageParams(
        title: story.title,
        story: story.story,
        moral: story.lesson,
      ),
    );

    result.fold(
      (failure) {
        talker.error('Failed to generate story image: ${failure.message}');
        emit(
          state.copyWith(
            isGeneratingImage: false,
            imageGenerationError: failure.message,
          ),
        );
      },
      (imageUrl) {
        talker.info('Story image generated successfully');
        emit(state.copyWith(isGeneratingImage: false, storyImageUrl: imageUrl));
      },
    );
  }

  Future<void> _onInitialize(Emitter<StoryGeneratorState> emit) async {
    talker.info('Initializing story generator');
    emit(const StoryGeneratorState());
  }

  Future<void> _onTogglePromptType(
    bool isRawPrompt,
    Emitter<StoryGeneratorState> emit,
  ) async {
    talker.info('Toggling prompt type to raw: $isRawPrompt');
    emit(
      state.copyWith(
        prompt: state.prompt.copyWith(isRawPrompt: isRawPrompt),
        errorMessage: null,
      ),
    );
  }

  Future<void> _onSelectOption(
    String category,
    String value,
    String? parentValue,
    Emitter<StoryGeneratorState> emit,
  ) async {
    talker.info('Selecting option: $category = $value');

    StoryPrompt updatedPrompt;
    switch (category) {
      case 'scripture':
        updatedPrompt = state.prompt.copyWith(
          scripture: value,
          scriptureSubtype: parentValue,
        );
        break;
      case 'storyType':
        updatedPrompt = state.prompt.copyWith(storyType: value);
        break;
      case 'theme':
        updatedPrompt = state.prompt.copyWith(theme: value);
        break;
      case 'mainCharacter':
        updatedPrompt = state.prompt.copyWith(mainCharacter: value);
        break;
      case 'setting':
        updatedPrompt = state.prompt.copyWith(setting: value);
        break;
      default:
        return;
    }

    emit(state.copyWith(prompt: updatedPrompt, errorMessage: null));
  }

  Future<void> _onUpdateRawPrompt(
    String text,
    Emitter<StoryGeneratorState> emit,
  ) async {
    emit(
      state.copyWith(
        prompt: state.prompt.copyWith(rawPrompt: text),
        errorMessage: null,
      ),
    );
  }

  Future<void> _onApplyQuickPrompt(
    quickPrompt,
    Emitter<StoryGeneratorState> emit,
  ) async {
    talker.info('Applying quick prompt: ${quickPrompt.title}');
    emit(state.copyWith(prompt: quickPrompt.presetOptions, errorMessage: null));
  }

  Future<void> _onRandomize(Emitter<StoryGeneratorState> emit) async {
    talker.info('Randomizing options');
    emit(state.copyWith(isLoadingOptions: true, errorMessage: null));

    final result = await randomizeOptions(NoParams());

    result.fold(
      (failure) {
        talker.error('Failed to randomize options: ${failure.message}');
        emit(
          state.copyWith(
            isLoadingOptions: false,
            errorMessage: failure.message,
          ),
        );
      },
      (prompt) {
        talker.info('Randomized options: ${prompt.summary}');
        emit(state.copyWith(isLoadingOptions: false, prompt: prompt));
      },
    );
  }

  Future<void> _onUpdateGeneratorOptions(
    StoryLanguage? language,
    StoryFormat? format,
    StoryLength? length,
    Emitter<StoryGeneratorState> emit,
  ) async {
    final updatedOptions = state.options.copyWith(
      language: language ?? state.options.language,
      format: format ?? state.options.format,
      length: length ?? state.options.length,
    );
    emit(state.copyWith(options: updatedOptions));
  }

  Future<void> _onGenerate(Emitter<StoryGeneratorState> emit) async {
    if (!state.canGenerate) {
      talker.warning('Cannot generate: prompt is incomplete');
      emit(
        state.copyWith(errorMessage: 'Please complete all required options'),
      );
      return;
    }

    talker.info('Starting story generation');

    // Progress messages for loading overlay
    final progressMessages = [
      'Consulting the ancient scriptures...',
      'Weaving your tale...',
      'Adding divine wisdom...',
      'Polishing the narrative...',
      'Almost there...',
    ];

    emit(
      state.copyWith(
        isGenerating: true,
        generatingMessage: progressMessages[0],
        errorMessage: null,
        generatedStory: null,
      ),
    );

    // Start progress message rotation
    int messageIndex = 0;
    final progressTimer = Timer.periodic(const Duration(milliseconds: 800), (
      timer,
    ) {
      messageIndex = (messageIndex + 1) % progressMessages.length;
      if (!emit.isDone) {
        emit(state.copyWith(generatingMessage: progressMessages[messageIndex]));
      }
    });

    final result = await generateStory(
      GenerateStoryParams(prompt: state.prompt, options: state.options),
    );

    progressTimer.cancel();

    result.fold(
      (failure) {
        talker.error('Failed to generate story: ${failure.message}');
        emit(
          state.copyWith(
            isGenerating: false,
            generatingMessage: null,
            errorMessage: failure.message,
          ),
        );
      },
      (story) {
        talker.info('Story generated: ${story.title}');
        emit(
          state.copyWith(
            isGenerating: false,
            generatingMessage: null,
            generatedStory: story,
          ),
        );
      },
    );
  }

  Future<void> _onReset(Emitter<StoryGeneratorState> emit) async {
    talker.info('Resetting story generator');
    emit(const StoryGeneratorState());
  }
}
