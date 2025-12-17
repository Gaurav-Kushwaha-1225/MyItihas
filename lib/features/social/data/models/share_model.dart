import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'package:myitihas/features/social/domain/entities/share.dart';

part 'share_model.freezed.dart';
part 'share_model.g.dart';

@freezed
@HiveType(typeId: 15)
abstract class ShareModel with _$ShareModel {
  const ShareModel._();

  const factory ShareModel({
    @HiveField(0) required String userId,
    @HiveField(1) required String storyId,
    @HiveField(2) required ShareType shareType,
    @HiveField(3) String? recipientId,
    @HiveField(4) required DateTime timestamp,
  }) = _ShareModel;

  factory ShareModel.fromJson(Map<String, dynamic> json) =>
      _$ShareModelFromJson(json);

  Share toEntity() {
    return Share(
      userId: userId,
      storyId: storyId,
      shareType: shareType,
      recipientId: recipientId,
      timestamp: timestamp,
    );
  }

  factory ShareModel.fromEntity(Share share) {
    return ShareModel(
      userId: share.userId,
      storyId: share.storyId,
      shareType: share.shareType,
      recipientId: share.recipientId,
      timestamp: share.timestamp,
    );
  }
}
