import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;
import 'package:talker_flutter/talker_flutter.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/core/errors/exceptions.dart';

/// Represents the type of content that can be liked/commented/bookmarked
enum ContentType { post, comment, story }

/// Represents how content was shared
enum ShareType { repost, directMessage, external }

/// Service for social interactions: likes, comments, bookmarks, shares.
///
/// Provides a unified interface for all social actions across posts,
/// stories, and comments. All operations use auth.uid() for authorization.
@lazySingleton
class SocialService {
  final SupabaseClient _supabase;

  SocialService(this._supabase);

  // ==================== LIKES ====================

  /// Likes a piece of content (post, comment, or story).
  ///
  /// Upserts to handle duplicate likes gracefully.
  Future<void> likeContent({
    required ContentType contentType,
    required String contentId,
  }) async {
    final logger = getIt<Talker>();

    try {
      final currentUserId = _supabase.auth.currentUser?.id;
      if (currentUserId == null) {
        throw AuthException('User must be authenticated to like content');
      }

      await _supabase.from('likes').upsert(
        {
          'user_id': currentUserId,
          'likeable_type': _contentTypeToDbEnum(contentType),
          'likeable_id': contentId,
        },
        onConflict: 'user_id,likeable_type,likeable_id',
      );

      logger.info(
        '[SocialService] User $currentUserId liked ${contentType.name} $contentId',
      );
    } on AuthException {
      rethrow;
    } catch (e, stackTrace) {
      logger.error('[SocialService] Error liking content', e, stackTrace);
      throw ServerException('Failed to like content: ${e.toString()}');
    }
  }

  /// Unlikes a piece of content.
  Future<void> unlikeContent({
    required ContentType contentType,
    required String contentId,
  }) async {
    final logger = getIt<Talker>();

    try {
      final currentUserId = _supabase.auth.currentUser?.id;
      if (currentUserId == null) {
        throw AuthException('User must be authenticated to unlike content');
      }

      await _supabase
          .from('likes')
          .delete()
          .eq('user_id', currentUserId)
          .eq('likeable_type', _contentTypeToDbEnum(contentType))
          .eq('likeable_id', contentId);

      logger.info(
        '[SocialService] User $currentUserId unliked ${contentType.name} $contentId',
      );
    } on AuthException {
      rethrow;
    } catch (e, stackTrace) {
      logger.error('[SocialService] Error unliking content', e, stackTrace);
      throw ServerException('Failed to unlike content: ${e.toString()}');
    }
  }

  /// Checks if the current user has liked a piece of content.
  Future<bool> isLiked({
    required ContentType contentType,
    required String contentId,
  }) async {
    final logger = getIt<Talker>();

    try {
      final currentUserId = _supabase.auth.currentUser?.id;
      if (currentUserId == null) {
        return false;
      }

      final response = await _supabase
          .from('likes')
          .select('id')
          .eq('user_id', currentUserId)
          .eq('likeable_type', _contentTypeToDbEnum(contentType))
          .eq('likeable_id', contentId)
          .maybeSingle();

      return response != null;
    } catch (e, stackTrace) {
      logger.error('[SocialService] Error checking like status', e, stackTrace);
      return false;
    }
  }

  /// Gets the like count for a piece of content.
  Future<int> getLikeCount({
    required ContentType contentType,
    required String contentId,
  }) async {
    try {
      final response = await _supabase
          .from('likes')
          .select()
          .eq('likeable_type', _contentTypeToDbEnum(contentType))
          .eq('likeable_id', contentId)
          .count(CountOption.exact);

      return response.count;
    } catch (e) {
      return 0;
    }
  }

  // ==================== COMMENTS ====================

  /// Adds a comment to a post or story.
  ///
  /// [contentType] - Whether commenting on a post or story
  /// [contentId] - ID of the post or story
  /// [text] - Comment text
  /// [parentCommentId] - Optional parent for nested replies (max 3 levels)
  ///
  /// Returns the created comment data with author info.
  Future<Map<String, dynamic>> addComment({
    required ContentType contentType,
    required String contentId,
    required String text,
    String? parentCommentId,
  }) async {
    final logger = getIt<Talker>();

    try {
      final currentUserId = _supabase.auth.currentUser?.id;
      if (currentUserId == null) {
        throw AuthException('User must be authenticated to comment');
      }

      if (text.trim().isEmpty) {
        throw const ServerException('Comment cannot be empty', '400');
      }

      // Calculate depth and root comment
      int depth = 0;
      String? rootCommentId;

      if (parentCommentId != null) {
        final parent = await _supabase
            .from('comments')
            .select('depth, root_comment_id')
            .eq('id', parentCommentId)
            .single();

        depth = (parent['depth'] as int) + 1;
        if (depth > 3) {
          throw const ServerException(
            'Maximum comment nesting depth (3) exceeded',
            '400',
          );
        }

        // Root is either parent's root or parent itself (if top-level reply)
        rootCommentId = parent['root_comment_id'] as String? ?? parentCommentId;
      }

      final commentData = {
        'author_id': currentUserId,
        'commentable_type': contentType == ContentType.post ? 'post' : 'story',
        'commentable_id': contentId,
        'content': text.trim(),
        'parent_comment_id': parentCommentId,
        'depth': depth,
        'root_comment_id': rootCommentId,
      };

      final response = await _supabase
          .from('comments')
          .insert(commentData)
          .select('''
            *,
            author:profiles!comments_author_id_fkey(id, username, full_name, avatar_url)
          ''')
          .single();

      logger.info(
        '[SocialService] Comment created on ${contentType.name} $contentId',
      );
      return response;
    } on AuthException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (e, stackTrace) {
      logger.error('[SocialService] Error adding comment', e, stackTrace);
      throw ServerException('Failed to add comment: ${e.toString()}');
    }
  }

  /// Deletes a comment.
  ///
  /// Only the author can delete their comments (enforced by RLS).
  Future<void> deleteComment(String commentId) async {
    final logger = getIt<Talker>();

    try {
      await _supabase.from('comments').delete().eq('id', commentId);
      logger.info('[SocialService] Deleted comment $commentId');
    } catch (e, stackTrace) {
      logger.error('[SocialService] Error deleting comment', e, stackTrace);
      throw ServerException('Failed to delete comment: ${e.toString()}');
    }
  }

  /// Gets comments for a piece of content with threading.
  ///
  /// Returns top-level comments with nested replies loaded.
  Future<List<Map<String, dynamic>>> getComments({
    required ContentType contentType,
    required String contentId,
    int limit = 20,
    int offset = 0,
  }) async {
    final logger = getIt<Talker>();

    try {
      final currentUserId = _supabase.auth.currentUser?.id;

      // Get top-level comments
      final topLevelComments = await _supabase
          .from('comments')
          .select('''
            *,
            author:profiles!comments_author_id_fkey(id, username, full_name, avatar_url)
          ''')
          .eq(
            'commentable_type',
            contentType == ContentType.post ? 'post' : 'story',
          )
          .eq('commentable_id', contentId)
          .isFilter('parent_comment_id', null)
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);

      // For each top-level comment, get replies
      final commentsWithReplies = <Map<String, dynamic>>[];

      for (final comment in topLevelComments) {
        final commentMap = Map<String, dynamic>.from(comment);

        // Check if current user liked this comment
        if (currentUserId != null) {
          commentMap['is_liked_by_current_user'] = await isLiked(
            contentType: ContentType.comment,
            contentId: comment['id'],
          );
        }

        // Get replies if any
        if ((comment['reply_count'] as int? ?? 0) > 0) {
          final replies = await _supabase
              .from('comments')
              .select('''
                *,
                author:profiles!comments_author_id_fkey(id, username, full_name, avatar_url)
              ''')
              .eq('root_comment_id', comment['id'])
              .order('created_at', ascending: true);

          commentMap['replies'] = replies;
        } else {
          commentMap['replies'] = [];
        }

        commentsWithReplies.add(commentMap);
      }

      logger.debug(
        '[SocialService] Fetched ${commentsWithReplies.length} comments for ${contentType.name} $contentId',
      );
      return commentsWithReplies;
    } catch (e, stackTrace) {
      logger.error('[SocialService] Error fetching comments', e, stackTrace);
      throw ServerException('Failed to fetch comments: ${e.toString()}');
    }
  }

  // ==================== BOOKMARKS ====================

  /// Bookmarks a piece of content.
  ///
  /// [collection] - Optional collection name for organization
  Future<void> bookmarkContent({
    required ContentType contentType,
    required String contentId,
    String? collection,
  }) async {
    final logger = getIt<Talker>();

    try {
      final currentUserId = _supabase.auth.currentUser?.id;
      if (currentUserId == null) {
        throw AuthException('User must be authenticated to bookmark');
      }

      await _supabase.from('bookmarks').upsert(
        {
          'user_id': currentUserId,
          'bookmarkable_type':
              contentType == ContentType.post ? 'post' : 'story',
          'bookmarkable_id': contentId,
          'collection_name': collection,
        },
        onConflict: 'user_id,bookmarkable_type,bookmarkable_id',
      );

      logger.info(
        '[SocialService] User $currentUserId bookmarked ${contentType.name} $contentId',
      );
    } on AuthException {
      rethrow;
    } catch (e, stackTrace) {
      logger.error('[SocialService] Error bookmarking content', e, stackTrace);
      throw ServerException('Failed to bookmark: ${e.toString()}');
    }
  }

  /// Removes a bookmark.
  Future<void> removeBookmark({
    required ContentType contentType,
    required String contentId,
  }) async {
    final logger = getIt<Talker>();

    try {
      final currentUserId = _supabase.auth.currentUser?.id;
      if (currentUserId == null) {
        throw AuthException('User must be authenticated');
      }

      await _supabase
          .from('bookmarks')
          .delete()
          .eq('user_id', currentUserId)
          .eq(
            'bookmarkable_type',
            contentType == ContentType.post ? 'post' : 'story',
          )
          .eq('bookmarkable_id', contentId);

      logger.info(
        '[SocialService] User $currentUserId removed bookmark from ${contentType.name} $contentId',
      );
    } on AuthException {
      rethrow;
    } catch (e, stackTrace) {
      logger.error('[SocialService] Error removing bookmark', e, stackTrace);
      throw ServerException('Failed to remove bookmark: ${e.toString()}');
    }
  }

  /// Checks if content is bookmarked by current user.
  Future<bool> isBookmarked({
    required ContentType contentType,
    required String contentId,
  }) async {
    try {
      final currentUserId = _supabase.auth.currentUser?.id;
      if (currentUserId == null) {
        return false;
      }

      final response = await _supabase
          .from('bookmarks')
          .select('id')
          .eq('user_id', currentUserId)
          .eq(
            'bookmarkable_type',
            contentType == ContentType.post ? 'post' : 'story',
          )
          .eq('bookmarkable_id', contentId)
          .maybeSingle();

      return response != null;
    } catch (e) {
      return false;
    }
  }

  /// Gets all bookmarked content for the current user.
  Future<List<Map<String, dynamic>>> getBookmarks({
    int limit = 20,
    int offset = 0,
    String? collection,
  }) async {
    final logger = getIt<Talker>();

    try {
      final currentUserId = _supabase.auth.currentUser?.id;
      if (currentUserId == null) {
        return [];
      }

      // Build base query with filters first, then transformations
      var query = _supabase
          .from('bookmarks')
          .select()
          .eq('user_id', currentUserId);

      if (collection != null) {
        query = query.eq('collection_name', collection);
      }

      final bookmarks = await query
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);

      // Fetch the actual bookmarked content
      final results = <Map<String, dynamic>>[];

      for (final bookmark in bookmarks) {
        final type = bookmark['bookmarkable_type'] as String;
        final id = bookmark['bookmarkable_id'] as String;

        Map<String, dynamic>? content;
        if (type == 'post') {
          content = await _supabase
              .from('posts')
              .select('''
                *,
                author:profiles!posts_author_id_fkey(id, username, full_name, avatar_url)
              ''')
              .eq('id', id)
              .maybeSingle();
        } else if (type == 'story') {
          content = await _supabase
              .from('stories')
              .select()
              .eq('id', id)
              .maybeSingle();
        }

        if (content != null) {
          results.add({
            'bookmark': bookmark,
            'content': content,
            'content_type': type,
          });
        }
      }

      logger.debug('[SocialService] Fetched ${results.length} bookmarks');
      return results;
    } catch (e, stackTrace) {
      logger.error('[SocialService] Error fetching bookmarks', e, stackTrace);
      throw ServerException('Failed to fetch bookmarks: ${e.toString()}');
    }
  }

  // ==================== SHARES ====================

  /// Records a share action.
  ///
  /// [shareType] - How content was shared (repost, DM, external)
  /// [recipientId] - For DM shares, the recipient user ID
  Future<void> shareContent({
    required ContentType contentType,
    required String contentId,
    required ShareType shareType,
    String? recipientId,
  }) async {
    final logger = getIt<Talker>();

    try {
      final currentUserId = _supabase.auth.currentUser?.id;
      if (currentUserId == null) {
        throw AuthException('User must be authenticated to share');
      }

      await _supabase.from('shares').insert({
        'user_id': currentUserId,
        'shareable_type': contentType == ContentType.post ? 'post' : 'story',
        'shareable_id': contentId,
        'share_type': _shareTypeToDbEnum(shareType),
        'recipient_id': recipientId,
      });

      logger.info(
        '[SocialService] User $currentUserId shared ${contentType.name} $contentId via ${shareType.name}',
      );
    } on AuthException {
      rethrow;
    } catch (e, stackTrace) {
      logger.error('[SocialService] Error sharing content', e, stackTrace);
      throw ServerException('Failed to share: ${e.toString()}');
    }
  }

  /// Gets share count for content.
  Future<int> getShareCount({
    required ContentType contentType,
    required String contentId,
  }) async {
    try {
      final response = await _supabase
          .from('shares')
          .select()
          .eq(
            'shareable_type',
            contentType == ContentType.post ? 'post' : 'story',
          )
          .eq('shareable_id', contentId)
          .count(CountOption.exact);

      return response.count;
    } catch (e) {
      return 0;
    }
  }

  // ==================== HELPERS ====================

  String _contentTypeToDbEnum(ContentType type) {
    switch (type) {
      case ContentType.post:
        return 'post';
      case ContentType.comment:
        return 'comment';
      case ContentType.story:
        return 'story';
    }
  }

  String _shareTypeToDbEnum(ShareType type) {
    switch (type) {
      case ShareType.repost:
        return 'repost';
      case ShareType.directMessage:
        return 'direct_message';
      case ShareType.external:
        return 'external';
    }
  }
}
