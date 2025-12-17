import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myitihas/features/social/domain/entities/user.dart';

part 'profile_state.freezed.dart';

@Freezed(toStringOverride: true)
sealed class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = ProfileInitial;

  const factory ProfileState.loading() = ProfileLoading;

  const factory ProfileState.loaded({
    required User user,
    @Default([]) List<User> followers,
    @Default([]) List<User> following,
    @Default(false) bool isLoadingFollowers,
    @Default(false) bool isLoadingFollowing,
  }) = ProfileLoaded;

  const factory ProfileState.error(String message) = ProfileError;

  const ProfileState._();

  @override
  String toString() {
    return map(
      initial: (_) => 'ProfileState.initial()',
      loading: (_) => 'ProfileState.loading()',
      loaded: (state) =>
          'ProfileState.loaded(user: ${state.user.username}, followers: ${state.followers.length})',
      error: (state) => 'ProfileState.error(message: "${state.message}")',
    );
  }
}
