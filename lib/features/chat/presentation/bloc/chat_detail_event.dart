import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_detail_event.freezed.dart';

@freezed
sealed class ChatDetailEvent with _$ChatDetailEvent {
  const factory ChatDetailEvent.loadMessages(String conversationId) =
      LoadMessagesEvent;
  const factory ChatDetailEvent.sendMessage({
    required String conversationId,
    required String text,
  }) = SendMessageEvent;
  const factory ChatDetailEvent.sendStoryMessage({
    required String conversationId,
    required String storyId,
  }) = SendStoryMessageEvent;
  const factory ChatDetailEvent.markAsRead({
    required String conversationId,
    required List<String> messageIds,
  }) = MarkAsReadEvent;
  const factory ChatDetailEvent.typingStarted(String conversationId) =
      TypingStartedEvent;
  const factory ChatDetailEvent.typingStopped(String conversationId) =
      TypingStoppedEvent;
}
