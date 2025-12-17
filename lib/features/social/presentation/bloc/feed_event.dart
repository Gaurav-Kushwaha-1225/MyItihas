import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_event.freezed.dart';

@freezed
sealed class FeedEvent with _$FeedEvent {
  const factory FeedEvent.loadFeed() = LoadFeedEvent;
  const factory FeedEvent.loadMore() = LoadMoreFeedEvent;
  const factory FeedEvent.refreshFeed() = RefreshFeedEvent;
  const factory FeedEvent.toggleLike(String storyId) = ToggleLikeEvent;
  const factory FeedEvent.toggleBookmark(String storyId) = ToggleBookmarkEvent;
  const factory FeedEvent.addComment({
    required String storyId,
    required String text,
    String? parentCommentId,
  }) = AddCommentEvent;
  const factory FeedEvent.shareStory({
    required String storyId,
    required bool isDirect,
    String? recipientId,
  }) = ShareStoryEvent;
}
