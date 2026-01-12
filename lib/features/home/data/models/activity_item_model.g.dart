// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivityItemModelAdapter extends TypeAdapter<ActivityItemModel> {
  @override
  final typeId = 51;

  @override
  ActivityItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActivityItemModel(
      id: fields[0] as String,
      typeIndex: (fields[1] as num).toInt(),
      storyId: fields[2] as String,
      storyTitle: fields[3] as String,
      timestamp: fields[4] as DateTime,
      thumbnailUrl: fields[5] as String?,
      scripture: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ActivityItemModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.typeIndex)
      ..writeByte(2)
      ..write(obj.storyId)
      ..writeByte(3)
      ..write(obj.storyTitle)
      ..writeByte(4)
      ..write(obj.timestamp)
      ..writeByte(5)
      ..write(obj.thumbnailUrl)
      ..writeByte(6)
      ..write(obj.scripture);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
