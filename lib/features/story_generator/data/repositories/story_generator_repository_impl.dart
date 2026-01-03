import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:myitihas/core/errors/failures.dart';
import 'package:myitihas/features/social/data/datasources/user_remote_data_source.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
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
      final reference = result['reference'] as String? ?? "";
      final characters = result['characters'] as List<dynamic>;

      // Local fallback generation for UI fields not returned by backend
      final theme = prompt.theme ?? 'Dharma';
      final scripture = prompt.scripture ?? 'Mahabharata';
      Map<String, dynamic> storyMap = {
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
          'moral': moral.isNotEmpty ? moral : _getLesson(theme),
          'story_type': prompt.storyType,
          'main_character_type': prompt.mainCharacter,
          'story_setting': prompt.setting,
          'time_era': prompt.scriptureSubtype ?? scripture,
          'narrative_perspective': 'Third Person',
          'language_style': options.language.displayName,
          'emotional_tone': 'Inspiring',
          'narrative_style': options.format.displayName,
          'plot_structure': '${options.length.displayName} ${options.length.description}',
          'story_length': '${options.length.displayName} ${options.length.description}',
          'tags': [],
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

      final story = _mapSupabaseRowToStory(response);
      return Right(story);
    } catch (e) {
      return Left(ServerFailure('Failed to generate story: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, StoryPrompt>> getRandomOptions() async {
    try {
      // Reuse mock data source for random options since there's no backend endpoint for this
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
        'updated_at': DateTime.now().toIso8601String(),
      };

      final response = await SupabaseService.client
          .from('stories')
          .upsert(data, onConflict: 'id')
          .select()
          .single();

      return Right(_mapSupabaseRowToStory(response));
    } catch (e) {
      return Left(
        ServerFailure('Failed to save generated story: ${e.toString()}'),
      );
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
          .map((row) => _mapSupabaseRowToStory(row))
          .toList();

      return Right(stories);
    } catch (e) {
      return Left(
        ServerFailure('Failed to fetch generated stories: ${e.toString()}'),
      );
    }
  }

  Story _mapSupabaseRowToStory(Map<String, dynamic> row) {
    return Story(
      id: row['id']!.toString(),
      authorId: row['user_id']!.toString(),
      title: row['title']?.toString() ?? 'Untitled Story',
      story: row['content']?.toString() ?? '',
      scripture: row['attributes']['scripture']?.toString() ?? 'Scripture',
      quotes: row['attributes']['quotes']?.toString() ?? '',
      trivia: row['attributes']['trivia']?.toString() ?? '',
      activity: row['attributes']['activity']?.toString() ?? '',
      lesson: row['attributes']['moral']?.toString() ?? '',
      attributes: StoryAttributes(
        storyType: row['attributes']['story_type']?.toString() ?? 'General',
        theme: row['attributes']['theme']?.toString() ?? 'Dharma (Duty)',
        mainCharacterType: row['attributes']['main_character_type']?.toString() ?? 'Protagonist',
        storySetting: row['attributes']['story_setting']?.toString() ?? 'Ancient India',
        timeEra: row['attributes']['time_era']?.toString() ?? 'Ancient',
        narrativePerspective: row['attributes']['narrative_perspective']?.toString() ?? 'Third Person',
        languageStyle: row['language']?.toString() ?? 'English',
        emotionalTone: row['attributes']['emotional_tone']?.toString() ?? 'Inspirational',
        narrativeStyle: row['attributes']['narrative_style']?.toString() ?? 'Narrative',
        plotStructure: row['attributes']['plot_structure']?.toString() ?? 'Linear',
        storyLength: row['attributes']['story_length']?.toString() ?? 'Medium',
        tags: (row['attributes']['tags'] as List<dynamic>? ?? []).map((tag) => tag.toString()).toList(),
        references: [row['attributes']['references']?.toString() ?? ''],
        characters: (row['attributes']['characters'] as List<dynamic>? ?? []).map((char) => char.toString()).toList(),
      ),
      imageUrl: row['image_url']?.toString(),
      createdAt: row['created_at'] != null ? DateTime.parse(row['created_at']?.toString() ?? '') : null,
      publishedAt: row['published_at'] != null ? DateTime.parse(row['published_at']?.toString() ?? '') : null,
      author: row['author']?.toString(),
      likes: row['likes']?.toInt() ?? 0,
      views: row['views']?.toInt() ?? 0,
      isFavorite: row['is_favourite'] as bool? ?? false,
    );
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
}
