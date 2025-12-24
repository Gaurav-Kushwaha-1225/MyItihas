import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myitihas/features/social/domain/entities/user.dart';

part 'image_post.freezed.dart';

@freezed
abstract class ImagePost with _$ImagePost {
  const factory ImagePost({
    required String id,
    required String imageUrl,
    String? caption,
    String? location,
    @Default(1.0) double aspectRatio,
    DateTime? createdAt,
    String? authorId,
    User? authorUser,
    @Default(0) int likes,
    @Default(0) int commentCount,
    @Default(0) int shareCount,
    @Default(false) bool isLikedByCurrentUser,
    @Default(false) bool isFavorite,
    @Default([]) List<String> tags,
  }) = _ImagePost;

  const ImagePost._();
}
