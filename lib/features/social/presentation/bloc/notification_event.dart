import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_event.freezed.dart';

@freezed
sealed class NotificationEvent with _$NotificationEvent {
  const factory NotificationEvent.loadNotifications() = LoadNotificationsEvent;
  const factory NotificationEvent.loadMore() = LoadMoreNotificationsEvent;
  const factory NotificationEvent.markAsRead(String notificationId) =
      MarkNotificationAsReadEvent;
  const factory NotificationEvent.markAllAsRead() =
      MarkAllNotificationsAsReadEvent;
}
