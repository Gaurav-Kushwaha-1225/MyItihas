import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:myitihas/features/notifications/domain/repositories/notification_repository.dart';
import 'package:myitihas/features/social/domain/repositories/user_repository.dart';
import 'notification_event.dart';
import 'notification_state.dart';

/// BLoC for managing notifications
@injectable
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository notificationRepository;
  final UserRepository userRepository;

  static const int _pageSize = 20;
  int _currentOffset = 0;

  NotificationBloc({
    required this.notificationRepository,
    required this.userRepository,
  }) : super(const NotificationState.initial()) {
    on<LoadNotificationsEvent>(_onLoadNotifications);
    on<LoadMoreNotificationsEvent>(_onLoadMore);
    on<MarkNotificationAsReadEvent>(_onMarkAsRead);
    on<MarkAllNotificationsAsReadEvent>(_onMarkAllAsRead);
  }

  Future<void> _onLoadNotifications(
    LoadNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationState.loading());

    _currentOffset = 0;

    final currentUserResult = await userRepository.getCurrentUser();
    final currentUser = currentUserResult.fold(
      (failure) => null,
      (user) => user,
    );

    if (currentUser == null) {
      emit(const NotificationState.error('Failed to get current user'));
      return;
    }

    final result = await notificationRepository.getNotifications(
      limit: _pageSize,
      offset: _currentOffset,
    );

    result.fold((failure) => emit(NotificationState.error(failure.message)), (
      notifications,
    ) {
      final unreadCount = notifications.where((n) => !n.isRead).length;
      emit(
        NotificationState.loaded(
          notifications: notifications,
          unreadCount: unreadCount,
          hasMore: notifications.length >= _pageSize,
        ),
      );
      _currentOffset = notifications.length;
    });
  }

  Future<void> _onLoadMore(
    LoadMoreNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final currentState = state;
    if (currentState is! NotificationLoaded || !currentState.hasMore) return;

    emit(currentState.copyWith(isLoadingMore: true));

    final currentUserResult = await userRepository.getCurrentUser();
    final currentUser = currentUserResult.fold(
      (failure) => null,
      (user) => user,
    );

    if (currentUser == null) {
      emit(currentState.copyWith(isLoadingMore: false));
      return;
    }

    final result = await notificationRepository.getNotifications(
      limit: _pageSize,
      offset: _currentOffset,
    );

    result.fold(
      (failure) => emit(currentState.copyWith(isLoadingMore: false)),
      (newNotifications) {
        final allNotifications = [
          ...currentState.notifications,
          ...newNotifications,
        ];
        final unreadCount = allNotifications.where((n) => !n.isRead).length;

        emit(
          NotificationState.loaded(
            notifications: allNotifications,
            unreadCount: unreadCount,
            hasMore: newNotifications.length >= _pageSize,
            isLoadingMore: false,
          ),
        );

        _currentOffset = allNotifications.length;
      },
    );
  }

  Future<void> _onMarkAsRead(
    MarkNotificationAsReadEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final currentState = state;
    if (currentState is! NotificationLoaded) return;

    final updatedNotifications = currentState.notifications.map((notification) {
      if (notification.id == event.notificationId) {
        return notification.copyWith(isRead: true);
      }
      return notification;
    }).toList();

    final unreadCount = updatedNotifications.where((n) => !n.isRead).length;

    emit(
      currentState.copyWith(
        notifications: updatedNotifications,
        unreadCount: unreadCount,
      ),
    );

    await notificationRepository.markAsRead(event.notificationId);
  }

  Future<void> _onMarkAllAsRead(
    MarkAllNotificationsAsReadEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final currentState = state;
    if (currentState is! NotificationLoaded) return;

    final updatedNotifications = currentState.notifications.map((notification) {
      return notification.copyWith(isRead: true);
    }).toList();

    emit(
      currentState.copyWith(
        notifications: updatedNotifications,
        unreadCount: 0,
      ),
    );

    final currentUserResult = await userRepository.getCurrentUser();
    final currentUser = currentUserResult.fold(
      (failure) => null,
      (user) => user,
    );

    if (currentUser == null) return;

    await notificationRepository.markAllAsRead();
  }
}
