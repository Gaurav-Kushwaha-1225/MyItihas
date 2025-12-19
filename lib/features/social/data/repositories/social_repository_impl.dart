import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:myitihas/core/errors/exceptions.dart';
import 'package:myitihas/core/errors/failures.dart';
import 'package:myitihas/features/social/domain/repositories/user_repository.dart';
import '../../domain/entities/comment.dart';
import '../../domain/entities/share.dart';
import '../../domain/repositories/social_repository.dart';
import '../datasources/social_data_source.dart';

/// Implementation of SocialRepository
@LazySingleton(as: SocialRepository)
class SocialRepositoryImpl implements SocialRepository {
  final SocialDataSource dataSource;
  final UserRepository userRepository;

  SocialRepositoryImpl({
    required this.dataSource,
    required this.userRepository,
  });

  @override
  Future<Either<Failure, void>> likeStory(String storyId) async {
    try {
      final currentUserResult = await userRepository.getCurrentUser();

      return await currentUserResult.fold((failure) => Left(failure), (
        currentUser,
      ) async {
        await dataSource.likeStory(currentUser.id, storyId);
        return const Right(null);
      });
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unlikeStory(String storyId) async {
    try {
      final currentUserResult = await userRepository.getCurrentUser();

      return await currentUserResult.fold((failure) => Left(failure), (
        currentUser,
      ) async {
        await dataSource.unlikeStory(currentUser.id, storyId);
        return const Right(null);
      });
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isStoryLiked(String storyId) async {
    try {
      final currentUserResult = await userRepository.getCurrentUser();

      return await currentUserResult.fold((failure) => Left(failure), (
        currentUser,
      ) async {
        final isLiked = await dataSource.isStoryLiked(currentUser.id, storyId);
        return Right(isLiked);
      });
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getStoryLikeCount(String storyId) async {
    try {
      final count = await dataSource.getStoryLikeCount(storyId);
      return Right(count);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Comment>> addComment({
    required String storyId,
    required String text,
    String? parentCommentId,
  }) async {
    try {
      final currentUserResult = await userRepository.getCurrentUser();

      return await currentUserResult.fold((failure) => Left(failure), (
        currentUser,
      ) async {
        final commentModel = await dataSource.addComment(
          storyId: storyId,
          userId: currentUser.id,
          text: text,
          parentCommentId: parentCommentId,
        );

        return Right(commentModel.toEntity());
      });
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message, e.code));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteComment(String commentId) async {
    try {
      await dataSource.deleteComment(commentId);
      return const Right(null);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message, e.code));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> likeComment(String commentId) async {
    try {
      final currentUserResult = await userRepository.getCurrentUser();

      return await currentUserResult.fold((failure) => Left(failure), (
        currentUser,
      ) async {
        await dataSource.likeComment(currentUser.id, commentId);
        return const Right(null);
      });
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unlikeComment(String commentId) async {
    try {
      final currentUserResult = await userRepository.getCurrentUser();

      return await currentUserResult.fold((failure) => Left(failure), (
        currentUser,
      ) async {
        await dataSource.unlikeComment(currentUser.id, commentId);
        return const Right(null);
      });
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleCommentCollapse(String commentId) async {
    try {
      await dataSource.toggleCommentCollapse(commentId);
      return const Right(null);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Comment>>> getCommentsTree(String storyId) async {
    try {
      final comments = await dataSource.getComments(storyId);
      return Right(comments.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> shareStory({
    required String storyId,
    required ShareType shareType,
    String? recipientId,
  }) async {
    try {
      final currentUserResult = await userRepository.getCurrentUser();

      return await currentUserResult.fold((failure) => Left(failure), (
        currentUser,
      ) async {
        await dataSource.shareStory(
          userId: currentUser.id,
          storyId: storyId,
          shareType: shareType,
          recipientId: recipientId,
        );
        return const Right(null);
      });
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getStoryShareCount(String storyId) async {
    try {
      final count = await dataSource.getStoryShareCount(storyId);
      return Right(count);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Share>>> getStoryShares(String storyId) async {
    try {
      final shares = await dataSource.getStoryShares(storyId);
      return Right(shares.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
