// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationTypeAdapter extends TypeAdapter<NotificationType> {
  @override
  final typeId = 19;

  @override
  NotificationType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return NotificationType.storyLike;
      case 1:
        return NotificationType.storyComment;
      case 2:
        return NotificationType.commentReply;
      case 3:
        return NotificationType.follow;
      case 4:
        return NotificationType.directMessage;
      default:
        return NotificationType.storyLike;
    }
  }

  @override
  void write(BinaryWriter writer, NotificationType obj) {
    switch (obj) {
      case NotificationType.storyLike:
        writer.writeByte(0);
      case NotificationType.storyComment:
        writer.writeByte(1);
      case NotificationType.commentReply:
        writer.writeByte(2);
      case NotificationType.follow:
        writer.writeByte(3);
      case NotificationType.directMessage:
        writer.writeByte(4);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
