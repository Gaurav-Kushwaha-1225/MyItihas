/// Model representing a conversation (chat or group).
///
/// Maps to the conversations table in the database.
class Conversation {
  final String id;
  final bool isGroup;
  final String title;
  final String? avatarUrl;
  final String? lastMessage;
  final DateTime? lastMessageAt;

  Conversation({
    required this.id,
    required this.isGroup,
    required this.title,
    this.avatarUrl,
    this.lastMessage,
    this.lastMessageAt,
  });

  /// Creates a Conversation from a database row.
  ///
  /// Expected JSON structure from Supabase:
  /// ```json
  /// {
  ///   "id": "uuid",
  ///   "is_group": false,
  ///   "title": "User Name" or "Group Name",
  ///   "avatar_url": "https://...",
  ///   "last_message": "Message content",
  ///   "last_message_at": "2025-12-24T10:30:00Z"
  /// }
  /// ```
  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'] as String,
      isGroup: json['is_group'] as bool,
      title: json['title'] as String,
      avatarUrl: json['avatar_url'] as String?,
      lastMessage: json['last_message'] as String?,
      lastMessageAt: json['last_message_at'] != null
          ? DateTime.parse(json['last_message_at'] as String)
          : null,
    );
  }

  /// Converts the Conversation to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'is_group': isGroup,
      'title': title,
      'avatar_url': avatarUrl,
      'last_message': lastMessage,
      'last_message_at': lastMessageAt?.toIso8601String(),
    };
  }
}
