import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'package:myitihas/features/notifications/domain/entities/notification.dart';
import 'package:myitihas/features/social/data/models/user_model.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
@HiveType(typeId: 16)
abstract class NotificationModel with _$NotificationModel {
  const NotificationModel._();

  const factory NotificationModel({
    @HiveField(0) required String id,
    @HiveField(1) required NotificationType type,
    @HiveField(2) required UserModel actorUser,
    @HiveField(3) String? targetStoryId,
    @HiveField(4) String? targetCommentId,
    @HiveField(5) required String contentPreview,
    @HiveField(6) required DateTime timestamp,
    @HiveField(7) @Default(false) bool isRead,
    @HiveField(8) @Default({}) Map<String, dynamic> deepLinkData,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Notification toEntity() {
    return Notification(
      id: id,
      type: type,
      actorUser: actorUser.toEntity(),
      targetStoryId: targetStoryId,
      targetCommentId: targetCommentId,
      contentPreview: contentPreview,
      timestamp: timestamp,
      isRead: isRead,
      deepLinkData: deepLinkData,
    );
  }

  factory NotificationModel.fromEntity(Notification notification) {
    return NotificationModel(
      id: notification.id,
      type: notification.type,
      actorUser: UserModel.fromEntity(notification.actorUser),
      targetStoryId: notification.targetStoryId,
      targetCommentId: notification.targetCommentId,
      contentPreview: notification.contentPreview,
      timestamp: notification.timestamp,
      isRead: notification.isRead,
      deepLinkData: notification.deepLinkData,
    );
  }
}
