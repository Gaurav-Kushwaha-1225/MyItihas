import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'package:myitihas/features/chat/domain/entities/conversation.dart';
import 'package:myitihas/features/social/data/models/user_model.dart';
import 'message_model.dart';

part 'conversation_model.freezed.dart';
part 'conversation_model.g.dart';

@freezed
@HiveType(typeId: 12)
abstract class ConversationModel with _$ConversationModel {
  const ConversationModel._();

  const factory ConversationModel({
    @HiveField(0) required String id,
    @HiveField(1) required List<String> participantIds,
    @HiveField(2) required List<UserModel> participants,
    @HiveField(3) MessageModel? lastMessage,
    @HiveField(4) @Default(0) int unreadCount,
    @HiveField(5) required DateTime updatedAt,
  }) = _ConversationModel;

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);

  Conversation toEntity() {
    return Conversation(
      id: id,
      participantIds: participantIds,
      participants: participants.map((p) => p.toEntity()).toList(),
      lastMessage: lastMessage?.toEntity(),
      unreadCount: unreadCount,
      updatedAt: updatedAt,
    );
  }

  factory ConversationModel.fromEntity(Conversation conversation) {
    return ConversationModel(
      id: conversation.id,
      participantIds: conversation.participantIds,
      participants: conversation.participants
          .map((p) => UserModel.fromEntity(p))
          .toList(),
      lastMessage: conversation.lastMessage != null
          ? MessageModel.fromEntity(conversation.lastMessage!)
          : null,
      unreadCount: conversation.unreadCount,
      updatedAt: conversation.updatedAt,
    );
  }
}
