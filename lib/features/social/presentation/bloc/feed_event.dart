import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myitihas/features/social/domain/entities/content_type.dart';

part 'feed_event.freezed.dart';

/// Enum for filtering feed by content type
enum FeedType {
  all,
  stories,
  images,
  text;

  ContentType? get toContentType {
    switch (this) {
      case FeedType.all:
        return null;
      case FeedType.stories:
        return ContentType.story;
      case FeedType.images:
        return ContentType.imagePost;
      case FeedType.text:
        return ContentType.textPost;
    }
  }
}

@freezed
sealed class FeedEvent with _$FeedEvent {
  const factory FeedEvent.loadFeed() = LoadFeedEvent;
  const factory FeedEvent.loadMore() = LoadMoreFeedEvent;
  const factory FeedEvent.refreshFeed() = RefreshFeedEvent;
  const factory FeedEvent.changeFeedType(FeedType feedType) =
      ChangeFeedTypeEvent;
  const factory FeedEvent.toggleLike({
    required String contentId,
    required ContentType contentType,
  }) = ToggleLikeEvent;
  const factory FeedEvent.toggleBookmark({
    required String contentId,
    required ContentType contentType,
  }) = ToggleBookmarkEvent;
  const factory FeedEvent.addComment({
    required String contentId,
    required ContentType contentType,
    required String text,
    String? parentCommentId,
  }) = AddCommentEvent;
  const factory FeedEvent.shareContent({
    required String contentId,
    required ContentType contentType,
    required bool isDirect,
    String? recipientId,
  }) = ShareContentEvent;
}
