// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShareModelAdapter extends TypeAdapter<ShareModel> {
  @override
  final typeId = 15;

  @override
  ShareModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShareModel(
      userId: fields[0] as String,
      storyId: fields[1] as String,
      shareType: fields[2] as ShareType,
      recipientId: fields[3] as String?,
      timestamp: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ShareModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.storyId)
      ..writeByte(2)
      ..write(obj.shareType)
      ..writeByte(3)
      ..write(obj.recipientId)
      ..writeByte(4)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShareModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShareModel _$ShareModelFromJson(Map<String, dynamic> json) => _ShareModel(
  userId: json['userId'] as String,
  storyId: json['storyId'] as String,
  shareType: $enumDecode(_$ShareTypeEnumMap, json['shareType']),
  recipientId: json['recipientId'] as String?,
  timestamp: DateTime.parse(json['timestamp'] as String).toLocal(),
);

Map<String, dynamic> _$ShareModelToJson(_ShareModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'storyId': instance.storyId,
      'shareType': _$ShareTypeEnumMap[instance.shareType]!,
      'recipientId': instance.recipientId,
      'timestamp': instance.timestamp.toIso8601String(),
    };

const _$ShareTypeEnumMap = {
  ShareType.directMessage: 'directMessage',
  ShareType.external: 'external',
};
