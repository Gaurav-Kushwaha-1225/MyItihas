import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:myitihas/core/errors/failures.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/features/story_generator/domain/entities/story_prompt.dart';
import 'package:myitihas/features/story_generator/domain/entities/generator_options.dart';
import 'package:myitihas/features/story_generator/domain/repositories/story_generator_repository.dart';
import '../datasources/mock_story_generator_datasource.dart';

@LazySingleton(as: StoryGeneratorRepository)
class StoryGeneratorRepositoryImpl implements StoryGeneratorRepository {
  final MockStoryGeneratorDataSource _dataSource;

  StoryGeneratorRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, Story>> generateStory({
    required StoryPrompt prompt,
    required GeneratorOptions options,
  }) async {
    try {
      final story = await _dataSource.generateStory(
        prompt: prompt,
        options: options,
      );
      return Right(story);
    } catch (e) {
      return Left(ServerFailure('Failed to generate story: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, StoryPrompt>> getRandomOptions() async {
    try {
      final options = await _dataSource.getRandomOptions();
      return Right(options);
    } catch (e) {
      return Left(
        ServerFailure('Failed to get random options: ${e.toString()}'),
      );
    }
  }
}
