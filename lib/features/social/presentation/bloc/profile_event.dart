import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_event.freezed.dart';

@freezed
sealed class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.loadProfile(String userId) = LoadProfileEvent;
  const factory ProfileEvent.toggleFollow(String userId) = ToggleFollowEvent;
  const factory ProfileEvent.loadFollowers(String userId) = LoadFollowersEvent;
  const factory ProfileEvent.loadFollowing(String userId) = LoadFollowingEvent;
}
