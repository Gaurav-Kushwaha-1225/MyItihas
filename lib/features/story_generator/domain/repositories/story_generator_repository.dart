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
}
