import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myitihas/features/notifications/domain/entities/notification.dart'
    as notif;

part 'notification_state.freezed.dart';

@Freezed(toStringOverride: true)
sealed class NotificationState with _$NotificationState {
  const factory NotificationState.initial() = NotificationInitial;

  const factory NotificationState.loading() = NotificationLoading;

  const factory NotificationState.loaded({
    required List<notif.Notification> notifications,
    required int unreadCount,
    required bool hasMore,
    @Default(false) bool isLoadingMore,
  }) = NotificationLoaded;

  const factory NotificationState.error(String message) = NotificationError;

  const NotificationState._();

  @override
  String toString() {
    return map(
      initial: (_) => 'NotificationState.initial()',
      loading: (_) => 'NotificationState.loading()',
      loaded: (state) =>
          'NotificationState.loaded(notifications: ${state.notifications.length}, unread: ${state.unreadCount})',
      error: (state) => 'NotificationState.error(message: "${state.message}")',
    );
  }
}
