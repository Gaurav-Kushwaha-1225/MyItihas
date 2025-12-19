import 'package:fpdart/fpdart.dart';
import 'package:myitihas/core/errors/failures.dart';
import '../entities/comment.dart';
import '../entities/share.dart';

abstract class SocialRepository {
  Future<Either<Failure, void>> likeStory(String storyId);

  Future<Either<Failure, void>> unlikeStory(String storyId);

  Future<Either<Failure, bool>> isStoryLiked(String storyId);

  Future<Either<Failure, int>> getStoryLikeCount(String storyId);

  Future<Either<Failure, Comment>> addComment({
    required String storyId,
    required String text,
    String? parentCommentId,
  });

  Future<Either<Failure, void>> deleteComment(String commentId);

  Future<Either<Failure, void>> likeComment(String commentId);

  Future<Either<Failure, void>> unlikeComment(String commentId);

  Future<Either<Failure, void>> toggleCommentCollapse(String commentId);

  Future<Either<Failure, List<Comment>>> getCommentsTree(String storyId);

  Future<Either<Failure, void>> shareStory({
    required String storyId,
    required ShareType shareType,
    String? recipientId,
  });

  Future<Either<Failure, int>> getStoryShareCount(String storyId);

  Future<Either<Failure, List<Share>>> getStoryShares(String storyId);
}
