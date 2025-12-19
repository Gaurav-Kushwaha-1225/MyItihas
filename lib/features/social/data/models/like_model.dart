import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
import 'package:myitihas/features/social/domain/entities/like.dart';

part 'like_model.freezed.dart';
part 'like_model.g.dart';

@freezed
@HiveType(typeId: 14)
abstract class LikeModel with _$LikeModel {
  const LikeModel._();

  const factory LikeModel({
    @HiveField(0) required String userId,
    @HiveField(1) required String storyId,
    @HiveField(2) required DateTime timestamp,
  }) = _LikeModel;

  factory LikeModel.fromJson(Map<String, dynamic> json) =>
      _$LikeModelFromJson(json);

  Like toEntity() {
    return Like(userId: userId, storyId: storyId, timestamp: timestamp);
  }

  factory LikeModel.fromEntity(Like like) {
    return LikeModel(
      userId: like.userId,
      storyId: like.storyId,
      timestamp: like.timestamp,
    );
  }
}
