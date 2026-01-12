import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myitihas/services/post_service.dart';

part 'create_post_event.freezed.dart';

@freezed
sealed class CreatePostEvent with _$CreatePostEvent {
  const factory CreatePostEvent.initialize() = InitializeCreatePostEvent;

  const factory CreatePostEvent.selectType(PostType type) =
      SelectPostTypeEvent;

  const factory CreatePostEvent.updateContent(String content) =
      UpdateContentEvent;

  const factory CreatePostEvent.updateTitle(String title) = UpdateTitleEvent;

  const factory CreatePostEvent.addMedia(List<File> files) = AddMediaEvent;

  const factory CreatePostEvent.removeMedia(int index) = RemoveMediaEvent;
  const factory CreatePostEvent.changeVisibility(PostVisibility visibility) =
      ChangeVisibilityEvent;

  const factory CreatePostEvent.submit() = SubmitPostEvent;

  const factory CreatePostEvent.reset() = ResetCreatePostEvent;
}
