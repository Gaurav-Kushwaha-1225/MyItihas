import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myitihas/features/social/domain/entities/user.dart';

part 'text_post.freezed.dart';

@freezed
abstract class TextPost with _$TextPost {
  const factory TextPost({
    required String id,
    required String body,
    String? imageUrl,
    @Default(0xFF1E3A5F) int backgroundColor,
    @Default(0xFFFFFFFF) int textColor,
    @Default(18.0) double fontSize,
    String? fontFamily,
    DateTime? createdAt,
    String? authorId,
    User? authorUser,
    @Default(0) int likes,
    @Default(0) int commentCount,
    @Default(0) int shareCount,
    @Default(false) bool isLikedByCurrentUser,
    @Default(false) bool isFavorite,
    @Default([]) List<String> tags,
  }) = _TextPost;

  const TextPost._();
}
