import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myitihas/features/social/domain/entities/content_type.dart';
import 'package:myitihas/features/social/domain/entities/image_post.dart';
import 'package:myitihas/features/social/domain/entities/text_post.dart';
import 'package:myitihas/features/social/domain/entities/user.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';

part 'feed_item.freezed.dart';

/// A sealed class representing any item that can appear in the social feed.
/// This provides a unified interface for stories, image posts, and text posts.
@freezed
sealed class FeedItem with _$FeedItem {
  const factory FeedItem.story(Story story) = StoryFeedItem;
  const factory FeedItem.imagePost(ImagePost imagePost) = ImagePostFeedItem;
  const factory FeedItem.textPost(TextPost textPost) = TextPostFeedItem;

  const FeedItem._();
}

/// Extension to provide common accessors for all feed item types
extension FeedItemExtension on FeedItem {
  String get id => when(
    story: (story) => story.id,
    imagePost: (post) => post.id,
    textPost: (post) => post.id,
  );

  ContentType get contentType => when(
    story: (_) => ContentType.story,
    imagePost: (_) => ContentType.imagePost,
    textPost: (_) => ContentType.textPost,
  );

  User? get authorUser => when(
    story: (story) => story.authorUser,
    imagePost: (post) => post.authorUser,
    textPost: (post) => post.authorUser,
  );

  String? get authorId => when(
    story: (story) => story.authorId,
    imagePost: (post) => post.authorId,
    textPost: (post) => post.authorId,
  );

  int get likes => when(
    story: (story) => story.likes,
    imagePost: (post) => post.likes,
    textPost: (post) => post.likes,
  );

  int get commentCount => when(
    story: (story) => story.commentCount,
    imagePost: (post) => post.commentCount,
    textPost: (post) => post.commentCount,
  );

  int get shareCount => when(
    story: (story) => story.shareCount,
    imagePost: (post) => post.shareCount,
    textPost: (post) => post.shareCount,
  );

  bool get isLikedByCurrentUser => when(
    story: (story) => story.isLikedByCurrentUser,
    imagePost: (post) => post.isLikedByCurrentUser,
    textPost: (post) => post.isLikedByCurrentUser,
  );

  bool get isFavorite => when(
    story: (story) => story.isFavorite,
    imagePost: (post) => post.isFavorite,
    textPost: (post) => post.isFavorite,
  );

  DateTime? get createdAt => when(
    story: (story) => story.publishedAt,
    imagePost: (post) => post.createdAt,
    textPost: (post) => post.createdAt,
  );

  /// Returns a new FeedItem with the like toggled
  FeedItem toggleLike() => when(
    story: (story) => FeedItem.story(
      story.copyWith(
        isLikedByCurrentUser: !story.isLikedByCurrentUser,
        likes: story.isLikedByCurrentUser ? story.likes - 1 : story.likes + 1,
      ),
    ),
    imagePost: (post) => FeedItem.imagePost(
      post.copyWith(
        isLikedByCurrentUser: !post.isLikedByCurrentUser,
        likes: post.isLikedByCurrentUser ? post.likes - 1 : post.likes + 1,
      ),
    ),
    textPost: (post) => FeedItem.textPost(
      post.copyWith(
        isLikedByCurrentUser: !post.isLikedByCurrentUser,
        likes: post.isLikedByCurrentUser ? post.likes - 1 : post.likes + 1,
      ),
    ),
  );

  /// Returns a new FeedItem with the bookmark toggled
  FeedItem toggleBookmark() => when(
    story: (story) =>
        FeedItem.story(story.copyWith(isFavorite: !story.isFavorite)),
    imagePost: (post) =>
        FeedItem.imagePost(post.copyWith(isFavorite: !post.isFavorite)),
    textPost: (post) =>
        FeedItem.textPost(post.copyWith(isFavorite: !post.isFavorite)),
  );

  /// Returns a new FeedItem with incremented share count
  FeedItem incrementShareCount() => when(
    story: (story) =>
        FeedItem.story(story.copyWith(shareCount: story.shareCount + 1)),
    imagePost: (post) =>
        FeedItem.imagePost(post.copyWith(shareCount: post.shareCount + 1)),
    textPost: (post) =>
        FeedItem.textPost(post.copyWith(shareCount: post.shareCount + 1)),
  );

  /// Returns a new FeedItem with incremented comment count
  FeedItem incrementCommentCount() => when(
    story: (story) =>
        FeedItem.story(story.copyWith(commentCount: story.commentCount + 1)),
    imagePost: (post) =>
        FeedItem.imagePost(post.copyWith(commentCount: post.commentCount + 1)),
    textPost: (post) =>
        FeedItem.textPost(post.copyWith(commentCount: post.commentCount + 1)),
  );
}
