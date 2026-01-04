import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthException;
import 'package:talker_flutter/talker_flutter.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/core/errors/exceptions.dart';
import 'package:uuid/uuid.dart';

/// Represents the type of post content
enum PostType { text, image, video, storyShare }

/// Represents the visibility of a post
enum PostVisibility { public, followers, private }

/// Service for managing posts in the social feed.
///
/// Handles CRUD operations for posts, media uploads, and feed retrieval.
/// All operations use auth.uid() to ensure proper authorization.
@lazySingleton
class PostService {
  final SupabaseClient _supabase;

  PostService(this._supabase);

  /// Creates a new post with optional media.
  ///
  /// [postType] - Type of post (text, image, video, storyShare)
  /// [content] - Main text content/caption
  /// [title] - Optional title for the post
  /// [mediaFiles] - List of media files to upload (for image/video posts)
  /// [visibility] - Who can see the post (default: public)
  /// [sharedStoryId] - Story ID if this is a story share post
  /// [metadata] - Additional metadata as JSON
  ///
  /// Returns the created post data including generated ID.
  ///
  /// Throws [AuthException] if user is not authenticated.
  /// Throws [ServerException] on database/storage errors.
  Future<Map<String, dynamic>> createPost({
    required PostType postType,
    String? content,
    String? title,
    List<File>? mediaFiles,
    PostVisibility visibility = PostVisibility.public,
    String? sharedStoryId,
    Map<String, dynamic>? metadata,
  }) async {
    final logger = getIt<Talker>();

    try {
      final currentUserId = _supabase.auth.currentUser?.id;
      if (currentUserId == null) {
        throw AuthException('User must be authenticated to create posts');
      }

      logger.info(
        '[PostService] Creating ${postType.name} post for user $currentUserId',
      );

      // Upload media files if provided
      List<String> mediaUrls = [];
      String? thumbnailUrl;

      if (mediaFiles != null && mediaFiles.isNotEmpty) {
        for (int i = 0; i < mediaFiles.length; i++) {
          final file = mediaFiles[i];
          final fileExt = file.path.split('.').last.toLowerCase();
          final fileName = '${const Uuid().v4()}.$fileExt';
          final storagePath = '$currentUserId/$fileName';

          logger.debug('[PostService] Uploading media: $storagePath');

          await _supabase.storage.from('post-media').upload(
                storagePath,
                file,
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );

          final publicUrl =
              _supabase.storage.from('post-media').getPublicUrl(storagePath);
          mediaUrls.add(publicUrl);

          // First image/video becomes thumbnail
          if (i == 0) {
            thumbnailUrl = publicUrl;
          }
        }

        logger.debug('[PostService] Uploaded ${mediaUrls.length} media files');
      }

      // Prepare post data
      final postData = <String, dynamic>{
        'author_id': currentUserId,
        'post_type': _postTypeToString(postType),
        'content': content,
        'title': title,
        'media_urls': mediaUrls,
        'thumbnail_url': thumbnailUrl,
        'visibility': _visibilityToString(visibility),
        'shared_story_id': sharedStoryId,
        'metadata': metadata ?? {},
      };

      // Insert post
      final response = await _supabase
          .from('posts')
          .insert(postData)
          .select()
          .single();

      logger.info('[PostService] Created post: ${response['id']}');
      return response;
    } on AuthException {
      rethrow;
    } on StorageException catch (e, stackTrace) {
      logger.error('[PostService] Storage error creating post', e, stackTrace);
      throw ServerException('Failed to upload media: ${e.message}', e.statusCode);
    } on PostgrestException catch (e, stackTrace) {
      logger.error('[PostService] Database error creating post', e, stackTrace);
      throw ServerException('Failed to create post: ${e.message}', e.code);
    } catch (e, stackTrace) {
      logger.error('[PostService] Unexpected error creating post', e, stackTrace);
      throw const ServerException('Failed to create post');
    }
  }

  /// Gets a single post by ID.
  ///
  /// Returns post data with author profile information.
  /// RLS policies automatically filter based on visibility.
  Future<Map<String, dynamic>?> getPost(String postId) async {
    final logger = getIt<Talker>();

    try {
      final response = await _supabase
          .from('posts')
          .select('''
            *,
            author:profiles!posts_author_id_fkey(id, username, full_name, avatar_url)
          ''')
          .eq('id', postId)
          .maybeSingle();

      return response;
    } catch (e, stackTrace) {
      logger.error('[PostService] Error fetching post $postId', e, stackTrace);
      throw ServerException('Failed to fetch post: ${e.toString()}');
    }
  }

  /// Updates an existing post.
  ///
  /// Only the author can update their posts (enforced by RLS).
  Future<void> updatePost({
    required String postId,
    String? content,
    String? title,
    PostVisibility? visibility,
    bool? isCommentsDisabled,
    Map<String, dynamic>? metadata,
  }) async {
    final logger = getIt<Talker>();

    try {
      final updates = <String, dynamic>{
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      };

      if (content != null) updates['content'] = content;
      if (title != null) updates['title'] = title;
      if (visibility != null) {
        updates['visibility'] = _visibilityToString(visibility);
      }
      if (isCommentsDisabled != null) {
        updates['is_comments_disabled'] = isCommentsDisabled;
      }
      if (metadata != null) updates['metadata'] = metadata;

      await _supabase.from('posts').update(updates).eq('id', postId);

      logger.info('[PostService] Updated post $postId');
    } catch (e, stackTrace) {
      logger.error('[PostService] Error updating post $postId', e, stackTrace);
      throw ServerException('Failed to update post: ${e.toString()}');
    }
  }

  /// Deletes a post.
  ///
  /// Only the author can delete their posts (enforced by RLS).
  /// Associated media files are NOT automatically deleted.
  Future<void> deletePost(String postId) async {
    final logger = getIt<Talker>();

    try {
      await _supabase.from('posts').delete().eq('id', postId);
      logger.info('[PostService] Deleted post $postId');
    } catch (e, stackTrace) {
      logger.error('[PostService] Error deleting post $postId', e, stackTrace);
      throw ServerException('Failed to delete post: ${e.toString()}');
    }
  }

  /// Gets the main social feed with chronological ordering.
  ///
  /// [limit] - Maximum number of posts to fetch
  /// [offset] - Number of posts to skip (for pagination)
  /// [postType] - Optional filter by post type
  ///
  /// Returns posts with author profile data, ordered by most recent.
  Future<List<Map<String, dynamic>>> getFeed({
    required int limit,
    required int offset,
    PostType? postType,
  }) async {
    final logger = getIt<Talker>();

    try {
      // Build base query with filters first, then transformations
      var query = _supabase.from('posts').select('''
            *,
            author:profiles!posts_author_id_fkey(id, username, full_name, avatar_url)
          ''');

      if (postType != null) {
        query = query.eq('post_type', _postTypeToString(postType));
      }

      final response = await query
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);

      logger.debug('[PostService] Fetched ${response.length} feed items');
      return List<Map<String, dynamic>>.from(response);
    } catch (e, stackTrace) {
      logger.error('[PostService] Error fetching feed', e, stackTrace);
      throw ServerException('Failed to fetch feed: ${e.toString()}');
    }
  }

  /// Gets posts by a specific user.
  ///
  /// RLS policies automatically filter based on visibility and follow status.
  Future<List<Map<String, dynamic>>> getUserPosts({
    required String userId,
    required int limit,
    required int offset,
  }) async {
    final logger = getIt<Talker>();

    try {
      final response = await _supabase
          .from('posts')
          .select('''
            *,
            author:profiles!posts_author_id_fkey(id, username, full_name, avatar_url)
          ''')
          .eq('author_id', userId)
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);

      logger.debug(
        '[PostService] Fetched ${response.length} posts for user $userId',
      );
      return List<Map<String, dynamic>>.from(response);
    } catch (e, stackTrace) {
      logger.error('[PostService] Error fetching user posts', e, stackTrace);
      throw ServerException('Failed to fetch user posts: ${e.toString()}');
    }
  }

  /// Gets posts from users the current user follows.
  ///
  /// This provides a "following" feed experience.
  Future<List<Map<String, dynamic>>> getFollowingFeed({
    required int limit,
    required int offset,
  }) async {
    final logger = getIt<Talker>();

    try {
      final currentUserId = _supabase.auth.currentUser?.id;
      if (currentUserId == null) {
        return [];
      }

      // Get posts from followed users using a subquery
      final response = await _supabase
          .from('posts')
          .select('''
            *,
            author:profiles!posts_author_id_fkey(id, username, full_name, avatar_url)
          ''')
          .filter(
            'author_id',
            'in',
            '(SELECT following_id FROM follows WHERE follower_id = \'$currentUserId\')',
          )
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);

      logger.debug(
        '[PostService] Fetched ${response.length} following feed items',
      );
      return List<Map<String, dynamic>>.from(response);
    } catch (e, stackTrace) {
      logger.error('[PostService] Error fetching following feed', e, stackTrace);
      throw ServerException('Failed to fetch following feed: ${e.toString()}');
    }
  }

  /// Subscribes to real-time post updates for the feed.
  ///
  /// Returns a stream that emits new posts as they are created.
  /// Each new post event contains the full post data with author info.
  Stream<Map<String, dynamic>> subscribeToNewPosts() {
    final logger = getIt<Talker>();

    logger.info('[PostService] Setting up real-time post subscription');

    return _supabase
        .from('posts')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .limit(1)
        .map((data) {
          if (data.isNotEmpty) {
            return data.first;
          }
          return <String, dynamic>{};
        });
  }

  /// Increments the view count for a post.
  /// Gets a single post by its ID.
  ///
  /// Returns null if post doesn't exist or user doesn't have access.
  Future<Map<String, dynamic>?> getPostById(String postId) async {
    final logger = getIt<Talker>();

    try {
      final response = await _supabase
          .from('posts')
          .select('''
            *,
            author:profiles!posts_author_id_fkey(id, username, full_name, avatar_url)
          ''')
          .eq('id', postId)
          .maybeSingle();

      if (response == null) {
        logger.debug('[PostService] Post $postId not found');
        return null;
      }

      return response;
    } catch (e, stackTrace) {
      logger.error('[PostService] Error fetching post $postId', e, stackTrace);
      return null;
    }
  }

  /// Increments view count for a post.
  Future<void> incrementViewCount(String postId) async {
    try {
      await _supabase.rpc('increment_post_view', params: {'post_id': postId});
    } catch (e) {
      // Non-critical operation, don't throw
      getIt<Talker>().warning('[PostService] Failed to increment view count: $e');
    }
  }

  // Helper methods
  String _postTypeToString(PostType type) {
    switch (type) {
      case PostType.text:
        return 'text';
      case PostType.image:
        return 'image';
      case PostType.video:
        return 'video';
      case PostType.storyShare:
        return 'story_share';
    }
  }

  String _visibilityToString(PostVisibility visibility) {
    switch (visibility) {
      case PostVisibility.public:
        return 'public';
      case PostVisibility.followers:
        return 'followers';
      case PostVisibility.private:
        return 'private';
    }
  }
}
