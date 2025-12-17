import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:myitihas/features/stories/domain/repositories/story_repository.dart';
import 'package:myitihas/features/social/domain/entities/share.dart';
import 'package:myitihas/features/social/domain/repositories/social_repository.dart';
import 'package:myitihas/features/social/domain/repositories/user_repository.dart';
import 'feed_event.dart';
import 'feed_state.dart';

@injectable
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final StoryRepository storyRepository;
  final SocialRepository socialRepository;
  final UserRepository userRepository;

  static const int _pageSize = 10;
  int _currentOffset = 0;

  FeedBloc({
    required this.storyRepository,
    required this.socialRepository,
    required this.userRepository,
  }) : super(const FeedState.initial()) {
    on<LoadFeedEvent>(_onLoadFeed);
    on<LoadMoreFeedEvent>(_onLoadMore);
    on<RefreshFeedEvent>(_onRefresh);
    on<ToggleLikeEvent>(_onToggleLike);
    on<ToggleBookmarkEvent>(_onToggleBookmark);
    on<AddCommentEvent>(_onAddComment);
    on<ShareStoryEvent>(_onShareStory);
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
        final result = await storyRepository.getStories(
          limit: _pageSize,
          offset: 0,
        );

        await result.fold(
          (failure) async {
            if (!emit.isDone) {
              emit(FeedState.error(failure.message));
            }
          },
          (stories) async {
            final storiesWithSocial = await _enrichStoriesWithSocialData(
              stories,
              currentUser.id,
            );

            _currentOffset = stories.length;

            if (!emit.isDone) {
              emit(
                FeedState.loaded(
                  stories: storiesWithSocial,
                  currentUser: currentUser,
                  hasMore: stories.length >= _pageSize,
                ),
              );
            }
          },
        );
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

    final result = await storyRepository.getStories(
      limit: _pageSize,
      offset: _currentOffset,
    );

    await result.fold(
      (failure) async {
        if (!emit.isDone) {
          emit(currentState.copyWith(isLoadingMore: false));
        }
      },
      (newStories) async {
        if (newStories.isEmpty) {
          if (!emit.isDone) {
            emit(currentState.copyWith(isLoadingMore: false, hasMore: false));
          }
          return;
        }

        final storiesWithSocial = await _enrichStoriesWithSocialData(
          newStories,
          currentState.currentUser.id,
        );

        _currentOffset += newStories.length;

        if (!emit.isDone) {
          emit(
            currentState.copyWith(
              stories: [...currentState.stories, ...storiesWithSocial],
              isLoadingMore: false,
              hasMore: newStories.length >= _pageSize,
            ),
          );
        }
      },
    );
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
        stories: currentState.stories,
        currentUser: currentState.currentUser,
        hasMore: currentState.hasMore,
      ),
    );

    final result = await storyRepository.getStories(
      limit: _pageSize,
      offset: 0,
    );

    await result.fold(
      (failure) async {
        if (!emit.isDone) {
          emit(
            FeedState.loaded(
              stories: currentState.stories,
              currentUser: currentState.currentUser,
              hasMore: currentState.hasMore,
            ),
          );
        }
      },
      (stories) async {
        final shuffled = List<Story>.from(stories)..shuffle(Random());

        final storiesWithSocial = await _enrichStoriesWithSocialData(
          shuffled,
          currentState.currentUser.id,
        );

        _currentOffset = stories.length;

        if (!emit.isDone) {
          emit(
            FeedState.loaded(
              stories: storiesWithSocial,
              currentUser: currentState.currentUser,
              hasMore: stories.length >= _pageSize,
            ),
          );
        }
      },
    );
  }

  Future<void> _onToggleLike(
    ToggleLikeEvent event,
    Emitter<FeedState> emit,
  ) async {
    final currentState = state;
    if (currentState is! FeedLoaded) return;

    final updatedStories = currentState.stories.map((story) {
      if (story.id == event.storyId) {
        final isLiked = story.isLikedByCurrentUser;
        return story.copyWith(
          isLikedByCurrentUser: !isLiked,
          likes: isLiked ? story.likes - 1 : story.likes + 1,
        );
      }
      return story;
    }).toList();

    if (!emit.isDone) {
      emit(currentState.copyWith(stories: updatedStories));
    }

    final story = currentState.stories.firstWhere((s) => s.id == event.storyId);

    if (story.isLikedByCurrentUser) {
      await socialRepository.unlikeStory(event.storyId);
    } else {
      await socialRepository.likeStory(event.storyId);
    }
  }

  Future<void> _onToggleBookmark(
    ToggleBookmarkEvent event,
    Emitter<FeedState> emit,
  ) async {
    final currentState = state;
    if (currentState is! FeedLoaded) return;

    final updatedStories = currentState.stories.map((story) {
      if (story.id == event.storyId) {
        return story.copyWith(isFavorite: !story.isFavorite);
      }
      return story;
    }).toList();

    if (!emit.isDone) {
      emit(currentState.copyWith(stories: updatedStories));
    }

    await storyRepository.toggleFavorite(event.storyId);
  }

  Future<void> _onAddComment(
    AddCommentEvent event,
    Emitter<FeedState> emit,
  ) async {
    final result = await socialRepository.addComment(
      storyId: event.storyId,
      text: event.text,
      parentCommentId: event.parentCommentId,
    );

    final currentState = state;
    if (currentState is FeedLoaded) {
      await result.fold((failure) async {}, (comment) async {
        final updatedStories = currentState.stories.map((story) {
          if (story.id == event.storyId) {
            return story.copyWith(commentCount: story.commentCount + 1);
          }
          return story;
        }).toList();

        if (!emit.isDone) {
          emit(currentState.copyWith(stories: updatedStories));
        }
      });
    }
  }

  Future<void> _onShareStory(
    ShareStoryEvent event,
    Emitter<FeedState> emit,
  ) async {
    final shareType = event.isDirect
        ? ShareType.directMessage
        : ShareType.external;

    await socialRepository.shareStory(
      storyId: event.storyId,
      shareType: shareType,
      recipientId: event.recipientId,
    );

    final currentState = state;
    if (currentState is FeedLoaded) {
      final updatedStories = currentState.stories.map((story) {
        if (story.id == event.storyId) {
          return story.copyWith(shareCount: story.shareCount + 1);
        }
        return story;
      }).toList();

      if (!emit.isDone) {
        emit(currentState.copyWith(stories: updatedStories));
      }
    }
  }

  Future<List<Story>> _enrichStoriesWithSocialData(
    List<Story> stories,
    String currentUserId,
  ) async {
    final allUsersResult = await userRepository.getAllUsers();

    return await allUsersResult.fold((failure) => stories, (users) async {
      final random = Random();
      final enrichedStories = <Story>[];

      for (final story in stories) {
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

        enrichedStories.add(
          story.copyWith(
            authorId: author.id,
            authorUser: author,
            likes: likeCount,
            commentCount: commentCount,
            shareCount: shareCount,
            isLikedByCurrentUser: isLiked,
          ),
        );
      }

      return enrichedStories;
    });
  }
}
