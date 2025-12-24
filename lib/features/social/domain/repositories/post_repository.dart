import 'package:fpdart/fpdart.dart';
import 'package:myitihas/core/errors/failures.dart';
import 'package:myitihas/features/social/domain/entities/content_type.dart';
import 'package:myitihas/features/social/domain/entities/feed_item.dart';
import 'package:myitihas/features/social/domain/entities/image_post.dart';
import 'package:myitihas/features/social/domain/entities/text_post.dart';
import 'package:myitihas/features/social/domain/entities/video_post.dart';

abstract class PostRepository {
  Future<Either<Failure, List<ImagePost>>> getImagePosts({
    int limit = 10,
    int offset = 0,
  });

  Future<Either<Failure, List<TextPost>>> getTextPosts({
    int limit = 10,
    int offset = 0,
  });

  Future<Either<Failure, List<VideoPost>>> getVideoPosts({
    int limit = 10,
    int offset = 0,
  });

  Future<Either<Failure, List<FeedItem>>> getPosts({
    int limit = 10,
    int offset = 0,
  });

  Future<Either<Failure, List<FeedItem>>> getAllFeedItems({
    int limit = 10,
    int offset = 0,
  });

  Future<Either<Failure, void>> likeContent({
    required String contentId,
    required ContentType contentType,
  });

  Future<Either<Failure, void>> unlikeContent({
    required String contentId,
    required ContentType contentType,
  });

  Future<Either<Failure, bool>> isContentLiked({
    required String contentId,
    required ContentType contentType,
  });

  Future<Either<Failure, void>> toggleBookmark({
    required String contentId,
    required ContentType contentType,
  });

  Future<Either<Failure, ImagePost>> getImagePostById(String id);

  Future<Either<Failure, TextPost>> getTextPostById(String id);

  Future<Either<Failure, VideoPost>> getVideoPostById(String id);
}
