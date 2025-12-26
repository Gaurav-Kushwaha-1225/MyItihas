// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationModelAdapter extends TypeAdapter<NotificationModel> {
  @override
  final typeId = 16;

  @override
  NotificationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationModel(
      id: fields[0] as String,
      type: fields[1] as NotificationType,
      actorUser: fields[2] as UserModel,
      targetStoryId: fields[3] as String?,
      targetCommentId: fields[4] as String?,
      contentPreview: fields[5] as String,
      timestamp: fields[6] as DateTime,
      isRead: fields[7] == null ? false : fields[7] as bool,
      deepLinkData: fields[8] == null
          ? {}
          : (fields[8] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, NotificationModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.actorUser)
      ..writeByte(3)
      ..write(obj.targetStoryId)
      ..writeByte(4)
      ..write(obj.targetCommentId)
      ..writeByte(5)
      ..write(obj.contentPreview)
      ..writeByte(6)
      ..write(obj.timestamp)
      ..writeByte(7)
      ..write(obj.isRead)
      ..writeByte(8)
      ..write(obj.deepLinkData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    _NotificationModel(
      id: json['id'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      actorUser: UserModel.fromJson(json['actorUser'] as Map<String, dynamic>),
      targetStoryId: json['targetStoryId'] as String?,
      targetCommentId: json['targetCommentId'] as String?,
      contentPreview: json['contentPreview'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String).toLocal(),
      isRead: json['isRead'] as bool? ?? false,
      deepLinkData: json['deepLinkData'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$NotificationModelToJson(_NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'actorUser': instance.actorUser,
      'targetStoryId': instance.targetStoryId,
      'targetCommentId': instance.targetCommentId,
      'contentPreview': instance.contentPreview,
      'timestamp': instance.timestamp.toIso8601String(),
      'isRead': instance.isRead,
      'deepLinkData': instance.deepLinkData,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.storyLike: 'storyLike',
  NotificationType.storyComment: 'storyComment',
  NotificationType.commentReply: 'commentReply',
  NotificationType.follow: 'follow',
  NotificationType.directMessage: 'directMessage',
};
