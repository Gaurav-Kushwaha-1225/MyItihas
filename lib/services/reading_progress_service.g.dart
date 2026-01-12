// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_progress_service.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReadingProgressAdapter extends TypeAdapter<ReadingProgress> {
  @override
  final typeId = 50;

  @override
  ReadingProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReadingProgress(
      storyId: fields[0] as String,
      storyTitle: fields[1] as String,
      scrollPosition: (fields[2] as num).toDouble(),
      totalLength: (fields[3] as num).toDouble(),
      lastReadAt: fields[4] as DateTime,
      thumbnailUrl: fields[5] as String?,
      scripture: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ReadingProgress obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.storyId)
      ..writeByte(1)
      ..write(obj.storyTitle)
      ..writeByte(2)
      ..write(obj.scrollPosition)
      ..writeByte(3)
      ..write(obj.totalLength)
      ..writeByte(4)
      ..write(obj.lastReadAt)
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
      other is ReadingProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
