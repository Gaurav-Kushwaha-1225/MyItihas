// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Notification {

 String get id; NotificationType get type; User get actorUser; String? get targetStoryId; String? get targetCommentId; String get contentPreview; DateTime get timestamp; bool get isRead; Map<String, dynamic> get deepLinkData;
/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationCopyWith<Notification> get copyWith => _$NotificationCopyWithImpl<Notification>(this as Notification, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Notification&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.actorUser, actorUser) || other.actorUser == actorUser)&&(identical(other.targetStoryId, targetStoryId) || other.targetStoryId == targetStoryId)&&(identical(other.targetCommentId, targetCommentId) || other.targetCommentId == targetCommentId)&&(identical(other.contentPreview, contentPreview) || other.contentPreview == contentPreview)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&const DeepCollectionEquality().equals(other.deepLinkData, deepLinkData));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,actorUser,targetStoryId,targetCommentId,contentPreview,timestamp,isRead,const DeepCollectionEquality().hash(deepLinkData));

@override
String toString() {
  return 'Notification(id: $id, type: $type, actorUser: $actorUser, targetStoryId: $targetStoryId, targetCommentId: $targetCommentId, contentPreview: $contentPreview, timestamp: $timestamp, isRead: $isRead, deepLinkData: $deepLinkData)';
}


}

/// @nodoc
abstract mixin class $NotificationCopyWith<$Res>  {
  factory $NotificationCopyWith(Notification value, $Res Function(Notification) _then) = _$NotificationCopyWithImpl;
@useResult
$Res call({
 String id, NotificationType type, User actorUser, String? targetStoryId, String? targetCommentId, String contentPreview, DateTime timestamp, bool isRead, Map<String, dynamic> deepLinkData
});


$UserCopyWith<$Res> get actorUser;

}
/// @nodoc
class _$NotificationCopyWithImpl<$Res>
    implements $NotificationCopyWith<$Res> {
  _$NotificationCopyWithImpl(this._self, this._then);

  final Notification _self;
  final $Res Function(Notification) _then;

/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? actorUser = null,Object? targetStoryId = freezed,Object? targetCommentId = freezed,Object? contentPreview = null,Object? timestamp = null,Object? isRead = null,Object? deepLinkData = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationType,actorUser: null == actorUser ? _self.actorUser : actorUser // ignore: cast_nullable_to_non_nullable
as User,targetStoryId: freezed == targetStoryId ? _self.targetStoryId : targetStoryId // ignore: cast_nullable_to_non_nullable
as String?,targetCommentId: freezed == targetCommentId ? _self.targetCommentId : targetCommentId // ignore: cast_nullable_to_non_nullable
as String?,contentPreview: null == contentPreview ? _self.contentPreview : contentPreview // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,deepLinkData: null == deepLinkData ? _self.deepLinkData : deepLinkData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}
/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get actorUser {
  
  return $UserCopyWith<$Res>(_self.actorUser, (value) {
    return _then(_self.copyWith(actorUser: value));
  });
}
}


/// Adds pattern-matching-related methods to [Notification].
extension NotificationPatterns on Notification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Notification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Notification() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Notification value)  $default,){
final _that = this;
switch (_that) {
case _Notification():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Notification value)?  $default,){
final _that = this;
switch (_that) {
case _Notification() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  NotificationType type,  User actorUser,  String? targetStoryId,  String? targetCommentId,  String contentPreview,  DateTime timestamp,  bool isRead,  Map<String, dynamic> deepLinkData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Notification() when $default != null:
return $default(_that.id,_that.type,_that.actorUser,_that.targetStoryId,_that.targetCommentId,_that.contentPreview,_that.timestamp,_that.isRead,_that.deepLinkData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  NotificationType type,  User actorUser,  String? targetStoryId,  String? targetCommentId,  String contentPreview,  DateTime timestamp,  bool isRead,  Map<String, dynamic> deepLinkData)  $default,) {final _that = this;
switch (_that) {
case _Notification():
return $default(_that.id,_that.type,_that.actorUser,_that.targetStoryId,_that.targetCommentId,_that.contentPreview,_that.timestamp,_that.isRead,_that.deepLinkData);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  NotificationType type,  User actorUser,  String? targetStoryId,  String? targetCommentId,  String contentPreview,  DateTime timestamp,  bool isRead,  Map<String, dynamic> deepLinkData)?  $default,) {final _that = this;
switch (_that) {
case _Notification() when $default != null:
return $default(_that.id,_that.type,_that.actorUser,_that.targetStoryId,_that.targetCommentId,_that.contentPreview,_that.timestamp,_that.isRead,_that.deepLinkData);case _:
  return null;

}
}

}

/// @nodoc


class _Notification extends Notification {
  const _Notification({required this.id, required this.type, required this.actorUser, this.targetStoryId, this.targetCommentId, required this.contentPreview, required this.timestamp, this.isRead = false, final  Map<String, dynamic> deepLinkData = const {}}): _deepLinkData = deepLinkData,super._();
  

@override final  String id;
@override final  NotificationType type;
@override final  User actorUser;
@override final  String? targetStoryId;
@override final  String? targetCommentId;
@override final  String contentPreview;
@override final  DateTime timestamp;
@override@JsonKey() final  bool isRead;
 final  Map<String, dynamic> _deepLinkData;
@override@JsonKey() Map<String, dynamic> get deepLinkData {
  if (_deepLinkData is EqualUnmodifiableMapView) return _deepLinkData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_deepLinkData);
}


/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationCopyWith<_Notification> get copyWith => __$NotificationCopyWithImpl<_Notification>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Notification&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.actorUser, actorUser) || other.actorUser == actorUser)&&(identical(other.targetStoryId, targetStoryId) || other.targetStoryId == targetStoryId)&&(identical(other.targetCommentId, targetCommentId) || other.targetCommentId == targetCommentId)&&(identical(other.contentPreview, contentPreview) || other.contentPreview == contentPreview)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&const DeepCollectionEquality().equals(other._deepLinkData, _deepLinkData));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,actorUser,targetStoryId,targetCommentId,contentPreview,timestamp,isRead,const DeepCollectionEquality().hash(_deepLinkData));

@override
String toString() {
  return 'Notification(id: $id, type: $type, actorUser: $actorUser, targetStoryId: $targetStoryId, targetCommentId: $targetCommentId, contentPreview: $contentPreview, timestamp: $timestamp, isRead: $isRead, deepLinkData: $deepLinkData)';
}


}

/// @nodoc
abstract mixin class _$NotificationCopyWith<$Res> implements $NotificationCopyWith<$Res> {
  factory _$NotificationCopyWith(_Notification value, $Res Function(_Notification) _then) = __$NotificationCopyWithImpl;
@override @useResult
$Res call({
 String id, NotificationType type, User actorUser, String? targetStoryId, String? targetCommentId, String contentPreview, DateTime timestamp, bool isRead, Map<String, dynamic> deepLinkData
});


@override $UserCopyWith<$Res> get actorUser;

}
/// @nodoc
class __$NotificationCopyWithImpl<$Res>
    implements _$NotificationCopyWith<$Res> {
  __$NotificationCopyWithImpl(this._self, this._then);

  final _Notification _self;
  final $Res Function(_Notification) _then;

/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? actorUser = null,Object? targetStoryId = freezed,Object? targetCommentId = freezed,Object? contentPreview = null,Object? timestamp = null,Object? isRead = null,Object? deepLinkData = null,}) {
  return _then(_Notification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationType,actorUser: null == actorUser ? _self.actorUser : actorUser // ignore: cast_nullable_to_non_nullable
as User,targetStoryId: freezed == targetStoryId ? _self.targetStoryId : targetStoryId // ignore: cast_nullable_to_non_nullable
as String?,targetCommentId: freezed == targetCommentId ? _self.targetCommentId : targetCommentId // ignore: cast_nullable_to_non_nullable
as String?,contentPreview: null == contentPreview ? _self.contentPreview : contentPreview // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,deepLinkData: null == deepLinkData ? _self._deepLinkData : deepLinkData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

/// Create a copy of Notification
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get actorUser {
  
  return $UserCopyWith<$Res>(_self.actorUser, (value) {
    return _then(_self.copyWith(actorUser: value));
  });
}
}

// dart format on
