import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myitihas/features/social/presentation/widgets/svg_avatar.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/features/social/presentation/bloc/notification_bloc.dart';
import 'package:myitihas/features/social/presentation/bloc/notification_event.dart';
import 'package:myitihas/features/social/presentation/bloc/notification_state.dart';
import 'package:myitihas/features/notifications/domain/entities/notification.dart'
    as notif;
import 'package:myitihas/i18n/strings.g.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<NotificationBloc>()
            ..add(const NotificationEvent.loadNotifications()),
      child: const _NotificationView(),
    );
  }
}

class _NotificationView extends StatefulWidget {
  const _NotificationView();

  @override
  State<_NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<_NotificationView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<NotificationBloc>().add(const NotificationEvent.loadMore());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.notification.title),
        actions: [
          BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              if (state is NotificationLoaded && state.unreadCount > 0) {
                return TextButton(
                  onPressed: () {
                    context.read<NotificationBloc>().add(
                      const NotificationEvent.markAllAsRead(),
                    );
                  },
                  child: Text(t.notification.mark_all_read),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (notifications, unreadCount, hasMore, isLoadingMore) {
              if (notifications.isEmpty) {
                return Center(child: Text(t.notification.no_notifications));
              }

              return ListView.separated(
                controller: _scrollController,
                itemCount: notifications.length + (isLoadingMore ? 1 : 0),
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  if (index >= notifications.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final notification = notifications[index];
                  return _NotificationTile(
                    notification: notification,
                    onTap: () {
                      // Mark as read
                      context.read<NotificationBloc>().add(
                        NotificationEvent.markAsRead(notification.id),
                      );

                      _handleNotificationTap(context, notification);
                    },
                  );
                },
              );
            },
            error: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${t.notification.error_prefix} $message'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<NotificationBloc>().add(
                        const NotificationEvent.loadNotifications(),
                      );
                    },
                    child: Text(t.notification.retry),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleNotificationTap(
    BuildContext context,
    notif.Notification notification,
  ) {
    switch (notification.type) {
      case notif.NotificationType.storyLike:
      case notif.NotificationType.storyComment:
      case notif.NotificationType.commentReply:
        context.push('/social-feed');
        break;
      case notif.NotificationType.follow:
        context.push('/profile/${notification.actorUser.id}');
        break;
      case notif.NotificationType.directMessage:
        // TODO: Need conversation ID
        context.push('/chat');
        break;
    }
  }
}

class _NotificationTile extends StatelessWidget {
  final notif.Notification notification;
  final VoidCallback onTap;

  const _NotificationTile({required this.notification, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      leading: SvgAvatar(
        imageUrl: notification.actorUser.avatarUrl,
        radius: 20,
        fallbackText: notification.actorUser.displayName,
      ),
      title: Text(
        _getTitleForNotification(notification),
        style: textTheme.bodyLarge?.copyWith(
          fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
        ),
      ),
      subtitle: Text(
        timeago.format(notification.timestamp),
        style: textTheme.bodySmall,
      ),
      trailing: !notification.isRead
          ? Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                shape: BoxShape.circle,
              ),
            )
          : null,
      onTap: onTap,
      tileColor: notification.isRead
          ? null
          : colorScheme.primary.withValues(alpha: 0.05),
    );
  }

  String _getTitleForNotification(notif.Notification notification) {
    final actorName = notification.actorUser.displayName;

    switch (notification.type) {
      case notif.NotificationType.storyLike:
        return t.notification.liked_your_story(ActorName: actorName);
      case notif.NotificationType.storyComment:
        return t.notification.commented_on_your_story(ActorName: actorName);
      case notif.NotificationType.commentReply:
        return t.notification.replied_to_your_comment(ActorName: actorName);
      case notif.NotificationType.follow:
        return t.notification.started_following_you(ActorName: actorName);
      case notif.NotificationType.directMessage:
        return t.notification.sent_you_a_message(ActorName: actorName);
    }
  }
}
