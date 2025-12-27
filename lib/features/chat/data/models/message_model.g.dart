// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageModelAdapter extends TypeAdapter<MessageModel> {
  @override
  final typeId = 11;

  @override
  MessageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageModel(
      id: fields[0] as String,
      conversationId: fields[1] as String,
      senderId: fields[2] as String,
      senderName: fields[3] as String,
      senderAvatar: fields[4] as String,
      text: fields[5] as String,
      timestamp: fields[6] as DateTime,
      deliveryStatus: fields[7] == null
          ? MessageDeliveryStatus.sending
          : fields[7] as MessageDeliveryStatus,
      readBy: fields[8] == null ? [] : (fields[8] as List).cast<String>(),
      sharedStoryId: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MessageModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.conversationId)
      ..writeByte(2)
      ..write(obj.senderId)
      ..writeByte(3)
      ..write(obj.senderName)
      ..writeByte(4)
      ..write(obj.senderAvatar)
      ..writeByte(5)
      ..write(obj.text)
      ..writeByte(6)
      ..write(obj.timestamp)
      ..writeByte(7)
      ..write(obj.deliveryStatus)
      ..writeByte(8)
      ..write(obj.readBy)
      ..writeByte(9)
      ..write(obj.sharedStoryId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageModel _$MessageModelFromJson(Map<String, dynamic> json) =>
    _MessageModel(
      id: json['id'] as String,
      conversationId: json['conversationId'] as String,
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String,
      senderAvatar: json['senderAvatar'] as String,
      text: json['text'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      deliveryStatus:
          $enumDecodeNullable(
            _$MessageDeliveryStatusEnumMap,
            json['deliveryStatus'],
          ) ??
          MessageDeliveryStatus.sending,
      readBy:
          (json['readBy'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      sharedStoryId: json['sharedStoryId'] as String?,
    );

Map<String, dynamic> _$MessageModelToJson(
  _MessageModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'conversationId': instance.conversationId,
  'senderId': instance.senderId,
  'senderName': instance.senderName,
  'senderAvatar': instance.senderAvatar,
  'text': instance.text,
  'timestamp': instance.timestamp.toIso8601String(),
  'deliveryStatus': _$MessageDeliveryStatusEnumMap[instance.deliveryStatus]!,
  'readBy': instance.readBy,
  'sharedStoryId': instance.sharedStoryId,
};

const _$MessageDeliveryStatusEnumMap = {
  MessageDeliveryStatus.sending: 'sending',
  MessageDeliveryStatus.sent: 'sent',
  MessageDeliveryStatus.delivered: 'delivered',
  MessageDeliveryStatus.read: 'read',
  MessageDeliveryStatus.failed: 'failed',
};
