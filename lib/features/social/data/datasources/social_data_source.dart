import 'package:injectable/injectable.dart';
import 'package:myitihas/core/errors/exceptions.dart';
import 'package:myitihas/features/social/data/datasources/user_data_source.dart';
import 'package:myitihas/features/social/domain/entities/share.dart';
import '../models/comment_model.dart';
import '../models/like_model.dart';
import '../models/share_model.dart';

abstract class SocialDataSource {
  Future<void> likeStory(String userId, String storyId);
  Future<void> unlikeStory(String userId, String storyId);
  Future<bool> isStoryLiked(String userId, String storyId);
  Future<int> getStoryLikeCount(String storyId);
  Future<List<LikeModel>> getStoryLikes(String storyId);

  Future<CommentModel> addComment({
    required String storyId,
    required String userId,
    required String text,
    String? parentCommentId,
  });
  Future<void> deleteComment(String commentId);
  Future<void> likeComment(String userId, String commentId);
  Future<void> unlikeComment(String userId, String commentId);
  Future<void> toggleCommentCollapse(String commentId);
  Future<List<CommentModel>> getComments(String storyId);

  Future<void> shareStory({
    required String userId,
    required String storyId,
    required ShareType shareType,
    String? recipientId,
  });
  Future<int> getStoryShareCount(String storyId);
  Future<List<ShareModel>> getStoryShares(String storyId);
}

@LazySingleton(as: SocialDataSource)
class SocialDataSourceImpl implements SocialDataSource {
  final UserDataSource userDataSource;

  // In-memory storage
  final Map<String, LikeModel> _likes = {}; // key: userId_storyId
  final Map<String, CommentModel> _comments = {}; // key: commentId
  final Map<String, List<String>> _storyComments =
      {}; // key: storyId, value: list of comment IDs
  final Map<String, ShareModel> _shares = {}; // key: unique ID
  final Map<String, Set<String>> _commentLikes =
      {}; // key: commentId, value: set of userIds

  SocialDataSourceImpl(this.userDataSource);

  @override
  Future<void> likeStory(String userId, String storyId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final key = '${userId}_$storyId';
    _likes[key] = LikeModel(
      userId: userId,
      storyId: storyId,
      timestamp: DateTime.now(),
    );
  }

  @override
  Future<void> unlikeStory(String userId, String storyId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final key = '${userId}_$storyId';
    _likes.remove(key);
  }

  @override
  Future<bool> isStoryLiked(String userId, String storyId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final key = '${userId}_$storyId';
    return _likes.containsKey(key);
  }

  @override
  Future<int> getStoryLikeCount(String storyId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _likes.values.where((like) => like.storyId == storyId).length;
  }

  @override
  Future<List<LikeModel>> getStoryLikes(String storyId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _likes.values.where((like) => like.storyId == storyId).toList();
  }

  @override
  Future<CommentModel> addComment({
    required String storyId,
    required String userId,
    required String text,
    String? parentCommentId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final user = await userDataSource.getUserById(userId);

    // Calculate depth
    int depth = 0;
    if (parentCommentId != null) {
      final parentComment = _comments[parentCommentId];
      if (parentComment != null) {
        depth = parentComment.depth + 1;
        if (depth > 3) {
          throw const ValidationException('Maximum comment depth (3) exceeded');
        }
      }
    }

    final comment = CommentModel(
      id: 'comment_${DateTime.now().millisecondsSinceEpoch}',
      storyId: storyId,
      userId: userId,
      userName: user.displayName,
      userAvatar: user.avatarUrl,
      text: text,
      timestamp: DateTime.now(),
      parentCommentId: parentCommentId,
      depth: depth,
    );

    _comments[comment.id] = comment;
    _storyComments.putIfAbsent(storyId, () => []).add(comment.id);

    // If it's a reply, add to parent's replies
    if (parentCommentId != null) {
      final parent = _comments[parentCommentId];
      if (parent != null) {
        final updatedReplies = List<CommentModel>.from(parent.replies)
          ..add(comment);
        _comments[parentCommentId] = parent.copyWith(replies: updatedReplies);
      }
    }

    return comment;
  }

  @override
  Future<void> deleteComment(String commentId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final comment = _comments[commentId];
    if (comment == null) {
      throw const NotFoundException('Comment not found');
    }

    // Remove from story's comment list
    _storyComments[comment.storyId]?.remove(commentId);

    // Remove from parent's replies if it's a reply
    if (comment.parentCommentId != null) {
      final parent = _comments[comment.parentCommentId];
      if (parent != null) {
        final updatedReplies = parent.replies
            .where((r) => r.id != commentId)
            .toList();
        _comments[comment.parentCommentId!] = parent.copyWith(
          replies: updatedReplies,
        );
      }
    }

    // Remove the comment and its replies
    _comments.remove(commentId);
    _commentLikes.remove(commentId);
  }

  @override
  Future<void> likeComment(String userId, String commentId) async {
    await Future.delayed(const Duration(milliseconds: 250));

    _commentLikes.putIfAbsent(commentId, () => {}).add(userId);

    final comment = _comments[commentId];
    if (comment != null) {
      _comments[commentId] = comment.copyWith(
        likeCount: _commentLikes[commentId]!.length,
        isLikedByCurrentUser: true,
      );
    }
  }

  @override
  Future<void> unlikeComment(String userId, String commentId) async {
    await Future.delayed(const Duration(milliseconds: 250));

    _commentLikes[commentId]?.remove(userId);

    final comment = _comments[commentId];
    if (comment != null) {
      _comments[commentId] = comment.copyWith(
        likeCount: _commentLikes[commentId]?.length ?? 0,
        isLikedByCurrentUser: false,
      );
    }
  }

  @override
  Future<void> toggleCommentCollapse(String commentId) async {
    await Future.delayed(const Duration(milliseconds: 150));

    final comment = _comments[commentId];
    if (comment != null) {
      _comments[commentId] = comment.copyWith(
        isCollapsed: !comment.isCollapsed,
      );
    }
  }

  @override
  Future<List<CommentModel>> getComments(String storyId) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final commentIds = _storyComments[storyId] ?? [];
    final comments = commentIds
        .map((id) => _comments[id])
        .whereType<CommentModel>()
        .where((c) => c.parentCommentId == null) // Only top-level comments
        .toList();

    // Sort by timestamp (newest first)
    comments.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return comments;
  }

  @override
  Future<void> shareStory({
    required String userId,
    required String storyId,
    required ShareType shareType,
    String? recipientId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final share = ShareModel(
      userId: userId,
      storyId: storyId,
      shareType: shareType,
      recipientId: recipientId,
      timestamp: DateTime.now(),
    );

    final key = 'share_${DateTime.now().millisecondsSinceEpoch}';
    _shares[key] = share;
  }

  @override
  Future<int> getStoryShareCount(String storyId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _shares.values.where((share) => share.storyId == storyId).length;
  }

  @override
  Future<List<ShareModel>> getStoryShares(String storyId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _shares.values.where((share) => share.storyId == storyId).toList();
  }
}
