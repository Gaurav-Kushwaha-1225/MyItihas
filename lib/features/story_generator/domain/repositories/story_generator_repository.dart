import 'package:fpdart/fpdart.dart';
import 'package:myitihas/core/errors/failures.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import '../entities/story_prompt.dart';
import '../entities/generator_options.dart';

/// Repository interface for story generation
abstract class StoryGeneratorRepository {
  /// Generate a new story based on the prompt and options
  Future<Either<Failure, Story>> generateStory({
    required StoryPrompt prompt,
    required GeneratorOptions options,
  });

  /// Get random options for story generation
  Future<Either<Failure, StoryPrompt>> getRandomOptions();

  /// Generate an image for the story
  Future<Either<Failure, String>> generateStoryImage({
    required String title,
    required String story,
    required String moral,
  });

  /// Save the generated story to Supabase
  Future<Either<Failure, Story>> updateStory(Story story);

  /// Get list of generated stories for the current user
  Future<Either<Failure, List<Story>>> getGeneratedStories();

  Future<Either<Failure, Story>> regenerateStory({
    required Story original,
    required StoryPrompt prompt,
    required GeneratorOptions options,
  });
}
