import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/services/post_service.dart';

import 'create_post_event.dart';
import 'create_post_state.dart';

@injectable
class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final PostService _postService;

  CreatePostBloc(this._postService) : super(const CreatePostState()) {
    on<InitializeCreatePostEvent>(_onInitialize);
    on<SelectPostTypeEvent>(_onSelectType);
    on<UpdateContentEvent>(_onUpdateContent);
    on<UpdateTitleEvent>(_onUpdateTitle);
    on<AddMediaEvent>(_onAddMedia);
    on<RemoveMediaEvent>(_onRemoveMedia);
    on<ChangeVisibilityEvent>(_onChangeVisibility);
    on<SubmitPostEvent>(_onSubmit);
    on<ResetCreatePostEvent>(_onReset);
  }

  void _onInitialize(
    InitializeCreatePostEvent event,
    Emitter<CreatePostState> emit,
  ) {
    emit(const CreatePostState());
  }

  void _onSelectType(
    SelectPostTypeEvent event,
    Emitter<CreatePostState> emit,
  ) {
    emit(state.copyWith(
      postType: event.type,
      mediaFiles: [],
      errorMessage: null,
    ));
  }

  void _onUpdateContent(
    UpdateContentEvent event,
    Emitter<CreatePostState> emit,
  ) {
    emit(state.copyWith(
      content: event.content,
      errorMessage: null,
    ));
  }

  void _onUpdateTitle(
    UpdateTitleEvent event,
    Emitter<CreatePostState> emit,
  ) {
    emit(state.copyWith(
      title: event.title,
      errorMessage: null,
    ));
  }

  void _onAddMedia(
    AddMediaEvent event,
    Emitter<CreatePostState> emit,
  ) {
    final newFiles = [...state.mediaFiles, ...event.files];

    final maxFiles = state.postType == PostType.video ? 1 : 10;

    emit(state.copyWith(
      mediaFiles: newFiles.take(maxFiles).toList(),
      errorMessage: null,
    ));
  }

  void _onRemoveMedia(
    RemoveMediaEvent event,
    Emitter<CreatePostState> emit,
  ) {
    if (event.index >= 0 && event.index < state.mediaFiles.length) {
      final newFiles = [...state.mediaFiles]..removeAt(event.index);
      emit(state.copyWith(
        mediaFiles: newFiles,
        errorMessage: null,
      ));
    }
  }

  void _onChangeVisibility(
    ChangeVisibilityEvent event,
    Emitter<CreatePostState> emit,
  ) {
    emit(state.copyWith(visibility: event.visibility));
  }

  Future<void> _onSubmit(
    SubmitPostEvent event,
    Emitter<CreatePostState> emit,
  ) async {
    final logger = getIt<Talker>();

    if (!state.canSubmit) {
      emit(state.copyWith(
        errorMessage: state.validationMessage ?? 'Cannot submit post',
      ));
      return;
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      logger.info('[CreatePostBloc] Submitting ${state.postType.name} post');

      final result = await _postService.createPost(
        postType: state.postType,
        content: state.content.isNotEmpty ? state.content : null,
        title: state.title.isNotEmpty ? state.title : null,
        mediaFiles: state.mediaFiles.isNotEmpty ? state.mediaFiles : null,
        visibility: state.visibility,
      );

      final postId = result['id'] as String;
      logger.info('[CreatePostBloc] Post created successfully: $postId');

      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: true,
        createdPostId: postId,
      ));
    } catch (e, stackTrace) {
      logger.error('[CreatePostBloc] Failed to create post', e, stackTrace);

      emit(state.copyWith(
        isSubmitting: false,
        errorMessage: 'Failed to create post: ${e.toString()}',
      ));
    }
  }

  void _onReset(
    ResetCreatePostEvent event,
    Emitter<CreatePostState> emit,
  ) {
    emit(const CreatePostState());
  }
}
