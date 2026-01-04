import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:myitihas/core/errors/failures.dart';
import 'package:myitihas/core/usecases/usecase.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import '../repositories/story_generator_repository.dart';

@lazySingleton
class GetGeneratedStories implements UseCase<List<Story>, NoParams> {
  final StoryGeneratorRepository repository;

  GetGeneratedStories(this.repository);

  @override
  Future<Either<Failure, List<Story>>> call(NoParams params) async {
    return await repository.getGeneratedStories();
  }
}
