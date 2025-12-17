import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:myitihas/core/errors/exceptions.dart';
import 'package:myitihas/core/errors/failures.dart';
import 'package:myitihas/core/network/network_info.dart';
import '../../domain/entities/story.dart';
import '../../domain/repositories/story_repository.dart';
import '../datasources/story_local_data_source.dart';
import '../datasources/story_remote_data_source.dart';

@LazySingleton(as: StoryRepository)
class StoryRepositoryImpl implements StoryRepository {
  final StoryRemoteDataSource remoteDataSource;
  final StoryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  StoryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Story>>> getStories({
    String? searchQuery,
    String? sortBy,
    String? filterByType,
    String? filterByTheme,
    int? limit,
    int? offset,
  }) async {
    try {
      final stories = await localDataSource.getCachedStories();

      var filteredStories = stories;

      if (searchQuery != null && searchQuery.isNotEmpty) {
        filteredStories = filteredStories.where((story) {
          return story.title.toLowerCase().contains(
                searchQuery.toLowerCase(),
              ) ||
              story.story.toLowerCase().contains(searchQuery.toLowerCase());
        }).toList();
      }

      if (sortBy != null) {
        switch (sortBy) {
          case 'newest':
            filteredStories.sort((a, b) {
              final aDate = a.publishedAt ?? DateTime(2000);
              final bDate = b.publishedAt ?? DateTime(2000);
              return bDate.compareTo(aDate);
            });
            break;
          case 'oldest':
            filteredStories.sort((a, b) {
              final aDate = a.publishedAt ?? DateTime(2000);
              final bDate = b.publishedAt ?? DateTime(2000);
              return aDate.compareTo(bDate);
            });
            break;
          case 'popular':
            filteredStories.sort((a, b) => b.likes.compareTo(a.likes));
            break;
        }
      }

      if (offset != null && limit != null) {
        final startIndex = offset;
        final endIndex = (offset + limit).clamp(0, filteredStories.length);
        filteredStories = filteredStories.sublist(
          startIndex.clamp(0, filteredStories.length),
          endIndex,
        );
      } else if (limit != null) {
        filteredStories = filteredStories.take(limit).toList();
      }

      return Right(filteredStories.map((model) => model.toEntity()).toList());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Story>> getStoryById(String id) async {
    try {
      final cachedStory = await localDataSource.getCachedStoryById(id);
      if (cachedStory != null) {
        return Right(cachedStory.toEntity());
      } else {
        return const Left(NotFoundFailure('Story not found'));
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Story>>> getFavoriteStories() async {
    try {
      final favorites = await localDataSource.getFavoriteStories();
      return Right(favorites.map((model) => model.toEntity()).toList());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message, e.code));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavorite(String storyId) async {
    try {
      await localDataSource.toggleFavorite(storyId);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message, e.code));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Story>>> getTrendingStories({
    int limit = 10,
  }) async {
    try {
      final stories = await localDataSource.getCachedStories();
      final trending = stories.toList()
        ..sort((a, b) => b.likes.compareTo(a.likes));
      return Right(
        trending.take(limit).map((model) => model.toEntity()).toList(),
      );
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Story>>> getStoriesByScripture(
    String scripture,
  ) async {
    try {
      final stories = await localDataSource.getCachedStories();
      final filtered = stories.where((story) {
        return story.scripture.toLowerCase() == scripture.toLowerCase();
      }).toList();
      return Right(filtered.map((model) => model.toEntity()).toList());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Story>>> searchStories(String query) async {
    try {
      final cachedStories = await localDataSource.getCachedStories();
      final filtered = cachedStories
          .where(
            (story) =>
                story.title.toLowerCase().contains(query.toLowerCase()) ||
                story.story.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      return Right(filtered.map((model) => model.toEntity()).toList());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cacheStories(List<Story> stories) async {
    try {
      final models = stories
          .map(
            (entity) =>
                throw UnimplementedError('Entity to Model conversion needed'),
          )
          .toList();
      await localDataSource.cacheStories(models);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message, e.code));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Story>>> getCachedStories() async {
    try {
      final cachedStories = await localDataSource.getCachedStories();
      return Right(cachedStories.map((model) => model.toEntity()).toList());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message, e.code));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
