import 'package:injectable/injectable.dart';
import 'package:myitihas/core/errors/exceptions.dart';
import 'package:myitihas/features/social/data/datasources/user_data_source.dart';
import '../models/notification_model.dart';

abstract class NotificationDataSource {
  Future<List<NotificationModel>> getNotifications(
    String userId, {
    int limit = 20,
    int offset = 0,
  });
  Future<int> getUnreadCount(String userId);
  Future<void> markAsRead(String notificationId);
  Future<void> markAllAsRead(String userId);
  Future<void> deleteNotification(String notificationId);
  Future<void> createNotification(NotificationModel notification);
}

/// Mock implementation of notification data source
@LazySingleton(as: NotificationDataSource)
class NotificationDataSourceImpl implements NotificationDataSource {
  final UserDataSource userDataSource;

  // In-memory storage
  final Map<String, NotificationModel> _notifications = {};
  final Map<String, List<String>> _userNotifications =
      {}; // userId -> notification IDs

  static const int _maxNotifications = 100;

  NotificationDataSourceImpl(this.userDataSource);

  @override
  Future<List<NotificationModel>> getNotifications(
    String userId, {
    int limit = 20,
    int offset = 0,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final notificationIds = _userNotifications[userId] ?? [];
    final notifications = notificationIds
        .map((id) => _notifications[id])
        .whereType<NotificationModel>()
        .toList();

    notifications.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    final paginated = notifications.skip(offset).take(limit).toList();

    return paginated;
  }

  @override
  Future<int> getUnreadCount(String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final notificationIds = _userNotifications[userId] ?? [];
    final unreadCount = notificationIds
        .map((id) => _notifications[id])
        .whereType<NotificationModel>()
        .where((n) => !n.isRead)
        .length;

    return unreadCount;
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final notification = _notifications[notificationId];
    if (notification != null) {
      _notifications[notificationId] = notification.copyWith(isRead: true);
    }
  }

  @override
  Future<void> markAllAsRead(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final notificationIds = _userNotifications[userId] ?? [];
    for (final id in notificationIds) {
      final notification = _notifications[id];
      if (notification != null && !notification.isRead) {
        _notifications[id] = notification.copyWith(isRead: true);
      }
    }
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final notification = _notifications[notificationId];
    if (notification == null) {
      throw const NotFoundException('Notification not found');
    }

    for (final userId in _userNotifications.keys) {
      _userNotifications[userId]?.remove(notificationId);
    }

    _notifications.remove(notificationId);
  }

  @override
  Future<void> createNotification(NotificationModel notification) async {
    await Future.delayed(const Duration(milliseconds: 150));

    final targetUserId = notification.deepLinkData['targetUserId'] as String?;
    if (targetUserId == null) return;

    _notifications[notification.id] = notification;
    _userNotifications
        .putIfAbsent(targetUserId, () => [])
        .insert(0, notification.id);

    await _pruneNotifications(targetUserId);
  }

  Future<void> _pruneNotifications(String userId) async {
    final notificationIds = _userNotifications[userId] ?? [];
    if (notificationIds.length > _maxNotifications) {
      final toRemove = notificationIds.skip(_maxNotifications).toList();
      for (final id in toRemove) {
        _notifications.remove(id);
      }
      _userNotifications[userId] = notificationIds
          .take(_maxNotifications)
          .toList();
    }
  }
}
