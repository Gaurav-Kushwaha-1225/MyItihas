import 'package:flutter/material.dart';
import 'package:myitihas/features/social/domain/entities/content_type.dart';
import 'package:myitihas/features/social/domain/entities/feed_item.dart';
import 'package:myitihas/features/social/presentation/widgets/enhanced_story_card.dart';
import 'package:myitihas/features/social/presentation/widgets/image_post_card.dart';
import 'package:myitihas/features/social/presentation/widgets/text_post_card.dart';

class FeedItemCard extends StatelessWidget {
  final FeedItem feedItem;
  final bool isVisible;
  final void Function(String contentId, ContentType contentType)? onLike;
  final void Function(String contentId, ContentType contentType)? onComment;
  final void Function(String contentId, ContentType contentType)? onShare;
  final void Function(String contentId, ContentType contentType)? onBookmark;
  final VoidCallback? onProfileTap;
  final VoidCallback? onFollowTap;
  final VoidCallback? onContinueReading;
  final bool isFollowLoading;

  const FeedItemCard({
    super.key,
    required this.feedItem,
    this.isVisible = true,
    this.onLike,
    this.onComment,
    this.onShare,
    this.onBookmark,
    this.onProfileTap,
    this.onFollowTap,
    this.onContinueReading,
    this.isFollowLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return feedItem.when(
      story: (story) => EnhancedStoryCard(
        story: story,
        isVisible: isVisible,
        onLike: onLike != null
            ? () => onLike!(story.id, ContentType.story)
            : null,
        onComment: onComment != null
            ? () => onComment!(story.id, ContentType.story)
            : null,
        onShare: onShare != null
            ? () => onShare!(story.id, ContentType.story)
            : null,
        onBookmark: onBookmark != null
            ? () => onBookmark!(story.id, ContentType.story)
            : null,
        onProfileTap: onProfileTap,
        onFollowTap: onFollowTap,
        onContinueReading: onContinueReading,
        isFollowLoading: isFollowLoading,
      ),
      imagePost: (post) => ImagePostCard(
        post: post,
        isVisible: isVisible,
        onLike: onLike != null
            ? () => onLike!(post.id, ContentType.imagePost)
            : null,
        onComment: onComment != null
            ? () => onComment!(post.id, ContentType.imagePost)
            : null,
        onShare: onShare != null
            ? () => onShare!(post.id, ContentType.imagePost)
            : null,
        onBookmark: onBookmark != null
            ? () => onBookmark!(post.id, ContentType.imagePost)
            : null,
        onProfileTap: onProfileTap,
        onFollowTap: onFollowTap,
        isFollowLoading: isFollowLoading,
      ),
      textPost: (post) => TextPostCard(
        post: post,
        isVisible: isVisible,
        onLike: onLike != null
            ? () => onLike!(post.id, ContentType.textPost)
            : null,
        onComment: onComment != null
            ? () => onComment!(post.id, ContentType.textPost)
            : null,
        onShare: onShare != null
            ? () => onShare!(post.id, ContentType.textPost)
            : null,
        onBookmark: onBookmark != null
            ? () => onBookmark!(post.id, ContentType.textPost)
            : null,
        onProfileTap: onProfileTap,
        onFollowTap: onFollowTap,
        isFollowLoading: isFollowLoading,
      ),
    );
  }
}
