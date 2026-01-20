import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/features/story_generator/domain/entities/story_translation.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class ContinueStoryLocalStore {
  static const String _key = 'continue_story_ids';

  final SharedPreferences _prefs;
  final int maxItems = 5;

  ContinueStoryLocalStore(this._prefs);

  List<Story> getStorys() {
    final jsonString = _prefs.getString(_key);
    if (jsonString == null || jsonString.isEmpty) return <Story>[];
    print('ContinueReading: Found stored stories: $jsonString');
    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((json) => mapSupabaseRowToStory(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('ContinueReading: Error parsing JSON: $e');
      return <Story>[];
    }
  }

  Future<void> touch(Story story) async {
    print('ContinueReading: Touching story: ${story.title} (${story.id})');
    final stories = getStorys();

    // Remove the story if it already exists (to avoid duplicates)
    stories.removeWhere((e) => e.id == story.id);

    // Insert at the beginning (most recent)
    stories.insert(0, story);

    // Keep only maxItems
    if (stories.length > maxItems) {
      stories.removeRange(maxItems, stories.length);
    }

    // Save to SharedPreferences
    await _saveStories(stories);
    print('ContinueReading: Saved ${stories.length} stories');
  }

  Future<void> remove(String storyId) async {
    final stories = getStorys();
    stories.removeWhere((e) => e.id == storyId);
    await _saveStories(stories);
  }

  Future<void> clear() async {
    await _prefs.remove(_key);
  }

  Future<void> _saveStories(List<Story> stories) async {
    final jsonList = stories.map((story) => _storyToMap(story)).toList();
    final jsonString = jsonEncode(jsonList);
    await _prefs.setString(_key, jsonString);
  }

  Map<String, dynamic> _storyToMap(Story story) {
    return {
      'id': story.id,
      'user_id': story.authorId,
      'title': story.title,
      'content': story.story,
      'language': story.attributes.languageStyle,
      'image_url': story.imageUrl,
      'created_at': story.createdAt?.toIso8601String(),
      'updated_at': story.updatedAt?.toIso8601String(),
      'published_at': story.publishedAt?.toIso8601String(),
      'author': story.author,
      'likes': story.likes,
      'views': story.views,
      'is_favourite': story.isFavorite,
      'comment_count': story.commentCount,
      'share_count': story.shareCount,
      'attributes': {
        'scripture': story.scripture,
        'quotes': story.quotes,
        'trivia': story.trivia,
        'activity': story.activity,
        'moral': story.lesson,
        'story_type': story.attributes.storyType,
        'theme': story.attributes.theme,
        'main_character_type': story.attributes.mainCharacterType,
        'story_setting': story.attributes.storySetting,
        'time_era': story.attributes.timeEra,
        'narrative_perspective': story.attributes.narrativePerspective,
        'language_style': story.attributes.languageStyle,
        'emotional_tone': story.attributes.emotionalTone,
        'narrative_style': story.attributes.narrativeStyle,
        'plot_structure': story.attributes.plotStructure,
        'story_length': story.attributes.storyLength,
        'tags': story.attributes.tags,
        'references': story.attributes.references,
        'characters': story.attributes.characters,
        'character_details': story.attributes.characterDetails,
        'translations': story.attributes.translations.map(
          (key, value) => MapEntry(key, {
            'title': value.title,
            'story': value.story,
            'moral': value.moral,
            'lang': value.lang,
          }),
        ),
      },
    };
  }
}

Story mapSupabaseRowToStory(Map<String, dynamic> row) {
  final attr =
      (row['attributes'] as Map?)?.cast<String, dynamic>() ??
      <String, dynamic>{};
  final characterDetails =
      (attr['character_details'] as Map?)?.cast<String, dynamic>() ??
      <String, dynamic>{};

  return Story(
    id: row['id']!.toString(),
    authorId: row['user_id']?.toString(),
    title: row['title']?.toString() ?? 'Untitled Story',
    story: row['content']?.toString() ?? '',
    scripture: attr['scripture']?.toString() ?? 'Scripture',
    quotes: attr['quotes']?.toString() ?? '',
    trivia: attr['trivia']?.toString() ?? '',
    activity: attr['activity']?.toString() ?? '',
    lesson: attr['moral']?.toString() ?? '',
    attributes: StoryAttributes(
      storyType: attr['story_type']?.toString() ?? 'General',
      theme: attr['theme']?.toString() ?? 'Dharma (Duty)',
      mainCharacterType:
          attr['main_character_type']?.toString() ?? 'Protagonist',
      storySetting: attr['story_setting']?.toString() ?? 'Ancient India',
      timeEra: attr['time_era']?.toString() ?? 'Ancient',
      narrativePerspective:
          attr['narrative_perspective']?.toString() ?? 'Third Person',
      languageStyle:
          row['language']?.toString() ??
          attr['language_style']?.toString() ??
          'English',
      emotionalTone: attr['emotional_tone']?.toString() ?? 'Inspirational',
      narrativeStyle: attr['narrative_style']?.toString() ?? 'Narrative',
      plotStructure: attr['plot_structure']?.toString() ?? 'Linear',
      storyLength: attr['story_length']?.toString() ?? 'Medium ~1000 words',
      tags: (attr['tags'] as List<dynamic>? ?? const [])
          .map((tag) => tag.toString())
          .toList(),
      references: (attr['references'] is List)
          ? (attr['references'] as List<dynamic>)
                .map((e) => e.toString())
                .toList()
          : [attr['references']?.toString() ?? ''],
      characters: (attr['characters'] as List<dynamic>? ?? const [])
          .map((char) => char.toString())
          .toList(),
      characterDetails: characterDetails,
      translations: _parseTranslations(attr['translations']),
    ),
    imageUrl: row['image_url']?.toString(),
    createdAt: row['created_at'] != null
        ? DateTime.tryParse(row['created_at'].toString())
        : null,
    updatedAt: row['updated_at'] != null
        ? DateTime.tryParse(row['updated_at'].toString())
        : null,
    publishedAt: row['published_at'] != null
        ? DateTime.tryParse(row['published_at'].toString())
        : null,
    author: row['author']?.toString(),
    likes: (row['likes'] is int)
        ? row['likes'] as int
        : (row['likes'] as num?)?.toInt() ?? 0,
    views: (row['views'] is int)
        ? row['views'] as int
        : (row['views'] as num?)?.toInt() ?? 0,
    isFavorite: row['is_favourite'] as bool? ?? false,
    commentCount: (row['comment_count'] as num?)?.toInt() ?? 0,
    shareCount: (row['share_count'] as num?)?.toInt() ?? 0,
  );
}

Map<String, TranslatedStory> _parseTranslations(dynamic raw) {
  if (raw == null) return <String, TranslatedStory>{};

  if (raw is Map) {
    final out = <String, TranslatedStory>{};

    for (final entry in raw.entries) {
      final lang = entry.key.toString();
      final val = entry.value;

      if (val == null) continue;

      if (val is Map<String, dynamic>) {
        out[lang] = TranslatedStory.fromJson(val);
        continue;
      }
      if (val is Map) {
        out[lang] = TranslatedStory.fromJson(Map<String, dynamic>.from(val));
        continue;
      }

      if (val is String) {
        try {
          final decoded = jsonDecode(val);
          if (decoded is Map) {
            out[lang] = TranslatedStory.fromJson(
              Map<String, dynamic>.from(decoded),
            );
          }
        } catch (_) {}
      }
    }

    return out;
  }

  return <String, TranslatedStory>{};
}
