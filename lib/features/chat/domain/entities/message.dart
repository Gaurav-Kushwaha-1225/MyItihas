import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'package:myitihas/features/social/domain/entities/user.dart';

part 'message.freezed.dart';
part 'message.g.dart';

enum DeliveryStatus { sending, sent, delivered, read, failed }

@HiveType(typeId: 18)
enum MessageDeliveryStatus {
  @HiveField(0)
  sending,
  @HiveField(1)
  sent,
  @HiveField(2)
  delivered,
  @HiveField(3)
  read,
  @HiveField(4)
  failed,
}

@freezed
abstract class Message with _$Message {
  const factory Message({
    required String id,
    required String conversationId,
    required String senderId,
    required String senderName,
    required String senderAvatar,
    required String text,
    required DateTime timestamp,
    @Default(MessageDeliveryStatus.sending)
    MessageDeliveryStatus deliveryStatus,
    @Default([]) List<String> readBy,
    String? sharedStoryId,
  }) = _Message;

  const Message._();

  User get sender => User(
    id: senderId,
    username: senderName.toLowerCase().replaceAll(' ', '_'),
    displayName: senderName,
    avatarUrl: senderAvatar,
    bio: '',
    followerCount: 0,
    followingCount: 0,
    isFollowing: false,
    isCurrentUser: false,
  );

  DateTime get createdAt => timestamp;
}
