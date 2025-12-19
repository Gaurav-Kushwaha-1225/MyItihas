import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

part 'share.freezed.dart';
part 'share.g.dart';

@HiveType(typeId: 17)
enum ShareType {
  @HiveField(0)
  directMessage,
  @HiveField(1)
  external,
}

@freezed
abstract class Share with _$Share {
  const factory Share({
    required String userId,
    required String storyId,
    required ShareType shareType,
    String? recipientId, // For DM shares
    required DateTime timestamp,
  }) = _Share;

  const Share._();
}
