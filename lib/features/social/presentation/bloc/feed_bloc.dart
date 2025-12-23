import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:myitihas/features/social/domain/entities/content_type.dart';
import 'package:myitihas/features/social/domain/entities/feed_item.dart';

import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/features/stories/domain/repositories/story_repository.dart';
import 'package:myitihas/features/social/domain/entities/share.dart';
import 'package:myitihas/features/social/domain/repositories/post_repository.dart';
import 'package:myitihas/features/social/domain/repositories/social_repository.dart';
import 'package:myitihas/features/social/domain/repositories/user_repository.dart';
import 'feed_event.dart';
import 'feed_state.dart';

@injectable
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final StoryRepository storyRepository;
  final SocialRepository socialRepository;
  final UserRepository userRepository;
  final PostRepository postRepository;

  static const int _pageSize = 10;
  int _currentOffset = 0;
  FeedType _currentFeedType = FeedType.all;

  FeedBloc({
    required this.storyRepository,
    required this.socialRepository,
    required this.userRepository,
    required this.postRepository,
  }) : super(const FeedState.initial()) {
    on<LoadFeedEvent>(_onLoadFeed);
    on<LoadMoreFeedEvent>(_onLoadMore);
    on<RefreshFeedEvent>(_onRefresh);
    on<ChangeFeedTypeEvent>(_onChangeFeedType);
    on<ToggleLikeEvent>(_onToggleLike);
    on<ToggleBookmarkEvent>(_onToggleBookmark);
    on<AddCommentEvent>(_onAddComment);
    on<ShareContentEvent>(_onShareContent);
  }

  Future<void> _onLoadFeed(LoadFeedEvent event, Emitter<FeedState> emit) async {
    emit(const FeedState.loading());

    final currentUserResult = await userRepository.getCurrentUser();

    await currentUserResult.fold(
      (failure) async {
        if (!emit.isDone) {
          emit(FeedState.error(failure.message));
        }
      },
      (currentUser) async {
        final feedItems = await _loadFeedItems(
          feedType: _currentFeedType,
          limit: _pageSize,
          offset: 0,
        );

        _currentOffset = feedItems.length;

        if (!emit.isDone) {
          emit(
            FeedState.loaded(
              feedItems: feedItems,
              currentUser: currentUser,
              hasMore: feedItems.length >= _pageSize,
              currentFeedType: _currentFeedType,
            ),
          );
        }
      },
    );
  }

  Future<void> _onLoadMore(
    LoadMoreFeedEvent event,
    Emitter<FeedState> emit,
  ) async {
    final currentState = state;
    if (currentState is! FeedLoaded ||
        !currentState.hasMore ||
        currentState.isLoadingMore) {
      return;
    }

    emit(currentState.copyWith(isLoadingMore: true));

    final newItems = await _loadFeedItems(
      feedType: _currentFeedType,
      limit: _pageSize,
      offset: _currentOffset,
    );

    if (newItems.isEmpty) {
      if (!emit.isDone) {
        emit(currentState.copyWith(isLoadingMore: false, hasMore: false));
      }
      return;
    }

    _currentOffset += newItems.length;

    if (!emit.isDone) {
      emit(
        currentState.copyWith(
          feedItems: [...currentState.feedItems, ...newItems],
          isLoadingMore: false,
          hasMore: newItems.length >= _pageSize,
        ),
      );
    }
  }

  Future<void> _onRefresh(
    RefreshFeedEvent event,
    Emitter<FeedState> emit,
  ) async {
    final currentState = state;
    if (currentState is! FeedLoaded) {
      add(const FeedEvent.loadFeed());
      return;
    }

    emit(
      FeedState.refreshing(
        feedItems: currentState.feedItems,
        currentUser: currentState.currentUser,
        hasMore: currentState.hasMore,
        currentFeedType: currentState.currentFeedType,
      ),
    );

    final feedItems = await _loadFeedItems(
      feedType: _currentFeedType,
      limit: _pageSize,
      offset: 0,
    );

    _currentOffset = feedItems.length;

    if (!emit.isDone) {
      emit(
        FeedState.loaded(
          feedItems: feedItems,
          currentUser: currentState.currentUser,
          hasMore: feedItems.length >= _pageSize,
          currentFeedType: _currentFeedType,
        ),
      );
    }
  }

  Future<void> _onChangeFeedType(
    ChangeFeedTypeEvent event,
    Emitter<FeedState> emit,
  ) async {
    if (_currentFeedType == event.feedType) return;

    _currentFeedType = event.feedType;
    _currentOffset = 0;

    final currentState = state;
    if (currentState is FeedLoaded) {
      emit(const FeedState.loading());

      final feedItems = await _loadFeedItems(
        feedType: _currentFeedType,
        limit: _pageSize,
        offset: 0,
      );

      _currentOffset = feedItems.length;

      if (!emit.isDone) {
        emit(
          FeedState.loaded(
            feedItems: feedItems,
            currentUser: currentState.currentUser,
            hasMore: feedItems.length >= _pageSize,
            currentFeedType: _currentFeedType,
          ),
        );
      }
    } else {
      add(const FeedEvent.loadFeed());
    }
  }

  Future<void> _onToggleLike(
    ToggleLikeEvent event,
    Emitter<FeedState> emit,
  ) async {
    final currentState = state;
    if (currentState is! FeedLoaded) return;

    final updatedItems = currentState.feedItems.map((item) {
      if (item.id == event.contentId) {
        return item.toggleLike();
      }
      return item;
    }).toList();

    if (!emit.isDone) {
      emit(currentState.copyWith(feedItems: updatedItems));
    }

    // Find the item to check current like state
    final item = currentState.feedItems.firstWhere(
      (i) => i.id == event.contentId,
    );

    if (event.contentType == ContentType.story) {
      // Use existing social repository for stories
      if (item.isLikedByCurrentUser) {
        await socialRepository.unlikeStory(event.contentId);
      } else {
        await socialRepository.likeStory(event.contentId);
      }
    } else {
      // Use post repository for image/text posts
      if (item.isLikedByCurrentUser) {
        await postRepository.unlikeContent(
          contentId: event.contentId,
          contentType: event.contentType,
        );
      } else {
        await postRepository.likeContent(
          contentId: event.contentId,
          contentType: event.contentType,
        );
      }
    }
  }

  Future<void> _onToggleBookmark(
    ToggleBookmarkEvent event,
    Emitter<FeedState> emit,
  ) async {
    final currentState = state;
    if (currentState is! FeedLoaded) return;

    final updatedItems = currentState.feedItems.map((item) {
      if (item.id == event.contentId) {
        return item.toggleBookmark();
      }
      return item;
    }).toList();

    if (!emit.isDone) {
      emit(currentState.copyWith(feedItems: updatedItems));
    }

    if (event.contentType == ContentType.story) {
      await storyRepository.toggleFavorite(event.contentId);
    } else {
      await postRepository.toggleBookmark(
        contentId: event.contentId,
        contentType: event.contentType,
      );
    }
  }

  Future<void> _onAddComment(
    AddCommentEvent event,
    Emitter<FeedState> emit,
  ) async {
    // Only stories support comments for now via socialRepository
    if (event.contentType == ContentType.story) {
      final result = await socialRepository.addComment(
        storyId: event.contentId,
        text: event.text,
        parentCommentId: event.parentCommentId,
      );

      final currentState = state;
      if (currentState is FeedLoaded) {
        await result.fold((failure) async {}, (comment) async {
          final updatedItems = currentState.feedItems.map((item) {
            if (item.id == event.contentId) {
              return item.incrementCommentCount();
            }
            return item;
          }).toList();

          if (!emit.isDone) {
            emit(currentState.copyWith(feedItems: updatedItems));
          }
        });
      }
    }
    // TODO: Add comment support for image/text posts when backend is ready
  }

  Future<void> _onShareContent(
    ShareContentEvent event,
    Emitter<FeedState> emit,
  ) async {
    if (event.contentType == ContentType.story) {
      final shareType = event.isDirect
          ? ShareType.directMessage
          : ShareType.external;

      await socialRepository.shareStory(
        storyId: event.contentId,
        shareType: shareType,
        recipientId: event.recipientId,
      );
    }
    // TODO: Add share tracking for image/text posts when backend is ready

    final currentState = state;
    if (currentState is FeedLoaded) {
      final updatedItems = currentState.feedItems.map((item) {
        if (item.id == event.contentId) {
          return item.incrementShareCount();
        }
        return item;
      }).toList();

      if (!emit.isDone) {
        emit(currentState.copyWith(feedItems: updatedItems));
      }
    }
  }

  /// Load feed items based on feed type
  Future<List<FeedItem>> _loadFeedItems({
    required FeedType feedType,
    required int limit,
    required int offset,
  }) async {
    switch (feedType) {
      case FeedType.all:
        return await _loadAllFeedItems(limit: limit, offset: offset);
      case FeedType.stories:
        return await _loadStories(limit: limit, offset: offset);
      case FeedType.images:
        return await _loadImagePosts(limit: limit, offset: offset);
      case FeedType.text:
        return await _loadTextPosts(limit: limit, offset: offset);
    }
  }

  Future<List<FeedItem>> _loadAllFeedItems({
    required int limit,
    required int offset,
  }) async {
    final result = await postRepository.getAllFeedItems(
      limit: limit,
      offset: offset,
    );

    return await result.fold((failure) => <FeedItem>[], (items) async {
      // Enrich stories with social data
      final enrichedItems = <FeedItem>[];
      final currentUserResult = await userRepository.getCurrentUser();
      final currentUserId = currentUserResult.fold(
        (f) => 'anonymous',
        (u) => u.id,
      );

      for (final item in items) {
        if (item is StoryFeedItem) {
          final enrichedStory = await _enrichStoryWithSocialData(
            item.story,
            currentUserId,
          );
          enrichedItems.add(FeedItem.story(enrichedStory));
        } else {
          enrichedItems.add(item);
        }
      }

      // Shuffle for variety
      enrichedItems.shuffle(Random());
      return enrichedItems;
    });
  }

  Future<List<FeedItem>> _loadStories({
    required int limit,
    required int offset,
  }) async {
    final result = await storyRepository.getStories(
      limit: limit,
      offset: offset,
    );

    return await result.fold((failure) => <FeedItem>[], (stories) async {
      final currentUserResult = await userRepository.getCurrentUser();
      final currentUserId = currentUserResult.fold(
        (f) => 'anonymous',
        (u) => u.id,
      );

      final enrichedStories = await Future.wait(
        stories.map((s) => _enrichStoryWithSocialData(s, currentUserId)),
      );

      return enrichedStories.map((s) => FeedItem.story(s)).toList();
    });
  }

  Future<List<FeedItem>> _loadImagePosts({
    required int limit,
    required int offset,
  }) async {
    final result = await postRepository.getImagePosts(
      limit: limit,
      offset: offset,
    );

    return result.fold(
      (failure) => <FeedItem>[],
      (posts) => posts.map((p) => FeedItem.imagePost(p)).toList(),
    );
  }

  Future<List<FeedItem>> _loadTextPosts({
    required int limit,
    required int offset,
  }) async {
    final result = await postRepository.getTextPosts(
      limit: limit,
      offset: offset,
    );

    return result.fold(
      (failure) => <FeedItem>[],
      (posts) => posts.map((p) => FeedItem.textPost(p)).toList(),
    );
  }

  Future<Story> _enrichStoryWithSocialData(
    Story story,
    String currentUserId,
  ) async {
    final allUsersResult = await userRepository.getAllUsers();

    return await allUsersResult.fold((failure) => story, (users) async {
      final random = Random();
      final author = story.authorId == currentUserId
          ? users.firstWhere((u) => u.id == currentUserId)
          : users[random.nextInt(users.length)];

      final isLikedResult = await socialRepository.isStoryLiked(story.id);
      final isLiked = isLikedResult.fold((l) => false, (r) => r);

      final likeCountResult = await socialRepository.getStoryLikeCount(
        story.id,
      );
      final likeCount = likeCountResult.fold(
        (l) => random.nextInt(500),
        (r) => r,
      );

      final commentsResult = await socialRepository.getCommentsTree(story.id);
      final commentCount = commentsResult.fold((l) => 0, (r) => r.length);

      final shareCountResult = await socialRepository.getStoryShareCount(
        story.id,
      );
      final shareCount = shareCountResult.fold(
        (l) => random.nextInt(100),
        (r) => r,
      );

      return story.copyWith(
        authorId: author.id,
        authorUser: author,
        likes: likeCount,
        commentCount: commentCount,
        shareCount: shareCount,
        isLikedByCurrentUser: isLiked,
      );
    });
  }
}
