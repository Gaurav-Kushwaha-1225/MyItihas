import 'package:injectable/injectable.dart';
import 'package:myitihas/core/errors/exceptions.dart';
import 'package:myitihas/core/storage/hive_service.dart';
import '../models/story_model.dart';
import 'story_mock_data_source.dart';

abstract class StoryLocalDataSource {
  Future<List<StoryModel>> getCachedStories();
  Future<void> cacheStories(List<StoryModel> stories);
  Future<StoryModel?> getCachedStoryById(String id);
  Future<void> cacheStory(StoryModel story);
  Future<List<StoryModel>> getFavoriteStories();
  Future<void> toggleFavorite(String storyId);
  Future<void> clearCache();
}

@LazySingleton(as: StoryLocalDataSource)
class StoryLocalDataSourceImpl implements StoryLocalDataSource {
  final HiveService hiveService;
  final StoryMockDataSource mockDataSource;

  StoryLocalDataSourceImpl(this.hiveService, this.mockDataSource);

  @override
  Future<List<StoryModel>> getCachedStories() async {
    try {
      final box = await hiveService.openBox<StoryModel>(HiveBoxNames.stories);

      if (box.isEmpty) {
        final stories = await mockDataSource.getStoriesFromAssets();
        await box.clear();
        for (var story in stories) {
          await box.put(story.id, story);
        }
        return stories;
      }

      return box.values.toList();
    } catch (e) {
      throw CacheException('Failed to get cached stories: ${e.toString()}');
    }
  }

  @override
  Future<void> cacheStories(List<StoryModel> stories) async {
    try {
      final box = await hiveService.openBox<StoryModel>(HiveBoxNames.stories);
      await box.clear();
      for (var story in stories) {
        await box.put(story.id, story);
      }
    } catch (e) {
      throw CacheException('Failed to cache stories: ${e.toString()}');
    }
  }

  @override
  Future<StoryModel?> getCachedStoryById(String id) async {
    try {
      final box = await hiveService.openBox<StoryModel>(HiveBoxNames.stories);

      if (box.isEmpty) {
        final stories = await mockDataSource.getStoriesFromAssets();
        await box.clear();
        for (final story in stories) {
          await box.put(story.id, story);
        }
      }

      return box.get(id);
    } catch (e) {
      throw CacheException('Failed to get cached story: ${e.toString()}');
    }
  }

  @override
  Future<void> cacheStory(StoryModel story) async {
    try {
      final box = await hiveService.openBox<StoryModel>(HiveBoxNames.stories);
      await box.put(story.id, story);
    } catch (e) {
      throw CacheException('Failed to cache story: ${e.toString()}');
    }
  }

  @override
  Future<List<StoryModel>> getFavoriteStories() async {
    try {
      final box = await hiveService.openBox<StoryModel>(HiveBoxNames.stories);
      return box.values.where((story) => story.isFavorite).toList();
    } catch (e) {
      throw CacheException('Failed to get favorite stories: ${e.toString()}');
    }
  }

  @override
  Future<void> toggleFavorite(String storyId) async {
    try {
      final box = await hiveService.openBox<StoryModel>(HiveBoxNames.stories);
      final story = box.get(storyId);

      if (story != null) {
        final updatedStory = story.copyWith(isFavorite: !story.isFavorite);
        await box.put(storyId, updatedStory);
      }
    } catch (e) {
      throw CacheException('Failed to toggle favorite: ${e.toString()}');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await hiveService.clearBox(HiveBoxNames.stories);
    } catch (e) {
      throw CacheException('Failed to clear cache: ${e.toString()}');
    }
  }
}
