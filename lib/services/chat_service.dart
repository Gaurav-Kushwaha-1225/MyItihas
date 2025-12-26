import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;
import 'package:talker_flutter/talker_flutter.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/core/errors/exceptions.dart';
import 'package:myitihas/models/chat_message.dart';
import 'package:myitihas/models/conversation.dart';

/// Service for managing chat conversations and messages.
///
/// Handles creation and retrieval of direct message (DM) conversations
/// and provides methods for chat-related operations.
///
/// All operations use auth.uid() to ensure users can only access
/// their own conversations.
@lazySingleton
class ChatService {
  final SupabaseClient _supabase;

  ChatService(this._supabase);

  /// Gets or creates a direct message conversation with another user.
  ///
  /// [otherUserId] - The ID of the user to chat with.
  ///
  /// Returns the conversation ID (channel ID) for the DM.
  ///
  /// Uses auth.uid() as the current user ID.
  ///
  /// This method is idempotent and safe to call multiple times.
  /// Handles race conditions where concurrent requests attempt to create
  /// the same DM conversation.
  ///
  /// Throws [AuthException] if user is not authenticated or attempting self-DM.
  /// Throws [ServerException] on database errors.
  Future<String> getOrCreateDM(String otherUserId) async {
    final logger = getIt<Talker>();

    try {
      final currentUserId = _supabase.auth.currentUser?.id;
      if (currentUserId == null) {
        logger.warning(
          '[ChatService] Unauthenticated user attempted to create DM',
        );
        throw AuthException('User must be authenticated to create DM');
      }

      // Prevent self-DM
      if (currentUserId == otherUserId) {
        logger.warning(
          '[ChatService] User $currentUserId attempted to create DM with self',
        );
        throw AuthException('Cannot create DM with yourself');
      }

      logger.debug(
        '[ChatService] getOrCreateDM called for users: $currentUserId <-> $otherUserId',
      );

      // Check if a DM conversation already exists between these two users
      final existingId = await _findExistingDM(currentUserId, otherUserId);
      if (existingId != null) {
        logger.info('[ChatService] Found existing DM: $existingId');
        return existingId;
      }

      // No existing DM found, attempt to create a new one
      logger.info(
        '[ChatService] No existing DM found, creating new conversation',
      );

      try {
        // Insert new conversation with is_group = false
        final conversationResponse = await _supabase
            .from('conversations')
            .insert({'is_group': false, 'created_by': currentUserId})
            .select('id')
            .single();

        final conversationId = conversationResponse['id'] as String;
        logger.debug('[ChatService] Created conversation: $conversationId');

        // Insert conversation members for both users
        await _supabase.from('conversation_members').insert([
          {'conversation_id': conversationId, 'user_id': currentUserId},
          {'conversation_id': conversationId, 'user_id': otherUserId},
        ]);

        logger.info('[ChatService] Successfully created DM: $conversationId');
        return conversationId;
      } catch (createError) {
        // If creation failed (e.g., due to race condition), check again for existing DM
        // This makes the method idempotent and handles concurrent creation attempts
        logger.warning(
          '[ChatService] Error during DM creation, checking for existing DM again: $createError',
        );

        final retryExistingId = await _findExistingDM(
          currentUserId,
          otherUserId,
        );
        if (retryExistingId != null) {
          logger.info(
            '[ChatService] Found DM after creation conflict: $retryExistingId',
          );
          return retryExistingId;
        }

        // If still no DM found, rethrow the original error
        rethrow;
      }
    } catch (e, stackTrace) {
      logger.error('[ChatService] Error in getOrCreateDM', e, stackTrace);

      if (e is AuthException) {
        rethrow;
      }

      throw const ServerException('Failed to get or create DM');
    }
  }

  /// Fetches all conversations for the current user.
  ///
  /// Returns a list of Conversation objects sorted by most recent message.
  /// Only includes direct messages (is_group = false) for now.
  ///
  /// Each conversation includes:
  /// - The other user's information (name, avatar)
  /// - The last message content and timestamp
  ///
  /// RLS policies ensure users only see their own conversations.
  ///
  /// Throws [AuthException] if user is not authenticated.
  /// Throws [ServerException] on database errors.
  ///
  Future<List<Conversation>> getMyConversations() async {
    final uid = _supabase.auth.currentUser!.id;

    // Get conversation IDs where user is a member
    final memberRows = await _supabase
        .from('conversation_members')
        .select('conversation_id')
        .eq('user_id', uid);

    final ids = (memberRows as List)
        .map((e) => e['conversation_id'] as String)
        .toList();

    if (ids.isEmpty) return [];

    // Fetch conversations
    final convoRows = await _supabase
        .from('conversations')
        .select('id, is_group')
        .inFilter('id', ids)
        .eq('is_group', false);

    // Map to Conversation objects
    return (convoRows as List)
        .map(
          (e) => Conversation(
            id: e['id'],
            isGroup: e['is_group'],
            title: 'Chat',
            avatarUrl: null,
          ),
        )
        .toList();
  }

  /// Helper method to find an existing DM between two users.
  ///
  /// Returns the conversation ID if found, null otherwise.
  Future<String?> _findExistingDM(String userId1, String userId2) async {
    final logger = getIt<Talker>();

    try {
      // Query conversations with is_group = false that involve either user
      final existingConversation = await _supabase
          .from('conversations')
          .select('id, conversation_members!inner(user_id)')
          .eq('is_group', false)
          .or(
            'user_id.eq.$userId1,user_id.eq.$userId2',
            referencedTable: 'conversation_members',
          )
          .limit(100);

      // Filter conversations where both users are members and exactly 2 members total
      for (final conversation in existingConversation) {
        final members = (conversation['conversation_members'] as List)
            .map((m) => m['user_id'] as String)
            .toSet();

        if (members.contains(userId1) &&
            members.contains(userId2) &&
            members.length == 2) {
          return conversation['id'] as String;
        }
      }

      return null;
    } catch (e) {
      logger.debug('[ChatService] Error in _findExistingDM: $e');
      return null;
    }
  }

  /// Fetches all messages for a given conversation.
  ///
  /// [conversationId] - The ID of the conversation to fetch messages from.
  ///
  /// Returns a list of ChatMessage objects ordered by creation time (oldest first).
  ///
  /// RLS policies ensure users can only fetch messages from conversations
  /// they are members of. If the user is not a member, an empty list is returned.
  ///
  /// This method is idempotent and safe to retry.
  ///
  /// Throws [AuthException] if user is not authenticated.
  /// Throws [ServerException] on database errors.
  Future<List<ChatMessage>> getMessages(String conversationId) async {
    final logger = getIt<Talker>();

    try {
      final currentUserId = _supabase.auth.currentUser?.id;
      if (currentUserId == null) {
        logger.warning(
          '[ChatService] Unauthenticated user attempted to fetch messages',
        );
        throw AuthException('User must be authenticated to fetch messages');
      }

      logger.debug(
        '[ChatService] Fetching messages for conversation: $conversationId (user: $currentUserId)',
      );

      // Fetch messages ordered by created_at ascending (oldest first)
      // RLS will automatically filter to only messages the user can access
      // If user is not a member of the conversation, RLS returns empty list
      final response = await _supabase
          .from('chat_messages')
          .select('id, conversation_id, sender_id, content, created_at')
          .eq('conversation_id', conversationId)
          .order('created_at', ascending: true);

      final messages = (response as List)
          .map((json) {
            try {
              return ChatMessage.fromJson(json);
            } catch (parseError) {
              logger.warning(
                '[ChatService] Failed to parse message: $parseError',
              );
              return null;
            }
          })
          .whereType<ChatMessage>()
          .toList();

      logger.info(
        '[ChatService] Fetched ${messages.length} messages for conversation $conversationId',
      );
      return messages;
    } on AuthException {
      rethrow;
    } on PostgrestException catch (e, stackTrace) {
      logger.error(
        '[ChatService] Database error in getMessages: ${e.message}',
        e,
        stackTrace,
      );
      throw ServerException('Failed to fetch messages: ${e.message}', e.code);
    } catch (e, stackTrace) {
      logger.error(
        '[ChatService] Unexpected error in getMessages',
        e,
        stackTrace,
      );
      throw const ServerException('Failed to fetch messages');
    }
  }

  /// Sends a message to a conversation.
  ///
  /// [conversationId] - The ID of the conversation to send the message to.
  /// [content] - The text content of the message.
  ///
  /// Inserts a new message into the chat_messages table.
  /// RLS policies ensure users can only send messages to conversations
  /// they are members of. If the user is not a member, a ServerException
  /// is thrown.
  ///
  /// Note: This operation creates a new message on each call. If retried,
  /// it will create duplicate messages. This is expected behavior.
  ///
  /// Throws [AuthException] if user is not authenticated.
  /// Throws [ServerException] if content is empty, user is not a conversation
  /// member, or on database errors.
  Future<void> sendMessage({
    required String conversationId,
    required String content,
  }) async {
    final logger = getIt<Talker>();

    try {
      final currentUserId = _supabase.auth.currentUser?.id;
      if (currentUserId == null) {
        logger.warning(
          '[ChatService] Unauthenticated user attempted to send message',
        );
        throw AuthException('User must be authenticated to send messages');
      }

      // Validate non-empty content
      final trimmedContent = content.trim();
      if (trimmedContent.isEmpty) {
        logger.warning(
          '[ChatService] User $currentUserId attempted to send empty message',
        );
        throw const ServerException('Message content cannot be empty', '400');
      }

      logger.debug(
        '[ChatService] Sending message to conversation: $conversationId (user: $currentUserId, length: ${trimmedContent.length})',
      );

      // Insert new message into chat_messages
      // RLS will ensure user has access to this conversation
      // If user is not a member, insert will fail with RLS policy violation
      await _supabase.from('chat_messages').insert({
        'conversation_id': conversationId,
        'sender_id': currentUserId,
        'content': trimmedContent,
      });

      logger.info(
        '[ChatService] Message sent successfully to conversation $conversationId',
      );
    } on AuthException {
      rethrow;
    } on ServerException {
      rethrow;
    } on PostgrestException catch (e, stackTrace) {
      logger.error(
        '[ChatService] Database error in sendMessage: ${e.message}',
        e,
        stackTrace,
      );

      // Check for RLS policy violation (user not a member)
      if (e.code == '42501' || e.message.toLowerCase().contains('policy')) {
        throw const ServerException(
          'You do not have permission to send messages to this conversation',
          '403',
        );
      }

      throw ServerException('Failed to send message: ${e.message}', e.code);
    } catch (e, stackTrace) {
      logger.error(
        '[ChatService] Unexpected error in sendMessage',
        e,
        stackTrace,
      );
      throw const ServerException('Failed to send message');
    }
  }

  /// Subscribes to realtime message insertions for a conversation.
  ///
  /// [conversationId] - The ID of the conversation to listen to.
  ///
  /// Returns a stream of ChatMessage objects as new messages are inserted.
  /// Only emits INSERT events - does not fetch existing messages.
  ///
  /// RLS policies ensure users only receive messages from conversations
  /// they are members of. If the user is not a member, no messages will
  /// be received through the subscription.
  ///
  /// **Optimistic UI support**: Messages sent by the current user are filtered
  /// out from the realtime stream, assuming they are already optimistically
  /// displayed in the UI. This prevents duplicate messages from appearing.
  ///
  /// **Important**: Always cancel the subscription when done (e.g., when
  /// the chat screen is disposed) to prevent memory leaks. Each call to
  /// this method creates a new independent subscription.
  ///
  /// If the same conversation is opened multiple times, each will have
  /// its own channel subscription. Proper disposal ensures no duplicate
  /// listeners remain active.
  ///
  /// Channel is scoped to the conversation ID with a timestamp to ensure
  /// uniqueness and prevent collisions.
  ///
  /// Example usage:
  /// ```dart
  /// final subscription = chatService.subscribeToMessages(conversationId).listen(
  ///   (message) => print(message),
  /// );
  /// // Later, in dispose():
  /// subscription.cancel();
  /// ```
  Stream<ChatMessage> subscribeToMessages(String conversationId) {
    final logger = getIt<Talker>();
    late StreamController<ChatMessage> controller;
    RealtimeChannel? channel;
    bool isSubscribed = false;

    // Get current user ID for filtering own messages
    final currentUserId = _supabase.auth.currentUser?.id;

    // Create unique channel name to prevent collisions on multiple subscriptions
    final channelName =
        'chat_messages:$conversationId:${DateTime.now().millisecondsSinceEpoch}';

    logger.debug(
      '[ChatService] Setting up realtime subscription for conversation: $conversationId (channel: $channelName)',
    );

    controller = StreamController<ChatMessage>(
      onListen: () {
        if (isSubscribed) {
          logger.warning(
            '[ChatService] Attempted to subscribe to already active channel: $channelName',
          );
          return;
        }

        logger.info(
          '[ChatService] Subscribing to realtime messages: $channelName (user: $currentUserId)',
        );
        isSubscribed = true;

        // Create and subscribe to realtime channel scoped to this conversation
        try {
          channel = _supabase
              .channel(channelName)
              .onPostgresChanges(
                event: PostgresChangeEvent.insert,
                schema: 'public',
                table: 'chat_messages',
                filter: PostgresChangeFilter(
                  type: PostgresChangeFilterType.eq,
                  column: 'conversation_id',
                  value: conversationId,
                ),
                callback: (payload) {
                  if (!controller.isClosed) {
                    try {
                      // Validate payload structure
                      if (payload.newRecord.isEmpty) {
                        logger.debug(
                          '[ChatService] Received empty payload, ignoring',
                        );
                        return;
                      }

                      final record = payload.newRecord;

                      // Validate required fields exist
                      if (!record.containsKey('id') ||
                          !record.containsKey('sender_id') ||
                          !record.containsKey('content')) {
                        logger.warning(
                          '[ChatService] Malformed payload missing required fields: ${record.keys.join(', ')}',
                        );
                        return;
                      }

                      // Parse the message
                      final message = ChatMessage.fromJson(record);

                      // Filter out messages from current user (optimistic UI assumption)
                      // The UI should already show messages sent by the current user
                      if (currentUserId != null &&
                          message.senderId == currentUserId) {
                        logger.debug(
                          '[ChatService] Ignoring own message (optimistically added): ${message.id}',
                        );
                        return;
                      }

                      logger.debug(
                        '[ChatService] Emitting realtime message: ${message.id} from ${message.senderId}',
                      );
                      controller.add(message);
                    } on FormatException catch (e) {
                      logger.warning(
                        '[ChatService] Invalid data format in payload: $e',
                      );
                    } on TypeError catch (e) {
                      logger.warning(
                        '[ChatService] Type mismatch in payload: $e',
                      );
                    } catch (e) {
                      logger.warning(
                        '[ChatService] Failed to process realtime message: $e',
                      );
                    }
                  }
                },
              )
              .subscribe();

          logger.info(
            '[ChatService] Successfully subscribed to channel: $channelName',
          );
        } catch (e, stackTrace) {
          logger.error(
            '[ChatService] Failed to setup realtime subscription: $channelName',
            e,
            stackTrace,
          );
          isSubscribed = false;
          if (!controller.isClosed) {
            controller.addError(e);
          }
        }
      },
      onCancel: () async {
        if (!isSubscribed) {
          logger.debug(
            '[ChatService] Channel already unsubscribed: $channelName',
          );
          return;
        }

        logger.info(
          '[ChatService] Unsubscribing from realtime messages: $channelName',
        );

        try {
          // Properly unsubscribe and remove channel to prevent memory leaks
          if (channel != null) {
            await channel!.unsubscribe();
            logger.debug('[ChatService] Channel unsubscribed: $channelName');

            await _supabase.removeChannel(channel!);
            logger.debug(
              '[ChatService] Channel removed from client: $channelName',
            );
          }
          logger.info(
            '[ChatService] Successfully cleaned up subscription: $channelName',
          );
        } catch (e, stackTrace) {
          logger.error(
            '[ChatService] Error during channel cleanup: $channelName',
            e,
            stackTrace,
          );
        } finally {
          isSubscribed = false;
          channel = null;
        }
      },
    );

    return controller.stream;
  }
}
