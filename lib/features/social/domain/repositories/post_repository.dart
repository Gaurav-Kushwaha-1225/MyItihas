import 'package:fpdart/fpdart.dart';
import 'package:myitihas/core/errors/failures.dart';
import 'package:myitihas/features/social/domain/entities/content_type.dart';
import 'package:myitihas/features/social/domain/entities/feed_item.dart';
import 'package:myitihas/features/social/domain/entities/image_post.dart';
import 'package:myitihas/features/social/domain/entities/text_post.dart';

/// Repository interface for managing posts (image and text posts)
abstract class PostRepository {
  /// Get all image posts with pagination
  Future<Either<Failure, List<ImagePost>>> getImagePosts({
    int limit = 10,
    int offset = 0,
  });

  /// Get all text posts with pagination
  Future<Either<Failure, List<TextPost>>> getTextPosts({
    int limit = 10,
    int offset = 0,
  });

  /// Get all feed items (stories, image posts, text posts) combined
  Future<Either<Failure, List<FeedItem>>> getAllFeedItems({
    int limit = 10,
    int offset = 0,
  });

  /// Like a piece of content (generic for any content type)
  Future<Either<Failure, void>> likeContent({
    required String contentId,
    required ContentType contentType,
  });

  /// Unlike a piece of content
  Future<Either<Failure, void>> unlikeContent({
    required String contentId,
    required ContentType contentType,
  });

  /// Check if content is liked by current user
  Future<Either<Failure, bool>> isContentLiked({
    required String contentId,
    required ContentType contentType,
  });

  /// Toggle bookmark on a piece of content
  Future<Either<Failure, void>> toggleBookmark({
    required String contentId,
    required ContentType contentType,
  });

  /// Get a single image post by ID
  Future<Either<Failure, ImagePost>> getImagePostById(String id);

  /// Get a single text post by ID
  Future<Either<Failure, TextPost>> getTextPostById(String id);
}
