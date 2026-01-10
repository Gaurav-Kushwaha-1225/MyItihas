import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/generator_options.dart';
import '../../domain/entities/story_prompt.dart';

@lazySingleton
class RemoteStoryGeneratorDataSource {
  final Dio _dio;
  final String _baseUrl = const String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://ithihas-api.onrender.com', // Correct API URL
  );

  RemoteStoryGeneratorDataSource(this._dio);

  Future<Map<String, dynamic>> generateStory({
    required StoryPrompt prompt,
    required GeneratorOptions options,
  }) async {
    try {
      // Construct a single, comprehensive prompt string matching the web client's logic
      String finalPrompt;
      if (prompt.isRawPrompt && prompt.rawPrompt != null) {
        finalPrompt = prompt.rawPrompt!;
      } else {
        final List<String> parts = [];

        // Base instruction
        if (prompt.scripture != null) {
          parts.add('Create a story from the ${prompt.scripture}.');
        } else {
          parts.add('Create a story from Indian scriptures.');
        }

        // Add parameters if present
        if (prompt.storyType != null) {
          parts.add('Story Type: ${prompt.storyType}');
        }
        if (prompt.theme != null) parts.add('Theme: ${prompt.theme}');
        if (prompt.mainCharacter != null) {
          parts.add('Main Character: ${prompt.mainCharacter}');
        }
        if (prompt.setting != null) parts.add('Setting: ${prompt.setting}');

        // Add options
        parts.add('Story Length: ${_mapLengthToString(options.length)}');
        parts.add('Language Style: ${options.language.displayName}');
        parts.add('Narrative Style: ${options.format.displayName}');

        finalPrompt = parts.join(', ');
      }

      // The web client sends { prompt, provider }, NOT the complex StoryRequest object.
      // This mimics `story-generator.js` behavior to ensure compatibility with deployed backend.
      final requestBody = {
        'prompt': finalPrompt,
        'scripture': prompt.scripture ?? "Ramayana",
        'options': {
          'language': options.language.displayName,
          'display_name': options.format.displayName,
          'description': options.format.description,
          'length':
              '${options.length.displayName} ${options.length.description}',
        },
        'provider': 'openrouter',
        'use_vedabase': false,
      };

      final response = await _dio.post(
        '$_baseUrl/generate_story',
        data: requestBody,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          receiveTimeout: const Duration(seconds: 180), // Extended timeout
        ),
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception(
          'Failed to generate story: ${response.statusCode} ${response.statusMessage}',
        );
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Helper to get random options (mock implementation as backend doesn't support it yet)
  Future<StoryPrompt> getRandomOptions() async {
    throw UnimplementedError('Random options should be handled locally');
  }

  String _mapLengthToString(StoryLength length) {
    switch (length) {
      case StoryLength.short:
        return 'short';
      case StoryLength.medium:
        return 'medium';
      case StoryLength.long:
        return 'long';
      case StoryLength.epic:
        return 'epic';
    }
  }

  Future<Map<String, dynamic>> interactWithStory({
    required String storyTitle,
    required String storyContent,
    required String interactionType, // e.g. "expand"
    String? characterName,
    required int currentChapter,
    required String storyLanguage,
  }) async {
    try {
      final requestBody = {
        'story_title': storyTitle,
        'story_content': storyContent,
        'interaction_type': interactionType,
        'character_name': characterName,
        'current_chapter': currentChapter,
        'story_language': storyLanguage,
      };

      final response = await _dio.post(
        '$_baseUrl/interact_with_story',
        data: requestBody,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          receiveTimeout: const Duration(seconds: 180),
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is Map<String, dynamic>) return data;
        throw Exception('Unexpected response format: ${data.runtimeType}');
      } else {
        throw Exception(
          'Failed to interact with story: ${response.statusCode} ${response.statusMessage}',
        );
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<String> generateStoryImage({
    required String title,
    required String story,
    required String moral,
  }) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/generate_story_image',
        data: {'title': title, 'story': story, 'moral': moral},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          receiveTimeout: const Duration(seconds: 180),
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        // Handle various response formats as seen in web code
        if (data is Map<String, dynamic>) {
          if (data['image_url'] != null) return data['image_url'];
          if (data['imageUrl'] != null) return data['imageUrl'];
          if (data['url'] != null) return data['url'];
        } else if (data is String) {
          return data;
        }
        throw Exception('No image URL found in response');
      } else {
        throw Exception('Failed to generate image: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Image generation error: $e');
    }
  }
}
