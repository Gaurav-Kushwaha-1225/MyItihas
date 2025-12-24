import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myitihas/features/social/domain/entities/user.dart';

part 'video_post.freezed.dart';

@freezed
abstract class VideoPost with _$VideoPost {
  const factory VideoPost({
    required String id,
    required String videoUrl,
    String? thumbnailUrl,
    String? caption,
    String? location,
    @Default(9 / 16) double aspectRatio,
    @Default(0) int durationSeconds,
    DateTime? createdAt,
    String? authorId,
    User? authorUser,
    @Default(0) int likes,
    @Default(0) int commentCount,
    @Default(0) int shareCount,
    @Default(0) int viewCount,
    @Default(false) bool isLikedByCurrentUser,
    @Default(false) bool isFavorite,
    @Default([]) List<String> tags,
  }) = _VideoPost;

  const VideoPost._();
}
