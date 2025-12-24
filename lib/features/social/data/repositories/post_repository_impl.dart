import 'dart:math';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:myitihas/core/errors/failures.dart';
import 'package:myitihas/features/social/domain/entities/content_type.dart';
import 'package:myitihas/features/social/domain/entities/feed_item.dart';
import 'package:myitihas/features/social/domain/entities/image_post.dart';
import 'package:myitihas/features/social/domain/entities/text_post.dart';
import 'package:myitihas/features/social/domain/entities/user.dart';
import 'package:myitihas/features/social/domain/entities/video_post.dart';
import 'package:myitihas/features/social/domain/repositories/post_repository.dart';
import 'package:myitihas/features/social/domain/repositories/user_repository.dart';
import 'package:myitihas/features/stories/domain/repositories/story_repository.dart';

@LazySingleton(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  final UserRepository userRepository;
  final StoryRepository storyRepository;
  final Random _random = Random();

  final Set<String> _likedContent = {};
  final Set<String> _bookmarkedContent = {};

  List<ImagePost>? _cachedImagePosts;
  List<TextPost>? _cachedTextPosts;
  List<VideoPost>? _cachedVideoPosts;

  PostRepositoryImpl({
    required this.userRepository,
    required this.storyRepository,
  });

  List<User> get _mockUsers => [
    const User(
      id: 'user_1',
      username: 'mythology_lover',
      displayName: 'Arjun Sharma',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=arjun',
      bio: 'Exploring the depths of Indian mythology',
      followerCount: 1250,
      followingCount: 340,
    ),
    const User(
      id: 'user_2',
      username: 'vedic_scholar',
      displayName: 'Priya Menon',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=priya',
      bio: 'Sanskrit enthusiast | Mythology researcher',
      followerCount: 3420,
      followingCount: 180,
    ),
    const User(
      id: 'user_3',
      username: 'temple_explorer',
      displayName: 'Ravi Kumar',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=ravi',
      bio: 'Documenting ancient temples across India',
      followerCount: 8900,
      followingCount: 420,
    ),
    const User(
      id: 'user_4',
      username: 'dharma_insights',
      displayName: 'Lakshmi Iyer',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=lakshmi',
      bio: 'Sharing wisdom from our sacred texts',
      followerCount: 5600,
      followingCount: 290,
    ),
    const User(
      id: 'user_5',
      username: 'epic_tales',
      displayName: 'Krishna Das',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=krishna',
      bio: 'Storyteller | Mahabharata & Ramayana specialist',
      followerCount: 12400,
      followingCount: 150,
    ),
  ];

  List<ImagePost> _generateMockImagePosts() {
    if (_cachedImagePosts != null) return _cachedImagePosts!;

    final imageData = [
      {
        'id': 'img_1',
        'imageUrl':
            'https://images.unsplash.com/photo-1544813545-4827b64fcacb?w=800',
        'caption':
            'The magnificent Brihadeeswarar Temple at sunset 🌅 Built by Raja Raja Chola I in 1010 CE, this temple stands as a testament to Chola architecture.',
        'location': 'Thanjavur, Tamil Nadu',
        'aspectRatio': 1.33,
        'tags': ['temple', 'chola', 'architecture'],
      },
      {
        'id': 'img_2',
        'imageUrl':
            'https://images.unsplash.com/photo-1602508000477-d95e7e0eb3c9?w=800',
        'caption':
            'Ancient sculptures at Ellora Caves depicting scenes from Hindu mythology. Each carving tells a story of devotion and artistry.',
        'location': 'Ellora, Maharashtra',
        'aspectRatio': 0.75,
        'tags': ['caves', 'sculpture', 'heritage'],
      },
      {
        'id': 'img_3',
        'imageUrl':
            'https://images.unsplash.com/photo-1524492412937-b28074a5d7da?w=800',
        'caption':
            'The sacred banks of Ganges at Varanasi. Witnessing the morning aarti is a spiritual experience like no other.',
        'location': 'Varanasi, Uttar Pradesh',
        'aspectRatio': 1.5,
        'tags': ['ganges', 'varanasi', 'spiritual'],
      },
      {
        'id': 'img_4',
        'imageUrl':
            'https://images.unsplash.com/photo-1590077428593-a55bb07c4665?w=800',
        'caption':
            'Intricate carvings at Khajuraho temples showcase the pinnacle of medieval Indian art. Every detail is a masterpiece.',
        'location': 'Khajuraho, Madhya Pradesh',
        'aspectRatio': 1.0,
        'tags': ['khajuraho', 'art', 'medieval'],
      },
      {
        'id': 'img_5',
        'imageUrl':
            'https://images.unsplash.com/photo-1561361513-2d000a50f0dc?w=800',
        'caption':
            'The golden spire of Somnath Temple against the azure sky. One of the 12 Jyotirlingas, rebuilt multiple times throughout history.',
        'location': 'Somnath, Gujarat',
        'aspectRatio': 0.8,
        'tags': ['somnath', 'jyotirlinga', 'shiva'],
      },
      {
        'id': 'img_6',
        'imageUrl':
            'https://images.unsplash.com/photo-1606293926075-69a00dbfde81?w=800',
        'caption':
            'Traditional Kathakali dancers portraying scenes from the Mahabharata. The elaborate costumes take hours to prepare.',
        'location': 'Kerala',
        'aspectRatio': 1.2,
        'tags': ['kathakali', 'dance', 'mahabharata'],
      },
      {
        'id': 'img_7',
        'imageUrl':
            'https://images.unsplash.com/photo-1582510003544-4d00b7f74220?w=800',
        'caption':
            'Morning prayers at the Jagannath Temple. The devotion of millions keeps these ancient traditions alive.',
        'location': 'Puri, Odisha',
        'aspectRatio': 1.33,
        'tags': ['jagannath', 'puri', 'devotion'],
      },
      {
        'id': 'img_8',
        'imageUrl':
            'https://images.unsplash.com/photo-1604871000636-074fa5117945?w=800',
        'caption':
            'The majestic Meenakshi Temple towers painted in vibrant colors. A living example of Dravidian architecture.',
        'location': 'Madurai, Tamil Nadu',
        'aspectRatio': 0.67,
        'tags': ['meenakshi', 'madurai', 'dravidian'],
      },
    ];

    _cachedImagePosts = imageData.asMap().entries.map((entry) {
      final data = entry.value;
      final user = _mockUsers[entry.key % _mockUsers.length];
      final daysAgo = _random.nextInt(30);

      return ImagePost(
        id: data['id'] as String,
        imageUrl: data['imageUrl'] as String,
        caption: data['caption'] as String,
        location: data['location'] as String,
        aspectRatio: data['aspectRatio'] as double,
        tags: (data['tags'] as List).cast<String>(),
        authorId: user.id,
        authorUser: user,
        createdAt: DateTime.now().subtract(Duration(days: daysAgo)),
        likes: _random.nextInt(500) + 50,
        commentCount: _random.nextInt(50) + 5,
        shareCount: _random.nextInt(30) + 2,
        isLikedByCurrentUser: _likedContent.contains(data['id']),
        isFavorite: _bookmarkedContent.contains(data['id']),
      );
    }).toList();

    return _cachedImagePosts!;
  }

  List<TextPost> _generateMockTextPosts() {
    if (_cachedTextPosts != null) return _cachedTextPosts!;

    final textData = [
      {
        'id': 'txt_1',
        'body':
            '"The soul is neither born, and nor does it die." - Bhagavad Gita 2.20\n\nThis verse reminds us that our true self is eternal and unchanging.',
        'imageUrl':
            'https://images.unsplash.com/photo-1609619385002-f40f8e7c8945?w=800',
        'backgroundColor': 0xFF1A237E,
        'textColor': 0xFFFFFFFF,
        'fontSize': 20.0,
        'tags': ['gita', 'wisdom', 'soul'],
      },
      {
        'id': 'txt_2',
        'body':
            'Did you know? 🤔\n\nThe Mahabharata is the longest epic poem ever written, containing about 1.8 million words!',
        'imageUrl': null,
        'backgroundColor': 0xFF00695C,
        'textColor': 0xFFFFFFFF,
        'fontSize': 18.0,
        'tags': ['mahabharata', 'facts', 'epic'],
      },
      {
        'id': 'txt_3',
        'body':
            'Karma is not about punishment. It\'s the universe\'s way of teaching us through experience.',
        'imageUrl':
            'https://images.unsplash.com/photo-1545126178-862cdb469409?w=800',
        'backgroundColor': 0xFF4A148C,
        'textColor': 0xFFFFFFFF,
        'fontSize': 19.0,
        'tags': ['karma', 'philosophy', 'wisdom'],
      },
      {
        'id': 'txt_4',
        'body':
            '"In the midst of movement and chaos, keep stillness inside of you." - Deepak Chopra',
        'imageUrl': null,
        'backgroundColor': 0xFFBF360C,
        'textColor': 0xFFFFFFFF,
        'fontSize': 20.0,
        'tags': ['yoga', 'mindfulness', 'quote'],
      },
      {
        'id': 'txt_5',
        'body':
            'The five Pandavas represent:\n\n🏹 Arjuna - Focus & Skill\n💪 Bhima - Strength\n👑 Yudhishthira - Dharma\n🌟 Nakula - Beauty\n📚 Sahadeva - Wisdom',
        'imageUrl':
            'https://images.unsplash.com/photo-1524492412937-b28074a5d7da?w=800',
        'backgroundColor': 0xFF1B5E20,
        'textColor': 0xFFFFFFFF,
        'fontSize': 17.0,
        'tags': ['pandavas', 'mahabharata', 'symbolism'],
      },
      {
        'id': 'txt_6',
        'body':
            '"When you change the way you look at things, the things you look at change."\n\nThe essence of Drishti.',
        'imageUrl': null,
        'backgroundColor': 0xFF311B92,
        'textColor': 0xFFE1BEE7,
        'fontSize': 20.0,
        'tags': ['yoga', 'drishti', 'perspective'],
      },
      {
        'id': 'txt_7',
        'body':
            'Fun facts about Hanuman:\n\n🐒 He is immortal (Chiranjeevi)\n🌞 He mistook the sun for a fruit\n💪 His strength has no known limit',
        'imageUrl':
            'https://images.unsplash.com/photo-1590077428593-a55bb07c4665?w=800',
        'backgroundColor': 0xFFE65100,
        'textColor': 0xFFFFFFFF,
        'fontSize': 17.0,
        'tags': ['hanuman', 'ramayana', 'facts'],
      },
      {
        'id': 'txt_8',
        'body':
            '"Yoga is the journey of the self, through the self, to the self." - Bhagavad Gita\n\n🧘‍♀️ Starting my 108-day meditation challenge!',
        'imageUrl': null,
        'backgroundColor': 0xFF0D47A1,
        'textColor': 0xFFBBDEFB,
        'fontSize': 19.0,
        'tags': ['yoga', 'meditation', 'gita'],
      },
    ];

    _cachedTextPosts = textData.asMap().entries.map((entry) {
      final data = entry.value;
      final user = _mockUsers[(entry.key + 2) % _mockUsers.length];
      final daysAgo = _random.nextInt(30);

      return TextPost(
        id: data['id'] as String,
        body: data['body'] as String,
        imageUrl: data['imageUrl'] as String?,
        backgroundColor: data['backgroundColor'] as int,
        textColor: data['textColor'] as int,
        fontSize: data['fontSize'] as double,
        tags: (data['tags'] as List).cast<String>(),
        authorId: user.id,
        authorUser: user,
        createdAt: DateTime.now().subtract(Duration(days: daysAgo)),
        likes: _random.nextInt(300) + 20,
        commentCount: _random.nextInt(40) + 3,
        shareCount: _random.nextInt(25) + 1,
        isLikedByCurrentUser: _likedContent.contains(data['id']),
        isFavorite: _bookmarkedContent.contains(data['id']),
      );
    }).toList();

    return _cachedTextPosts!;
  }

  List<VideoPost> _generateMockVideoPosts() {
    if (_cachedVideoPosts != null) return _cachedVideoPosts!;

    final videoData = [
      {
        'id': 'vid_1',
        'videoUrl':
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
        'thumbnailUrl':
            'https://images.unsplash.com/photo-1544813545-4827b64fcacb?w=800',
        'caption': 'The mesmerizing evening aarti at Varanasi ghats 🪔✨',
        'location': 'Varanasi, UP',
        'durationSeconds': 45,
        'tags': ['aarti', 'varanasi', 'spiritual'],
      },
      {
        'id': 'vid_2',
        'videoUrl':
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
        'thumbnailUrl':
            'https://images.unsplash.com/photo-1602508000477-d95e7e0eb3c9?w=800',
        'caption': 'Walking through the ancient corridors of Ellora caves 🏛️',
        'location': 'Ellora, Maharashtra',
        'durationSeconds': 60,
        'tags': ['caves', 'heritage', 'architecture'],
      },
      {
        'id': 'vid_3',
        'videoUrl':
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
        'thumbnailUrl':
            'https://images.unsplash.com/photo-1606293926075-69a00dbfde81?w=800',
        'caption':
            'Kathakali performance - The art of storytelling through dance 💃',
        'location': 'Kerala',
        'durationSeconds': 90,
        'tags': ['kathakali', 'dance', 'tradition'],
      },
      {
        'id': 'vid_4',
        'videoUrl':
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
        'thumbnailUrl':
            'https://images.unsplash.com/photo-1561361513-2d000a50f0dc?w=800',
        'caption': 'Sunrise at Somnath Temple - One of the 12 Jyotirlingas 🌅',
        'location': 'Somnath, Gujarat',
        'durationSeconds': 30,
        'tags': ['somnath', 'jyotirlinga', 'sunrise'],
      },
      {
        'id': 'vid_5',
        'videoUrl':
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
        'thumbnailUrl':
            'https://images.unsplash.com/photo-1582510003544-4d00b7f74220?w=800',
        'caption': 'The sacred Rath Yatra festival of Lord Jagannath 🙏',
        'location': 'Puri, Odisha',
        'durationSeconds': 120,
        'tags': ['rathyatra', 'jagannath', 'festival'],
      },
      {
        'id': 'vid_6',
        'videoUrl':
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
        'thumbnailUrl':
            'https://images.unsplash.com/photo-1604871000636-074fa5117945?w=800',
        'caption': 'The intricate gopuram of Meenakshi Temple 🛕',
        'location': 'Madurai, Tamil Nadu',
        'durationSeconds': 55,
        'tags': ['meenakshi', 'temple', 'dravidian'],
      },
    ];

    _cachedVideoPosts = videoData.asMap().entries.map((entry) {
      final data = entry.value;
      final user = _mockUsers[(entry.key + 1) % _mockUsers.length];
      final daysAgo = _random.nextInt(14);

      return VideoPost(
        id: data['id'] as String,
        videoUrl: data['videoUrl'] as String,
        thumbnailUrl: data['thumbnailUrl'] as String?,
        caption: data['caption'] as String,
        location: data['location'] as String,
        durationSeconds: data['durationSeconds'] as int,
        tags: (data['tags'] as List).cast<String>(),
        authorId: user.id,
        authorUser: user,
        createdAt: DateTime.now().subtract(Duration(days: daysAgo)),
        likes: _random.nextInt(1000) + 100,
        commentCount: _random.nextInt(100) + 10,
        shareCount: _random.nextInt(50) + 5,
        viewCount: _random.nextInt(5000) + 500,
        isLikedByCurrentUser: _likedContent.contains(data['id']),
        isFavorite: _bookmarkedContent.contains(data['id']),
      );
    }).toList();

    return _cachedVideoPosts!;
  }

  @override
  Future<Either<Failure, List<ImagePost>>> getImagePosts({
    int limit = 10,
    int offset = 0,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      final allPosts = _generateMockImagePosts();
      final endIndex = (offset + limit).clamp(0, allPosts.length);

      if (offset >= allPosts.length) {
        return const Right([]);
      }

      return Right(allPosts.sublist(offset, endIndex));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TextPost>>> getTextPosts({
    int limit = 10,
    int offset = 0,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      final allPosts = _generateMockTextPosts();
      final endIndex = (offset + limit).clamp(0, allPosts.length);

      if (offset >= allPosts.length) {
        return const Right([]);
      }

      return Right(allPosts.sublist(offset, endIndex));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<VideoPost>>> getVideoPosts({
    int limit = 10,
    int offset = 0,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      final allPosts = _generateMockVideoPosts();
      final endIndex = (offset + limit).clamp(0, allPosts.length);

      if (offset >= allPosts.length) {
        return const Right([]);
      }

      return Right(allPosts.sublist(offset, endIndex));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FeedItem>>> getPosts({
    int limit = 10,
    int offset = 0,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      final imagePosts = _generateMockImagePosts()
          .map((p) => FeedItem.imagePost(p))
          .toList();
      final textPosts = _generateMockTextPosts()
          .map((p) => FeedItem.textPost(p))
          .toList();

      final allPosts = [...imagePosts, ...textPosts];

      allPosts.sort((a, b) {
        final aDate = a.createdAt ?? DateTime.now();
        final bDate = b.createdAt ?? DateTime.now();
        return bDate.compareTo(aDate);
      });

      final endIndex = (offset + limit).clamp(0, allPosts.length);
      if (offset >= allPosts.length) {
        return const Right([]);
      }

      return Right(allPosts.sublist(offset, endIndex));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, VideoPost>> getVideoPostById(String id) async {
    try {
      final posts = _generateMockVideoPosts();
      final post = posts.firstWhere(
        (p) => p.id == id,
        orElse: () => throw Exception('Video post not found'),
      );
      return Right(post);
    } catch (e) {
      return Left(NotFoundFailure('Video post not found', 'NOT_FOUND'));
    }
  }

  @override
  Future<Either<Failure, List<FeedItem>>> getAllFeedItems({
    int limit = 10,
    int offset = 0,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 400));

      final storiesResult = await storyRepository.getStories(
        limit: limit,
        offset: offset,
      );

      final stories = storiesResult.fold(
        (failure) => <FeedItem>[],
        (storyList) => storyList.map((s) => FeedItem.story(s)).toList(),
      );

      final imagePosts = _generateMockImagePosts()
          .map((p) => FeedItem.imagePost(p))
          .toList();
      final textPosts = _generateMockTextPosts()
          .map((p) => FeedItem.textPost(p))
          .toList();
      final videoPosts = _generateMockVideoPosts()
          .map((p) => FeedItem.videoPost(p))
          .toList();

      final allItems = [...stories, ...imagePosts, ...textPosts, ...videoPosts];

      allItems.sort((a, b) {
        final aDate = a.createdAt ?? DateTime.now();
        final bDate = b.createdAt ?? DateTime.now();
        return bDate.compareTo(aDate);
      });

      final endIndex = (offset + limit).clamp(0, allItems.length);
      if (offset >= allItems.length) {
        return const Right([]);
      }

      return Right(allItems.sublist(offset, endIndex));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> likeContent({
    required String contentId,
    required ContentType contentType,
  }) async {
    try {
      _likedContent.add(contentId);
      // Invalidate cache to reflect new state
      _invalidateCache(contentType);
      return const Right(null);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unlikeContent({
    required String contentId,
    required ContentType contentType,
  }) async {
    try {
      _likedContent.remove(contentId);
      _invalidateCache(contentType);
      return const Right(null);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isContentLiked({
    required String contentId,
    required ContentType contentType,
  }) async {
    try {
      return Right(_likedContent.contains(contentId));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleBookmark({
    required String contentId,
    required ContentType contentType,
  }) async {
    try {
      if (_bookmarkedContent.contains(contentId)) {
        _bookmarkedContent.remove(contentId);
      } else {
        _bookmarkedContent.add(contentId);
      }
      _invalidateCache(contentType);
      return const Right(null);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ImagePost>> getImagePostById(String id) async {
    try {
      final posts = _generateMockImagePosts();
      final post = posts.firstWhere(
        (p) => p.id == id,
        orElse: () => throw Exception('Image post not found'),
      );
      return Right(post);
    } catch (e) {
      return Left(NotFoundFailure('Image post not found', 'NOT_FOUND'));
    }
  }

  @override
  Future<Either<Failure, TextPost>> getTextPostById(String id) async {
    try {
      final posts = _generateMockTextPosts();
      final post = posts.firstWhere(
        (p) => p.id == id,
        orElse: () => throw Exception('Text post not found'),
      );
      return Right(post);
    } catch (e) {
      return Left(NotFoundFailure('Text post not found', 'NOT_FOUND'));
    }
  }

  void _invalidateCache(ContentType contentType) {
    switch (contentType) {
      case ContentType.imagePost:
        _cachedImagePosts = null;
        break;
      case ContentType.textPost:
        _cachedTextPosts = null;
        break;
      case ContentType.videoPost:
        _cachedVideoPosts = null;
        break;
      case ContentType.story:
        // Stories are managed by StoryRepository
        break;
    }
  }
}
