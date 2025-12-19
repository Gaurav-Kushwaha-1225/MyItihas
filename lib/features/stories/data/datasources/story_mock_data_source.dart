import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:myitihas/core/errors/exceptions.dart';
import '../models/story_model.dart';

@LazySingleton()
class StoryMockDataSource {
  List<StoryModel>? _cachedStories;
  final Random _random = Random();

  Future<List<StoryModel>> getStoriesFromAssets() async {
    if (_cachedStories != null) {
      return _cachedStories!;
    }

    try {
      final String jsonString = await rootBundle.loadString(
        'docs/dataset.json',
      );
      final List<dynamic> jsonList = json.decode(jsonString);

      _cachedStories = jsonList.map((json) {
        final id = json['id'] ?? _generateId();

        final attributesJson = json['attributes'] ?? {};
        final attributes = _parseAttributes(attributesJson);

        final likes = _random.nextInt(1000);
        final views = likes + _random.nextInt(500);
        final publishedAt = DateTime.now().subtract(
          Duration(days: _random.nextInt(365)),
        );

        return StoryModel(
          id: id,
          title: json['title'] ?? 'Untitled Story',
          scripture: json['scripture'] ?? 'Unknown Scripture',
          story: json['story'] ?? '',
          quotes: json['quotes'] ?? '',
          trivia: json['trivia'] ?? '',
          activity: json['activity'] ?? '',
          lesson: json['lesson'] ?? '',
          attributes: attributes,
          imageUrl: null,
          author: null,
          publishedAt: publishedAt,
          likes: likes,
          views: views,
          isFavorite: false,
        );
      }).toList();

      return _cachedStories!;
    } catch (e) {
      throw CacheException(
        'Failed to load stories from assets: ${e.toString()}',
      );
    }
  }

  String _generateId() {
    return 'story_${DateTime.now().millisecondsSinceEpoch}_${_random.nextInt(10000)}';
  }

  StoryAttributesModel _parseAttributes(Map<String, dynamic> json) {
    return StoryAttributesModel(
      storyType: json['storyType'] ?? 'Mythological',
      theme: json['theme'] ?? 'Devotion',
      mainCharacterType: json['mainCharacterType'] ?? 'Divine',
      storySetting: json['storySetting'] ?? 'Ancient India',
      timeEra: json['timeEra'] ?? 'Vedic Period',
      narrativePerspective: json['narrativePerspective'] ?? 'Third Person',
      languageStyle: json['languageStyle'] ?? 'Traditional',
      emotionalTone: json['emotionalTone'] ?? 'Inspirational',
      narrativeStyle: json['narrativeStyle'] ?? 'Descriptive',
      plotStructure: json['plotStructure'] ?? 'Linear',
      storyLength: json['storyLength'] ?? 'Medium',
      references:
          (json['references'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ??
          [],
    );
  }

  void clearCache() {
    _cachedStories = null;
  }
}
