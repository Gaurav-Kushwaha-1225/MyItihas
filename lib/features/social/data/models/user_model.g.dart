// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final typeId = 10;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as String,
      username: fields[1] as String,
      displayName: fields[2] as String,
      avatarUrl: fields[3] as String,
      bio: fields[4] as String,
      followerCount: fields[5] == null ? 0 : (fields[5] as num).toInt(),
      followingCount: fields[6] == null ? 0 : (fields[6] as num).toInt(),
      isFollowing: fields[7] == null ? false : fields[7] as bool,
      isCurrentUser: fields[8] == null ? false : fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.displayName)
      ..writeByte(3)
      ..write(obj.avatarUrl)
      ..writeByte(4)
      ..write(obj.bio)
      ..writeByte(5)
      ..write(obj.followerCount)
      ..writeByte(6)
      ..write(obj.followingCount)
      ..writeByte(7)
      ..write(obj.isFollowing)
      ..writeByte(8)
      ..write(obj.isCurrentUser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  username: json['username'] as String,
  displayName: json['displayName'] as String,
  avatarUrl: json['avatarUrl'] as String,
  bio: json['bio'] as String,
  followerCount: (json['followerCount'] as num?)?.toInt() ?? 0,
  followingCount: (json['followingCount'] as num?)?.toInt() ?? 0,
  isFollowing: json['isFollowing'] as bool? ?? false,
  isCurrentUser: json['isCurrentUser'] as bool? ?? false,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'bio': instance.bio,
      'followerCount': instance.followerCount,
      'followingCount': instance.followingCount,
      'isFollowing': instance.isFollowing,
      'isCurrentUser': instance.isCurrentUser,
    };
