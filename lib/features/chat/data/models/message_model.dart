import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'package:myitihas/features/chat/domain/entities/message.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
@HiveType(typeId: 11)
abstract class MessageModel with _$MessageModel {
  const MessageModel._();

  const factory MessageModel({
    @HiveField(0) required String id,
    @HiveField(1) required String conversationId,
    @HiveField(2) required String senderId,
    @HiveField(3) required String senderName,
    @HiveField(4) required String senderAvatar,
    @HiveField(5) required String text,
    @HiveField(6) required DateTime timestamp,
    @HiveField(7)
    @Default(MessageDeliveryStatus.sending)
    MessageDeliveryStatus deliveryStatus,
    @HiveField(8) @Default([]) List<String> readBy,
    @HiveField(9) String? sharedStoryId,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Message toEntity() {
    return Message(
      id: id,
      conversationId: conversationId,
      senderId: senderId,
      senderName: senderName,
      senderAvatar: senderAvatar,
      text: text,
      timestamp: timestamp,
      deliveryStatus: deliveryStatus,
      readBy: readBy,
      sharedStoryId: sharedStoryId,
    );
  }

  factory MessageModel.fromEntity(Message message) {
    return MessageModel(
      id: message.id,
      conversationId: message.conversationId,
      senderId: message.senderId,
      senderName: message.senderName,
      senderAvatar: message.senderAvatar,
      text: message.text,
      timestamp: message.timestamp,
      deliveryStatus: message.deliveryStatus,
      readBy: message.readBy,
      sharedStoryId: message.sharedStoryId,
    );
  }
}
