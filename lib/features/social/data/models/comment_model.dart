import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'package:myitihas/features/social/domain/entities/comment.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

@freezed
@HiveType(typeId: 13)
abstract class CommentModel with _$CommentModel {
  const CommentModel._();

  const factory CommentModel({
    @HiveField(0) required String id,
    @HiveField(1) required String storyId,
    @HiveField(2) required String userId,
    @HiveField(3) required String userName,
    @HiveField(4) required String userAvatar,
    @HiveField(5) required String text,
    @HiveField(6) required DateTime timestamp,
    @HiveField(7) @Default(0) int likeCount,
    @HiveField(8) String? parentCommentId,
    @HiveField(9) @Default([]) List<CommentModel> replies,
    @HiveField(10) @Default(0) int depth,
    @HiveField(11) @Default(false) bool isCollapsed,
    @HiveField(12) @Default(false) bool isLikedByCurrentUser,
  }) = _CommentModel;

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Comment toEntity() {
    return Comment(
      id: id,
      storyId: storyId,
      userId: userId,
      userName: userName,
      userAvatar: userAvatar,
      text: text,
      timestamp: timestamp,
      likeCount: likeCount,
      parentCommentId: parentCommentId,
      replies: replies.map((r) => r.toEntity()).toList(),
      depth: depth,
      isCollapsed: isCollapsed,
      isLikedByCurrentUser: isLikedByCurrentUser,
    );
  }

  factory CommentModel.fromEntity(Comment comment) {
    return CommentModel(
      id: comment.id,
      storyId: comment.storyId,
      userId: comment.userId,
      userName: comment.userName,
      userAvatar: comment.userAvatar,
      text: comment.text,
      timestamp: comment.timestamp,
      likeCount: comment.likeCount,
      parentCommentId: comment.parentCommentId,
      replies: comment.replies.map((r) => CommentModel.fromEntity(r)).toList(),
      depth: comment.depth,
      isCollapsed: comment.isCollapsed,
      isLikedByCurrentUser: comment.isLikedByCurrentUser,
    );
  }
}
