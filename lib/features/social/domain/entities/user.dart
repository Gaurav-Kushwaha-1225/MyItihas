import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required String id,
    required String username,
    required String displayName,
    required String avatarUrl,
    required String bio,
    @Default(0) int followerCount,
    @Default(0) int followingCount,
    @Default(false) bool isFollowing,
    @Default(false) bool isCurrentUser,
  }) = _User;

  const User._();
}
