import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:myitihas/core/network/websocket_service.dart';
import 'package:myitihas/features/chat/domain/repositories/chat_repository.dart';
import 'chat_detail_event.dart';
import 'chat_detail_state.dart';

/// BLoC for managing individual chat conversation
@injectable
class ChatDetailBloc extends Bloc<ChatDetailEvent, ChatDetailState> {
  final ChatRepository chatRepository;
  final WebSocketService webSocketService;

  StreamSubscription? _webSocketSubscription;

  ChatDetailBloc({required this.chatRepository, required this.webSocketService})
    : super(const ChatDetailState.initial()) {
    on<LoadMessagesEvent>(_onLoadMessages);
    on<SendMessageEvent>(_onSendMessage);
    on<SendStoryMessageEvent>(_onSendStoryMessage);
    on<MarkAsReadEvent>(_onMarkAsRead);
    on<TypingStartedEvent>(_onTypingStarted);
    on<TypingStoppedEvent>(_onTypingStopped);

    _initializeWebSocket();
  }

  void _initializeWebSocket() {
    _webSocketSubscription = webSocketService.eventStream.listen((event) {
      if (event.type == WebSocketEventType.typing) {
        final conversationId = event.data['conversationId'] as String?;

        final currentState = state;
        if (currentState is ChatDetailLoaded &&
            currentState.conversationId == conversationId) {
          add(ChatDetailEvent.loadMessages(currentState.conversationId));
        }
      }
    });
  }

  Future<void> _onLoadMessages(
    LoadMessagesEvent event,
    Emitter<ChatDetailState> emit,
  ) async {
    emit(const ChatDetailState.loading());

    final result = await chatRepository.getMessages(
      conversationId: event.conversationId,
      limit: 50,
    );

    result.fold(
      (failure) => emit(ChatDetailState.error(failure.message)),
      (messages) => emit(
        ChatDetailState.loaded(
          conversationId: event.conversationId,
          messages: messages,
        ),
      ),
    );
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatDetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ChatDetailLoaded) return;

    emit(currentState.copyWith(isSending: true));

    final result = await chatRepository.sendMessage(
      conversationId: event.conversationId,
      text: event.text,
    );

    await result.fold(
      (failure) async {
        emit(currentState.copyWith(isSending: false));
      },
      (message) async {
        final messagesResult = await chatRepository.getMessages(
          conversationId: event.conversationId,
          limit: 50,
        );

        messagesResult.fold(
          (failure) {
            emit(currentState.copyWith(isSending: false));
          },
          (messages) {
            emit(currentState.copyWith(messages: messages, isSending: false));
          },
        );
      },
    );
  }

  Future<void> _onSendStoryMessage(
    SendStoryMessageEvent event,
    Emitter<ChatDetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ChatDetailLoaded) return;

    emit(currentState.copyWith(isSending: true));

    final result = await chatRepository.sendStoryMessage(
      conversationId: event.conversationId,
      storyId: event.storyId,
    );

    await result.fold(
      (failure) async {
        emit(currentState.copyWith(isSending: false));
      },
      (message) async {
        final messagesResult = await chatRepository.getMessages(
          conversationId: event.conversationId,
          limit: 50,
        );

        messagesResult.fold(
          (failure) {
            emit(currentState.copyWith(isSending: false));
          },
          (messages) {
            emit(currentState.copyWith(messages: messages, isSending: false));
          },
        );
      },
    );
  }

  Future<void> _onMarkAsRead(
    MarkAsReadEvent event,
    Emitter<ChatDetailState> emit,
  ) async {
    await chatRepository.markMessagesAsRead(
      conversationId: event.conversationId,
      messageIds: event.messageIds,
    );

    await webSocketService.sendReadReceipt(
      conversationId: event.conversationId,
      messageIds: event.messageIds,
    );
  }

  Future<void> _onTypingStarted(
    TypingStartedEvent event,
    Emitter<ChatDetailState> emit,
  ) async {
    await webSocketService.sendTypingIndicator(
      conversationId: event.conversationId,
      isTyping: true,
    );
  }

  Future<void> _onTypingStopped(
    TypingStoppedEvent event,
    Emitter<ChatDetailState> emit,
  ) async {
    await webSocketService.sendTypingIndicator(
      conversationId: event.conversationId,
      isTyping: false,
    );
  }

  @override
  Future<void> close() {
    _webSocketSubscription?.cancel();
    return super.close();
  }
}
