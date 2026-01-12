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
import 'package:myitihas/features/stories/domain/repositories/story_repository.dart';
import 'package:myitihas/services/post_service.dart';
import 'package:myitihas/services/social_service.dart' as social;
import 'package:talker_flutter/talker_flutter.dart';
import 'package:myitihas/core/di/injection_container.dart';

@LazySingleton(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  final PostService _postService;
  final social.SocialService _socialService;
  final StoryRepository _storyRepository;

  PostRepositoryImpl(
    this._postService,
    this._socialService,
    this._storyRepository,
  );

  @override
  Future<Either<Failure, List<ImagePost>>> getImagePosts({
    int limit = 10,
    int offset = 0,
  }) async {
    try {
      final posts = await _postService.getFeed(
        limit: limit,
        offset: offset,
        postType: PostType.image,
      );

      final imagePosts = posts.map((p) => _mapToImagePost(p)).toList();
      return Right(imagePosts);
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
      final posts = await _postService.getFeed(
        limit: limit,
        offset: offset,
        postType: PostType.text,
      );

      final textPosts = posts.map((p) => _mapToTextPost(p)).toList();
      return Right(textPosts);
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
      final posts = await _postService.getFeed(
        limit: limit,
        offset: offset,
        postType: PostType.video,
      );

      final videoPosts = posts.map((p) => _mapToVideoPost(p)).toList();
      return Right(videoPosts);
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
      final posts = await _postService.getFeed(
        limit: limit,
        offset: offset,
      );

      final feedItems = posts.map((p) => _mapToFeedItem(p)).toList();
      return Right(feedItems);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FeedItem>>> getAllFeedItems({
    int limit = 10,
    int offset = 0,
  }) async {
    final logger = getIt<Talker>();

    try {
      // Get stories from story repository
      final storiesResult = await _storyRepository.getStories(
        limit: limit,
        offset: offset,
      );

      final stories = storiesResult.fold(
        (failure) => <FeedItem>[],
        (storyList) => storyList.map((s) => FeedItem.story(s)).toList(),
      );

      // Get posts from Supabase
      final posts = await _postService.getFeed(
        limit: limit,
        offset: offset,
      );

      final postItems = posts.map((p) => _mapToFeedItem(p)).toList();

      // Combine and sort by date
      final allItems = [...stories, ...postItems];
      allItems.sort((a, b) {
        final aDate = a.createdAt ?? DateTime.now();
        final bDate = b.createdAt ?? DateTime.now();
        return bDate.compareTo(aDate);
      });

      // Apply pagination to combined results
      final endIndex = limit.clamp(0, allItems.length);
      logger.debug('[PostRepositoryImpl] Returning $endIndex feed items');

      return Right(allItems.take(endIndex).toList());
    } catch (e) {
      logger.error('[PostRepositoryImpl] Error fetching feed items', e);
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> likeContent({
    required String contentId,
    required ContentType contentType,
  }) async {
    try {
      final socialContentType = _contentTypeToSocialType(contentType);
      await _socialService.likeContent(
        contentType: socialContentType,
        contentId: contentId,
      );
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
      final socialContentType = _contentTypeToSocialType(contentType);
      await _socialService.unlikeContent(
        contentType: socialContentType,
        contentId: contentId,
      );
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
      final socialContentType = _contentTypeToSocialType(contentType);
      final isLiked = await _socialService.isLiked(
        contentType: socialContentType,
        contentId: contentId,
      );
      return Right(isLiked);
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
      final socialContentType = _contentTypeToSocialType(contentType);
      final isBookmarked = await _socialService.isBookmarked(
        contentType: socialContentType,
        contentId: contentId,
      );
      if (isBookmarked) {
        await _socialService.removeBookmark(
          contentType: socialContentType,
          contentId: contentId,
        );
      } else {
        await _socialService.bookmarkContent(
          contentType: socialContentType,
          contentId: contentId,
        );
      }
      return const Right(null);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ImagePost>> getImagePostById(String id) async {
    try {
      final post = await _postService.getPostById(id);
      if (post == null) {
        return Left(NotFoundFailure('Image post not found', 'NOT_FOUND'));
      }
      return Right(_mapToImagePost(post));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TextPost>> getTextPostById(String id) async {
    try {
      final post = await _postService.getPostById(id);
      if (post == null) {
        return Left(NotFoundFailure('Text post not found', 'NOT_FOUND'));
      }
      return Right(_mapToTextPost(post));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, VideoPost>> getVideoPostById(String id) async {
    try {
      final post = await _postService.getPostById(id);
      if (post == null) {
        return Left(NotFoundFailure('Video post not found', 'NOT_FOUND'));
      }
      return Right(_mapToVideoPost(post));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  FeedItem _mapToFeedItem(Map<String, dynamic> data) {
    final postType = data['post_type'] as String? ?? 'text';

    switch (postType) {
      case 'image':
        return FeedItem.imagePost(_mapToImagePost(data));
      case 'video':
        return FeedItem.videoPost(_mapToVideoPost(data));
      case 'text':
      default:
        return FeedItem.textPost(_mapToTextPost(data));
    }
  }

  ImagePost _mapToImagePost(Map<String, dynamic> data) {
    final author = _extractAuthor(data);
    final mediaUrls = _extractMediaUrls(data);

    return ImagePost(
      id: data['id'] as String,
      imageUrl: mediaUrls.isNotEmpty
          ? mediaUrls.first
          : data['thumbnail_url'] as String? ?? '',
      caption: data['content'] as String?,
      location: _extractLocation(data),
      aspectRatio: _extractAspectRatio(data),
      tags: _extractTags(data),
      authorId: data['author_id'] as String,
      authorUser: author,
      createdAt: _parseDateTime(data['created_at']),
      likes: data['likes_count'] as int? ?? 0,
      commentCount: data['comments_count'] as int? ?? 0,
      shareCount: data['shares_count'] as int? ?? 0,
      isLikedByCurrentUser: false, // Will be enriched by BLoC if needed
      isFavorite: false,
    );
  }

  TextPost _mapToTextPost(Map<String, dynamic> data) {
    final author = _extractAuthor(data);
    final metadata = data['metadata'] as Map<String, dynamic>? ?? {};

    return TextPost(
      id: data['id'] as String,
      body: data['content'] as String? ?? '',
      imageUrl: data['thumbnail_url'] as String?,
      backgroundColor: metadata['background_color'] as int? ?? 0xFF1A237E,
      textColor: metadata['text_color'] as int? ?? 0xFFFFFFFF,
      fontSize: (metadata['font_size'] as num?)?.toDouble() ?? 18.0,
      tags: _extractTags(data),
      authorId: data['author_id'] as String,
      authorUser: author,
      createdAt: _parseDateTime(data['created_at']),
      likes: data['likes_count'] as int? ?? 0,
      commentCount: data['comments_count'] as int? ?? 0,
      shareCount: data['shares_count'] as int? ?? 0,
      isLikedByCurrentUser: false,
      isFavorite: false,
    );
  }

  VideoPost _mapToVideoPost(Map<String, dynamic> data) {
    final author = _extractAuthor(data);
    final mediaUrls = _extractMediaUrls(data);
    final metadata = data['metadata'] as Map<String, dynamic>? ?? {};

    return VideoPost(
      id: data['id'] as String,
      videoUrl: mediaUrls.isNotEmpty ? mediaUrls.first : '',
      thumbnailUrl: data['thumbnail_url'] as String?,
      caption: data['content'] as String? ?? '',
      location: _extractLocation(data),
      durationSeconds: metadata['duration_seconds'] as int? ?? 0,
      tags: _extractTags(data),
      authorId: data['author_id'] as String,
      authorUser: author,
      createdAt: _parseDateTime(data['created_at']),
      likes: data['likes_count'] as int? ?? 0,
      commentCount: data['comments_count'] as int? ?? 0,
      shareCount: data['shares_count'] as int? ?? 0,
      viewCount: metadata['view_count'] as int? ?? 0,
      isLikedByCurrentUser: false,
      isFavorite: false,
    );
  }

  User? _extractAuthor(Map<String, dynamic> data) {
    final authorData = data['author'] as Map<String, dynamic>?;
    if (authorData == null) return null;

    return User(
      id: authorData['id'] as String,
      username: authorData['username'] as String? ?? 'unknown',
      displayName: authorData['full_name'] as String? ?? 'Unknown User',
      avatarUrl: authorData['avatar_url'] as String? ?? '',
      bio: '',
      followerCount: 0,
      followingCount: 0,
    );
  }

  List<String> _extractMediaUrls(Map<String, dynamic> data) {
    final mediaUrls = data['media_urls'];
    if (mediaUrls == null) return [];
    if (mediaUrls is List) {
      return mediaUrls.map((e) => e.toString()).toList();
    }
    return [];
  }

  List<String> _extractTags(Map<String, dynamic> data) {
    final metadata = data['metadata'] as Map<String, dynamic>? ?? {};
    final tags = metadata['tags'];
    if (tags == null) return [];
    if (tags is List) {
      return tags.map((e) => e.toString()).toList();
    }
    return [];
  }

  String? _extractLocation(Map<String, dynamic> data) {
    final metadata = data['metadata'] as Map<String, dynamic>? ?? {};
    return metadata['location'] as String?;
  }

  double _extractAspectRatio(Map<String, dynamic> data) {
    final metadata = data['metadata'] as Map<String, dynamic>? ?? {};
    return (metadata['aspect_ratio'] as num?)?.toDouble() ?? 1.0;
  }

  DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  social.ContentType _contentTypeToSocialType(ContentType contentType) {
    switch (contentType) {
      case ContentType.story:
        return social.ContentType.story;
      case ContentType.imagePost:
      case ContentType.textPost:
      case ContentType.videoPost:
        return social.ContentType.post;
    }
  }
}
