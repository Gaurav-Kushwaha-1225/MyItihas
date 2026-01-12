import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myitihas/services/post_service.dart';

part 'create_post_state.freezed.dart';

@freezed
abstract class CreatePostState with _$CreatePostState {
  const CreatePostState._();

  const factory CreatePostState({
    @Default(PostType.text) PostType postType,

    @Default('') String content,

    @Default('') String title,

    @Default([]) List<File> mediaFiles,

    @Default(PostVisibility.public) PostVisibility visibility,

    @Default(false) bool isSubmitting,

    String? errorMessage,

    @Default(false) bool isSuccess,

    String? createdPostId,
  }) = _CreatePostState;

  bool get hasContent =>
      content.isNotEmpty || title.isNotEmpty || mediaFiles.isNotEmpty;

  bool get canSubmit {
    if (isSubmitting) return false;

    switch (postType) {
      case PostType.text:
        return content.isNotEmpty;
      case PostType.image:
        return mediaFiles.isNotEmpty;
      case PostType.video:
        return mediaFiles.isNotEmpty;
      case PostType.storyShare:
        return content.isNotEmpty;
    }
  }

  String? get validationMessage {
    switch (postType) {
      case PostType.text:
        if (content.isEmpty) return 'Please enter some text';
        return null;
      case PostType.image:
        if (mediaFiles.isEmpty) return 'Please select at least one image';
        return null;
      case PostType.video:
        if (mediaFiles.isEmpty) return 'Please select a video';
        return null;
      case PostType.storyShare:
        return null;
    }
  }
}
