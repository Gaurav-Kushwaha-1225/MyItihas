/// Model representing a conversation (chat or group).
///
/// Maps to the conversations table in the database.
class Conversation {
  final String id;
  final bool isGroup;
  final String title;
  final String? avatarUrl;

  Conversation({
    required this.id,
    required this.isGroup,
    required this.title,
    this.avatarUrl,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'] as String,
      isGroup: json['is_group'] as bool,
      title: json['title'] as String,
      avatarUrl: json['avatar_url'] as String?,
    );
  }

  /// Converts the Conversation to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'is_group': isGroup,
      'title': title,
      'avatar_url': avatarUrl,
    };
  }
}
