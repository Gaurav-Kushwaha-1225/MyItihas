import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/features/social/domain/entities/user.dart';

part 'feed_state.freezed.dart';

@Freezed(toStringOverride: true)
sealed class FeedState with _$FeedState {
  const factory FeedState.initial() = FeedInitial;

  const factory FeedState.loading() = FeedLoading;

  const factory FeedState.loaded({
    required List<Story> stories,
    required User currentUser,
    required bool hasMore,
    @Default(false) bool isLoadingMore,
  }) = FeedLoaded;

  const factory FeedState.refreshing({
    required List<Story> stories,
    required User currentUser,
    required bool hasMore,
  }) = FeedRefreshing;

  const factory FeedState.error(String message) = FeedError;

  const FeedState._();

  @override
  String toString() {
    return map(
      initial: (_) => 'FeedState.initial()',
      loading: (_) => 'FeedState.loading()',
      loaded: (state) =>
          'FeedState.loaded(stories: ${state.stories.length}, hasMore: ${state.hasMore})',
      refreshing: (state) =>
          'FeedState.refreshing(stories: ${state.stories.length})',
      error: (state) => 'FeedState.error(message: "${state.message}")',
    );
  }
}
