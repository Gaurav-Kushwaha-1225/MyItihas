import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/features/social/domain/repositories/user_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

/// BLoC for managing user profiles
@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;

  ProfileBloc({required this.userRepository})
    : super(const ProfileState.initial()) {
    on<LoadProfileEvent>(_onLoadProfile);
    on<ToggleFollowEvent>(_onToggleFollow);
    on<LoadFollowersEvent>(_onLoadFollowers);
    on<LoadFollowingEvent>(_onLoadFollowing);
  }

  Future<void> _onLoadProfile(
    LoadProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final logger = getIt<Talker>();
    logger.info('📱 [ProfileBloc] Loading profile for user: ${event.userId}');
    
    emit(const ProfileState.loading());

    final result = await userRepository.getUserProfile(event.userId);

    result.fold(
      (failure) {
        logger.error('❌ [ProfileBloc] Failed to load profile: ${failure.message}');
        emit(ProfileState.error(failure.message));
      },
      (user) {
        logger.info('✅ [ProfileBloc] Profile loaded successfully');
        logger.info('👤 [ProfileBloc] User: ${user.displayName}');
        logger.info('🖼️ [ProfileBloc] Avatar URL: "${user.avatarUrl}"');
        emit(ProfileState.loaded(user: user));
      },
    );
  }

  Future<void> _onToggleFollow(
    ToggleFollowEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ProfileLoaded) return;

    final user = currentState.user;
    final isCurrentlyFollowing = user.isFollowing;

    final updatedUser = user.copyWith(
      isFollowing: !isCurrentlyFollowing,
      followerCount: isCurrentlyFollowing
          ? user.followerCount - 1
          : user.followerCount + 1,
    );

    emit(currentState.copyWith(user: updatedUser));

    final result = isCurrentlyFollowing
        ? await userRepository.unfollowUser(event.userId)
        : await userRepository.followUser(event.userId);

    result.fold((failure) {
      if (!emit.isDone) {
        emit(currentState.copyWith(user: user));
      }
    }, (_) {});

    if (result.isRight() && !emit.isDone) {
      final profileResult = await userRepository.getUserProfile(event.userId);
      profileResult.fold((failure) {}, (reloadedUser) {
        if (!emit.isDone) {
          emit(currentState.copyWith(user: reloadedUser));
        }
      });
    }
  }

  Future<void> _onLoadFollowers(
    LoadFollowersEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ProfileLoaded) return;

    emit(currentState.copyWith(isLoadingFollowers: true));

    final result = await userRepository.getFollowers(event.userId);

    result.fold(
      (failure) => emit(currentState.copyWith(isLoadingFollowers: false)),
      (followers) => emit(
        currentState.copyWith(followers: followers, isLoadingFollowers: false),
      ),
    );
  }

  Future<void> _onLoadFollowing(
    LoadFollowingEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ProfileLoaded) return;

    emit(currentState.copyWith(isLoadingFollowing: true));

    final result = await userRepository.getFollowing(event.userId);

    result.fold(
      (failure) => emit(currentState.copyWith(isLoadingFollowing: false)),
      (following) => emit(
        currentState.copyWith(following: following, isLoadingFollowing: false),
      ),
    );
  }
}
