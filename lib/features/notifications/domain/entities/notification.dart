import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'package:myitihas/features/social/domain/entities/user.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

@HiveType(typeId: 19)
enum NotificationType {
  @HiveField(0)
  storyLike,
  @HiveField(1)
  storyComment,
  @HiveField(2)
  commentReply,
  @HiveField(3)
  follow,
  @HiveField(4)
  directMessage,
}

@freezed
abstract class Notification with _$Notification {
  const factory Notification({
    required String id,
    required NotificationType type,
    required User actorUser,
    String? targetStoryId,
    String? targetCommentId,
    required String contentPreview,
    required DateTime timestamp,
    @Default(false) bool isRead,
    @Default({}) Map<String, dynamic> deepLinkData,
  }) = _Notification;

  const Notification._();
}
