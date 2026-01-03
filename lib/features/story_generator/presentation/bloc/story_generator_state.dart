import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/features/story_generator/domain/entities/story_prompt.dart';
import 'package:myitihas/features/story_generator/domain/entities/generator_options.dart';

part 'story_generator_state.freezed.dart';

/// States for the Story Generator BLoC
@Freezed(toStringOverride: true)
abstract class StoryGeneratorState with _$StoryGeneratorState {
  const factory StoryGeneratorState({
    /// Current story prompt configuration
    @Default(StoryPrompt()) StoryPrompt prompt,

    /// Generator options (language, format, length)
    @Default(GeneratorOptions()) GeneratorOptions options,

    /// Whether the generator is currently loading options
    @Default(false) bool isLoadingOptions,

    /// Whether a story is being generated
    @Default(false) bool isGenerating,

    /// Progress message during generation
    String? generatingMessage,

    /// The generated story (if any)
    Story? generatedStory,

    /// Error message (if any)
    String? errorMessage,

    /// Current quick prompt index in carousel
    @Default(0) int currentQuickPromptIndex,

    /// Whether an image is being generated
    @Default(false) bool isGeneratingImage,

    /// The generated story image URL
    String? storyImageUrl,

    /// Error message for image generation
    String? imageGenerationError,

    /// List of generated stories history
    @Default([]) List<Story> history,

    /// Whether history is being loaded
    @Default(false) bool isLoadingHistory,
  }) = _StoryGeneratorState;

  const StoryGeneratorState._();

  /// Check if the current configuration is ready to generate
  bool get canGenerate => prompt.isComplete && !isGenerating;

  @override
  String toString() {
    if (isGenerating) {
      return 'StoryGeneratorState.generating(message: $generatingMessage)';
    }
    if (generatedStory != null) {
      return 'StoryGeneratorState.generated(title: ${generatedStory!.title})';
    }
    if (errorMessage != null) {
      return 'StoryGeneratorState.error(message: $errorMessage)';
    }
    return 'StoryGeneratorState(isRaw: ${prompt.isRawPrompt}, complete: ${prompt.isComplete})';
  }
}
