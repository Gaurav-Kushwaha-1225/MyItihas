// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommentModelAdapter extends TypeAdapter<CommentModel> {
  @override
  final typeId = 13;

  @override
  CommentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommentModel(
      id: fields[0] as String,
      storyId: fields[1] as String,
      userId: fields[2] as String,
      userName: fields[3] as String,
      userAvatar: fields[4] as String,
      text: fields[5] as String,
      timestamp: fields[6] as DateTime,
      likeCount: fields[7] == null ? 0 : (fields[7] as num).toInt(),
      parentCommentId: fields[8] as String?,
      replies: fields[9] == null
          ? []
          : (fields[9] as List).cast<CommentModel>(),
      depth: fields[10] == null ? 0 : (fields[10] as num).toInt(),
      isCollapsed: fields[11] == null ? false : fields[11] as bool,
      isLikedByCurrentUser: fields[12] == null ? false : fields[12] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CommentModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.storyId)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.userName)
      ..writeByte(4)
      ..write(obj.userAvatar)
      ..writeByte(5)
      ..write(obj.text)
      ..writeByte(6)
      ..write(obj.timestamp)
      ..writeByte(7)
      ..write(obj.likeCount)
      ..writeByte(8)
      ..write(obj.parentCommentId)
      ..writeByte(9)
      ..write(obj.replies)
      ..writeByte(10)
      ..write(obj.depth)
      ..writeByte(11)
      ..write(obj.isCollapsed)
      ..writeByte(12)
      ..write(obj.isLikedByCurrentUser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommentModel _$CommentModelFromJson(Map<String, dynamic> json) =>
    _CommentModel(
      id: json['id'] as String,
      storyId: json['storyId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userAvatar: json['userAvatar'] as String,
      text: json['text'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String).toLocal(),
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      parentCommentId: json['parentCommentId'] as String?,
      replies:
          (json['replies'] as List<dynamic>?)
              ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      depth: (json['depth'] as num?)?.toInt() ?? 0,
      isCollapsed: json['isCollapsed'] as bool? ?? false,
      isLikedByCurrentUser: json['isLikedByCurrentUser'] as bool? ?? false,
    );

Map<String, dynamic> _$CommentModelToJson(_CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'storyId': instance.storyId,
      'userId': instance.userId,
      'userName': instance.userName,
      'userAvatar': instance.userAvatar,
      'text': instance.text,
      'timestamp': instance.timestamp.toIso8601String(),
      'likeCount': instance.likeCount,
      'parentCommentId': instance.parentCommentId,
      'replies': instance.replies,
      'depth': instance.depth,
      'isCollapsed': instance.isCollapsed,
      'isLikedByCurrentUser': instance.isLikedByCurrentUser,
    };
