// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShareTypeAdapter extends TypeAdapter<ShareType> {
  @override
  final typeId = 17;

  @override
  ShareType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ShareType.directMessage;
      case 1:
        return ShareType.external;
      default:
        return ShareType.directMessage;
    }
  }

  @override
  void write(BinaryWriter writer, ShareType obj) {
    switch (obj) {
      case ShareType.directMessage:
        writer.writeByte(0);
      case ShareType.external:
        writer.writeByte(1);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShareTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
