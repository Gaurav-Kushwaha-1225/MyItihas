import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
@HiveType(typeId: 10)
abstract class UserModel with _$UserModel {
  const UserModel._();

  @override
  @HiveField(0)
  @JsonKey(name: 'id')
  String get id;

  @override
  @HiveField(1)
  @JsonKey(name: 'username')
  String get username;

  @override
  @HiveField(2)
  @JsonKey(name: 'displayName')
  String get displayName;

  @override
  @HiveField(3)
  @JsonKey(name: 'avatarUrl')
  String get avatarUrl;

  @override
  @HiveField(4)
  @JsonKey(name: 'bio')
  String get bio;

  @override
  @HiveField(5)
  @JsonKey(name: 'followerCount')
  int get followerCount;

  @override
  @HiveField(6)
  @JsonKey(name: 'followingCount')
  int get followingCount;

  @override
  @HiveField(7)
  @JsonKey(name: 'isFollowing')
  bool get isFollowing;

  @override
  @HiveField(8)
  @JsonKey(name: 'isCurrentUser')
  bool get isCurrentUser;

  const factory UserModel({
    required String id,
    required String username,
    required String displayName,
    required String avatarUrl,
    required String bio,
    @Default(0) int followerCount,
    @Default(0) int followingCount,
    @Default(false) bool isFollowing,
    @Default(false) bool isCurrentUser,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  User toEntity() {
    return User(
      id: id,
      username: username,
      displayName: displayName,
      avatarUrl: avatarUrl,
      bio: bio,
      followerCount: followerCount,
      followingCount: followingCount,
      isFollowing: isFollowing,
      isCurrentUser: isCurrentUser,
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      username: user.username,
      displayName: user.displayName,
      avatarUrl: user.avatarUrl,
      bio: user.bio,
      followerCount: user.followerCount,
      followingCount: user.followingCount,
      isFollowing: user.isFollowing,
      isCurrentUser: user.isCurrentUser,
    );
  }
}
