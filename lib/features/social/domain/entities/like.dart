import 'package:freezed_annotation/freezed_annotation.dart';

part 'like.freezed.dart';

@freezed
abstract class Like with _$Like {
  const factory Like({
    required String userId,
    required String storyId,
    required DateTime timestamp,
  }) = _Like;

  const Like._();
}
