import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:myitihas/core/errors/failures.dart';
import 'package:myitihas/features/social/data/datasources/user_remote_data_source.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/features/story_generator/domain/entities/story_chat_message.dart';
import 'package:myitihas/features/story_generator/domain/entities/story_prompt.dart';
import 'package:myitihas/features/story_generator/domain/entities/generator_options.dart';
import 'package:myitihas/features/story_generator/domain/repositories/story_generator_repository.dart';
import 'package:myitihas/services/supabase_service.dart';
import '../datasources/remote_story_generator_datasource.dart';
import '../datasources/mock_story_generator_datasource.dart';

@LazySingleton(as: StoryGeneratorRepository)
class StoryGeneratorRepositoryImpl implements StoryGeneratorRepository {
  final RemoteStoryGeneratorDataSource _remoteDataSource;
  final MockStoryGeneratorDataSource _mockDataSource;

  StoryGeneratorRepositoryImpl(this._remoteDataSource, this._mockDataSource);

  @override
  Future<Either<Failure, Story>> generateStory({
    required StoryPrompt prompt,
    required GeneratorOptions options,
  }) async {
    try {
      final result = await _remoteDataSource.generateStory(
        prompt: prompt,
        options: options,
      );

      final user = SupabaseService.client.auth.currentUser;
      final userRepo = UserRemoteDataSourceSupabase(SupabaseService.client);
      final author = await userRepo.getUserById(user!.id);
      final title = result['title'] as String? ?? 'Untitled Story';
      final storyContent = result['story'] as String? ?? '';
      final moral = result['moral'] as String? ?? '';
      final reference = result['reference'] as String? ?? '';
      final characters = (result['characters'] as List<dynamic>? ?? const [])
          .map((e) => e.toString())
          .toList();

      // Local fallback generation for UI fields not returned by backend
      final theme = prompt.theme ?? 'Dharma';
      final scripture = prompt.scripture ?? 'Mahabharata';

      final storyMap = {
        'user_id': user.id,
        'title': title,
        'content': storyContent,
        'language': options.language.displayName,
        'metadata': {},
        'attributes': {
          'quotes': _getQuotes(theme),
          'trivia': _getTrivia(scripture),
          'activity': _getActivity(theme),
          'scripture': scripture,
          'theme': theme,
          'references': reference,
          'characters': characters,
          'character_details': <String, dynamic>{},
          'moral': moral.isNotEmpty ? moral : _getLesson(theme),
          'story_type': prompt.storyType,
          'main_character_type': prompt.mainCharacter,
          'story_setting': prompt.setting,
          'time_era': prompt.scriptureSubtype ?? scripture,
          'narrative_perspective': 'Third Person',
          'language_style': options.language.displayName,
          'emotional_tone': 'Inspiring',
          'narrative_style': options.format.displayName,
          'plot_structure':
              '${options.length.displayName} ${options.length.description}',
          'story_length':
              '${options.length.displayName} ${options.length.description}',
          'tags': <String>[],
        },
        'author_id': author.id,
        'comment_count': 0,
        'share_count': 0,
        'likes': 0,
        'views': 0,
        'published_at': null,
        'image_url': null,
        'author': author.displayName,
        'is_favourite': false,
      };

      final response = await SupabaseService.client
          .from('stories')
          .insert(storyMap)
          .select()
          .single();

      return Right(_mapSupabaseRowToStory(response));
    } catch (e) {
      return Left(ServerFailure('Failed to generate story: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, StoryPrompt>> getRandomOptions() async {
    try {
      final options = await _mockDataSource.getRandomOptions();
      return Right(options);
    } catch (e) {
      return Left(
        ServerFailure('Failed to get random options: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, String>> generateStoryImage({
    required String title,
    required String story,
    required String moral,
  }) async {
    try {
      final imageUrl = await _remoteDataSource.generateStoryImage(
        title: title,
        story: story,
        moral: moral,
      );
      return Right(imageUrl);
    } catch (e) {
      return Left(
        ServerFailure('Failed to generate story image: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, Story>> updateStory(Story story) async {
    try {
      final user = SupabaseService.client.auth.currentUser;
      if (user == null) {
        return Left(ServerFailure('User not authenticated'));
      }

      final data = {
        'id': story.id,
        'user_id': user.id,
        'title': story.title,
        'content': story.story,
        'image_url': story.imageUrl,
        'language': story.attributes.languageStyle,
        'attributes': _attributesToMap(story),
        'is_favourite': story.isFavorite,
        'updated_at': DateTime.now().toIso8601String(),
      };

      final response = await SupabaseService.client
          .from('stories')
          .upsert(data, onConflict: 'id')
          .select()
          .single();

      return Right(_mapSupabaseRowToStory(response));
    } catch (e) {
      return Left(ServerFailure('Failed to save story: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Story>>> getGeneratedStories() async {
    try {
      final user = SupabaseService.client.auth.currentUser;
      if (user == null) {
        return Left(ServerFailure('User not authenticated'));
      }

      final response = await SupabaseService.client
          .from('stories')
          .select()
          .eq('author_id', user.id)
          .order('updated_at', ascending: false);

      final stories = (response as List<dynamic>)
          .map((row) => _mapSupabaseRowToStory(row as Map<String, dynamic>))
          .toList();

      return Right(stories);
    } catch (e) {
      return Left(
        ServerFailure('Failed to fetch generated stories: ${e.toString()}'),
      );
    }
  }

  Map<String, dynamic> _attributesToMap(Story story) {
    final a = story.attributes;
    return {
      'story_type': a.storyType,
      'theme': a.theme,
      'main_character_type': a.mainCharacterType,
      'story_setting': a.storySetting,
      'time_era': a.timeEra,
      'narrative_perspective': a.narrativePerspective,
      'language_style': a.languageStyle,
      'emotional_tone': a.emotionalTone,
      'narrative_style': a.narrativeStyle,
      'plot_structure': a.plotStructure,
      'story_length': a.storyLength,
      'references': a.references,
      'tags': a.tags,
      'characters': a.characters,
      'character_details': a.characterDetails,
      // keep the old scalar UI fields too if your UI depends on them
      'quotes': story.quotes,
      'trivia': story.trivia,
      'activity': story.activity,
      'scripture': story.scripture,
      'moral': story.lesson,
    };
  }

  Story _mapSupabaseRowToStory(Map<String, dynamic> row) {
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

  @override
  Future<Either<Failure, String>> expandStory({
    required Story story,
    required int currentChapter,
    required String storyLanguage,
  }) async {
    try {
      final result = await _remoteDataSource.interactWithStory(
        storyTitle: story.title,
        storyContent: story.story,
        interactionType: 'expand',
        characterName: null,
        currentChapter: currentChapter,
        storyLanguage: storyLanguage,
      );

      final chapterText = result['response']?.toString();
      if (chapterText == null || chapterText.trim().isEmpty) {
        return Left(ServerFailure('Empty expand response from server'));
      }

      return Right(chapterText);
    } catch (e) {
      return Left(ServerFailure('Failed to expand story: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Story>> regenerateStory({
    required Story original,
    required StoryPrompt prompt,
    required GeneratorOptions options,
  }) async {
    try {
      final result = await _remoteDataSource.generateStory(
        prompt: prompt,
        options: options,
      );

      final user = SupabaseService.client.auth.currentUser;
      final userRepo = UserRemoteDataSourceSupabase(SupabaseService.client);
      final author = await userRepo.getUserById(user!.id);
      final title = result['title'] as String? ?? 'Untitled Story';
      final storyContent = result['story'] as String? ?? '';
      final moral = result['moral'] as String? ?? '';
      final reference = result['reference'] as String? ?? '';
      final characters = (result['characters'] as List<dynamic>? ?? const [])
          .map((e) => e.toString())
          .toList();

      final theme = prompt.theme ?? 'Dharma';
      final scripture = prompt.scripture ?? 'Mahabharata';

      final storyMap = {
        'id': original.id,
        'user_id': user.id,
        'title': title,
        'content': storyContent,
        'language': options.language.displayName,
        'metadata': {},
        'attributes': {
          'quotes': _getQuotes(theme),
          'trivia': _getTrivia(scripture),
          'activity': _getActivity(theme),
          'scripture': scripture,
          'theme': theme,
          'references': reference,
          'characters': characters,
          'character_details': <String, dynamic>{}, // reset on regenerate
          'moral': moral.isNotEmpty ? moral : _getLesson(theme),
          'story_type': prompt.storyType,
          'main_character_type': prompt.mainCharacter,
          'story_setting': prompt.setting,
          'time_era': prompt.scriptureSubtype ?? scripture,
          'narrative_perspective': 'Third Person',
          'language_style': options.language.displayName,
          'emotional_tone': 'Inspiring',
          'narrative_style': options.format.displayName,
          'plot_structure':
              '${options.length.displayName} ${options.length.description}',
          'story_length':
              '${options.length.displayName} ${options.length.description}',
          'tags': <String>[],
        },
        'author_id': author.id,
        'author': author.displayName,
        'image_url': null,
        'updated_at': DateTime.now().toIso8601String(),
      };
      final response = await SupabaseService.client
          .from('stories')
          .update(storyMap)
          .eq('id', original.id)
          .select()
          .single();

      return Right(_mapSupabaseRowToStory(response));
    } catch (e) {
      return Left(ServerFailure('Failed to regenerate story: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getCharacterDetails({
    required Story story,
    required String characterName,
    required int currentChapter,
    required String storyLanguage,
  }) async {
    try {
      final result = await _remoteDataSource.interactWithStory(
        storyTitle: story.title,
        storyContent: story.story,
        interactionType: 'characters',
        characterName: characterName,
        currentChapter: currentChapter,
        storyLanguage: storyLanguage,
      );

      // The endpoint returns the full character object (NOT wrapped in {response: ...}).
      if (result.isEmpty) {
        return Left(
          ServerFailure('Empty character details response from server'),
        );
      }

      return Right(result);
    } catch (e) {
      return Left(
        ServerFailure('Failed to get character details: ${e.toString()}'),
      );
    }
  }

  // Helper methods ported for local generation of auxiliary fields
  String _getQuotes(String theme) {
    final quotes = {
      'Dharma (Duty)':
          '"It is better to perform one\'s own duty imperfectly than to master the duty of another." - Bhagavad Gita',
      'Karma (Action)':
          '"You have the right to work, but never to the fruit of work." - Bhagavad Gita',
      'Bhakti (Devotion)':
          '"Whatever you do, whatever you eat, whatever you offer or give away, do it as an offering to Me." - Bhagavad Gita',
      'Moksha (Liberation)':
          '"The soul is neither born, and nor does it die." - Bhagavad Gita',
      'Knowledge & Wisdom':
          '"There is no purifier equal to knowledge in this world." - Bhagavad Gita',
    };
    // Return a random default if theme matches none or generic
    return quotes[theme] ??
        '"Truth alone triumphs, not falsehood." - Mundaka Upanishad';
  }

  String _getTrivia(String scripture) {
    final trivia = {
      'Mahabharata':
          'The Mahabharata is one of the longest epic poems in the world, with over 100,000 shlokas (couplets).',
      'Ramayana':
          'The Ramayana was composed by Sage Valmiki, who is often called the "Adi Kavi" (first poet).',
      'Bhāgavata Purāṇa':
          'The Bhagavata Purana contains 18,000 verses and is considered the most popular of all Puranas.',
      'Upanishads':
          'The Upanishads are the philosophical core of the Vedas and form the basis of Vedanta philosophy.',
    };
    // Simple partial match check
    for (final key in trivia.keys) {
      if (scripture.contains(key)) return trivia[key]!;
    }
    return 'Ancient Indian scriptures were passed down orally for thousands of years before being written.';
  }

  String _getActivity(String theme) {
    return 'Reflect on how the theme of "$theme" manifests in your daily life. Journal about one instance where you practiced or witnessed this principle today.';
  }

  String _getLesson(String theme) {
    final lessons = {
      'Dharma (Duty)':
          'Understanding and fulfilling our duties without attachment to results leads to inner peace and spiritual growth.',
      'Karma (Action)':
          'Every action has consequences that shape our future. Act wisely and with pure intentions.',
      'Bhakti (Devotion)':
          'True devotion transforms every moment into a sacred offering, connecting us with the divine.',
      'Moksha (Liberation)':
          'Liberation comes through knowledge, devotion, and the realization of our true eternal nature.',
      'Knowledge & Wisdom':
          'Wisdom is not merely knowing facts, but understanding the deeper truths that guide righteous living.',
    };
    return lessons[theme] ??
        'Every story carries within it seeds of wisdom. Water these seeds with reflection, and watch understanding bloom.';
  }

  static const String _storyChatTable = 'story_chats';

  @override
  Future<Either<Failure, StoryChatConversation>> getOrCreateStoryChat({
    required Story story,
  }) async {
    try {
      final user = SupabaseService.client.auth.currentUser;
      if (user == null) {
        return Left(ServerFailure('User not authenticated'));
      }

      final existing = await SupabaseService.client
          .from(_storyChatTable)
          .select()
          .eq('story_id', story.id)
          .eq('user_id', user.id)
          .limit(1);

      if (existing.isNotEmpty) {
        return Right(
          StoryChatConversation.fromSupabaseRow(
            existing.first,
          ),
        );
      }

      final now = DateTime.now();
      final initial = StoryChatMessage(
        sender: 'bot',
        text:
            "Let's discuss “${story.title}”. Ask me anything about the story, characters, themes, or events.",
        timestamp: now,
        storyContext: _buildStoryContext(story),
      );

      final insertBody = {
        'story_id': story.id,
        'user_id': user.id,
        'messages': [initial.toJson()],
      };

      final row = await SupabaseService.client
          .from(_storyChatTable)
          .insert(insertBody)
          .select()
          .single();

      return Right(StoryChatConversation.fromSupabaseRow(row));
    } catch (e) {
      return Left(ServerFailure('Failed to load story chat: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, StoryChatConversation>> sendStoryChatMessage({
    required Story story,
    required StoryChatConversation conversation,
    required String message,
    required String language,
  }) async {
    try {
      final user = SupabaseService.client.auth.currentUser;
      if (user == null) {
        return Left(ServerFailure('User not authenticated'));
      }

      final now = DateTime.now();

      final updatedMessages = <StoryChatMessage>[
        ...conversation.messages,
        StoryChatMessage(sender: 'user', text: message, timestamp: now),
      ];

      final botText = await _remoteDataSource.chat(
        messages: updatedMessages.map((m) => m.toJson()).toList(),
        mode: 'story_scholar',
        storyContext: _buildStoryContext(story),
        language: language,
      );

      final withBot = <StoryChatMessage>[
        ...updatedMessages,
        StoryChatMessage(sender: 'bot', text: botText, timestamp: DateTime.now()),
      ];

      final updateBody = {
        'messages': withBot.map((m) => m.toJson()).toList(),
        'updated_at': DateTime.now().toIso8601String(),
      };

      final row = await SupabaseService.client
          .from(_storyChatTable)
          .update(updateBody)
          .eq('id', conversation.id)
          .select()
          .single();

      return Right(StoryChatConversation.fromSupabaseRow(row));
    } catch (e) {
      return Left(ServerFailure('Failed to send message: ${e.toString()}'));
    }
  }

  Map<String, dynamic> _buildStoryContext(Story story) {
    return {
      'title': story.title,
      'story': story.story,
      'scripture': story.scripture,
      'theme': story.attributes.theme,
      'moral': story.lesson,
      'characters': story.attributes.characters,
    };
  }
}
