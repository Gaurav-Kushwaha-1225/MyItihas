// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationEvent()';
}


}

/// @nodoc
class $NotificationEventCopyWith<$Res>  {
$NotificationEventCopyWith(NotificationEvent _, $Res Function(NotificationEvent) __);
}


/// Adds pattern-matching-related methods to [NotificationEvent].
extension NotificationEventPatterns on NotificationEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadNotificationsEvent value)?  loadNotifications,TResult Function( LoadMoreNotificationsEvent value)?  loadMore,TResult Function( MarkNotificationAsReadEvent value)?  markAsRead,TResult Function( MarkAllNotificationsAsReadEvent value)?  markAllAsRead,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadNotificationsEvent() when loadNotifications != null:
return loadNotifications(_that);case LoadMoreNotificationsEvent() when loadMore != null:
return loadMore(_that);case MarkNotificationAsReadEvent() when markAsRead != null:
return markAsRead(_that);case MarkAllNotificationsAsReadEvent() when markAllAsRead != null:
return markAllAsRead(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadNotificationsEvent value)  loadNotifications,required TResult Function( LoadMoreNotificationsEvent value)  loadMore,required TResult Function( MarkNotificationAsReadEvent value)  markAsRead,required TResult Function( MarkAllNotificationsAsReadEvent value)  markAllAsRead,}){
final _that = this;
switch (_that) {
case LoadNotificationsEvent():
return loadNotifications(_that);case LoadMoreNotificationsEvent():
return loadMore(_that);case MarkNotificationAsReadEvent():
return markAsRead(_that);case MarkAllNotificationsAsReadEvent():
return markAllAsRead(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadNotificationsEvent value)?  loadNotifications,TResult? Function( LoadMoreNotificationsEvent value)?  loadMore,TResult? Function( MarkNotificationAsReadEvent value)?  markAsRead,TResult? Function( MarkAllNotificationsAsReadEvent value)?  markAllAsRead,}){
final _that = this;
switch (_that) {
case LoadNotificationsEvent() when loadNotifications != null:
return loadNotifications(_that);case LoadMoreNotificationsEvent() when loadMore != null:
return loadMore(_that);case MarkNotificationAsReadEvent() when markAsRead != null:
return markAsRead(_that);case MarkAllNotificationsAsReadEvent() when markAllAsRead != null:
return markAllAsRead(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadNotifications,TResult Function()?  loadMore,TResult Function( String notificationId)?  markAsRead,TResult Function()?  markAllAsRead,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadNotificationsEvent() when loadNotifications != null:
return loadNotifications();case LoadMoreNotificationsEvent() when loadMore != null:
return loadMore();case MarkNotificationAsReadEvent() when markAsRead != null:
return markAsRead(_that.notificationId);case MarkAllNotificationsAsReadEvent() when markAllAsRead != null:
return markAllAsRead();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadNotifications,required TResult Function()  loadMore,required TResult Function( String notificationId)  markAsRead,required TResult Function()  markAllAsRead,}) {final _that = this;
switch (_that) {
case LoadNotificationsEvent():
return loadNotifications();case LoadMoreNotificationsEvent():
return loadMore();case MarkNotificationAsReadEvent():
return markAsRead(_that.notificationId);case MarkAllNotificationsAsReadEvent():
return markAllAsRead();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadNotifications,TResult? Function()?  loadMore,TResult? Function( String notificationId)?  markAsRead,TResult? Function()?  markAllAsRead,}) {final _that = this;
switch (_that) {
case LoadNotificationsEvent() when loadNotifications != null:
return loadNotifications();case LoadMoreNotificationsEvent() when loadMore != null:
return loadMore();case MarkNotificationAsReadEvent() when markAsRead != null:
return markAsRead(_that.notificationId);case MarkAllNotificationsAsReadEvent() when markAllAsRead != null:
return markAllAsRead();case _:
  return null;

}
}

}

/// @nodoc


class LoadNotificationsEvent implements NotificationEvent {
  const LoadNotificationsEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadNotificationsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationEvent.loadNotifications()';
}


}




/// @nodoc


class LoadMoreNotificationsEvent implements NotificationEvent {
  const LoadMoreNotificationsEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadMoreNotificationsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationEvent.loadMore()';
}


}




/// @nodoc


class MarkNotificationAsReadEvent implements NotificationEvent {
  const MarkNotificationAsReadEvent(this.notificationId);
  

 final  String notificationId;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarkNotificationAsReadEventCopyWith<MarkNotificationAsReadEvent> get copyWith => _$MarkNotificationAsReadEventCopyWithImpl<MarkNotificationAsReadEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarkNotificationAsReadEvent&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId));
}


@override
int get hashCode => Object.hash(runtimeType,notificationId);

@override
String toString() {
  return 'NotificationEvent.markAsRead(notificationId: $notificationId)';
}


}

/// @nodoc
abstract mixin class $MarkNotificationAsReadEventCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory $MarkNotificationAsReadEventCopyWith(MarkNotificationAsReadEvent value, $Res Function(MarkNotificationAsReadEvent) _then) = _$MarkNotificationAsReadEventCopyWithImpl;
@useResult
$Res call({
 String notificationId
});




}
/// @nodoc
class _$MarkNotificationAsReadEventCopyWithImpl<$Res>
    implements $MarkNotificationAsReadEventCopyWith<$Res> {
  _$MarkNotificationAsReadEventCopyWithImpl(this._self, this._then);

  final MarkNotificationAsReadEvent _self;
  final $Res Function(MarkNotificationAsReadEvent) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? notificationId = null,}) {
  return _then(MarkNotificationAsReadEvent(
null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class MarkAllNotificationsAsReadEvent implements NotificationEvent {
  const MarkAllNotificationsAsReadEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarkAllNotificationsAsReadEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationEvent.markAllAsRead()';
}


}




// dart format on
