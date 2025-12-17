// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageDeliveryStatusAdapter extends TypeAdapter<MessageDeliveryStatus> {
  @override
  final typeId = 18;

  @override
  MessageDeliveryStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MessageDeliveryStatus.sending;
      case 1:
        return MessageDeliveryStatus.sent;
      case 2:
        return MessageDeliveryStatus.delivered;
      case 3:
        return MessageDeliveryStatus.read;
      case 4:
        return MessageDeliveryStatus.failed;
      default:
        return MessageDeliveryStatus.sending;
    }
  }

  @override
  void write(BinaryWriter writer, MessageDeliveryStatus obj) {
    switch (obj) {
      case MessageDeliveryStatus.sending:
        writer.writeByte(0);
      case MessageDeliveryStatus.sent:
        writer.writeByte(1);
      case MessageDeliveryStatus.delivered:
        writer.writeByte(2);
      case MessageDeliveryStatus.read:
        writer.writeByte(3);
      case MessageDeliveryStatus.failed:
        writer.writeByte(4);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageDeliveryStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
