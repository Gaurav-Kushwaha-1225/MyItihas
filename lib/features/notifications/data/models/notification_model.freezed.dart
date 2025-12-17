// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationModel {

@HiveField(0) String get id;@HiveField(1) NotificationType get type;@HiveField(2) UserModel get actorUser;@HiveField(3) String? get targetStoryId;@HiveField(4) String? get targetCommentId;@HiveField(5) String get contentPreview;@HiveField(6) DateTime get timestamp;@HiveField(7) bool get isRead;@HiveField(8) Map<String, dynamic> get deepLinkData;
/// Create a copy of NotificationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationModelCopyWith<NotificationModel> get copyWith => _$NotificationModelCopyWithImpl<NotificationModel>(this as NotificationModel, _$identity);

  /// Serializes this NotificationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.actorUser, actorUser) || other.actorUser == actorUser)&&(identical(other.targetStoryId, targetStoryId) || other.targetStoryId == targetStoryId)&&(identical(other.targetCommentId, targetCommentId) || other.targetCommentId == targetCommentId)&&(identical(other.contentPreview, contentPreview) || other.contentPreview == contentPreview)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&const DeepCollectionEquality().equals(other.deepLinkData, deepLinkData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,actorUser,targetStoryId,targetCommentId,contentPreview,timestamp,isRead,const DeepCollectionEquality().hash(deepLinkData));

@override
String toString() {
  return 'NotificationModel(id: $id, type: $type, actorUser: $actorUser, targetStoryId: $targetStoryId, targetCommentId: $targetCommentId, contentPreview: $contentPreview, timestamp: $timestamp, isRead: $isRead, deepLinkData: $deepLinkData)';
}


}

/// @nodoc
abstract mixin class $NotificationModelCopyWith<$Res>  {
  factory $NotificationModelCopyWith(NotificationModel value, $Res Function(NotificationModel) _then) = _$NotificationModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String id,@HiveField(1) NotificationType type,@HiveField(2) UserModel actorUser,@HiveField(3) String? targetStoryId,@HiveField(4) String? targetCommentId,@HiveField(5) String contentPreview,@HiveField(6) DateTime timestamp,@HiveField(7) bool isRead,@HiveField(8) Map<String, dynamic> deepLinkData
});


$UserModelCopyWith<$Res> get actorUser;

}
/// @nodoc
class _$NotificationModelCopyWithImpl<$Res>
    implements $NotificationModelCopyWith<$Res> {
  _$NotificationModelCopyWithImpl(this._self, this._then);

  final NotificationModel _self;
  final $Res Function(NotificationModel) _then;

/// Create a copy of NotificationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? actorUser = null,Object? targetStoryId = freezed,Object? targetCommentId = freezed,Object? contentPreview = null,Object? timestamp = null,Object? isRead = null,Object? deepLinkData = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationType,actorUser: null == actorUser ? _self.actorUser : actorUser // ignore: cast_nullable_to_non_nullable
as UserModel,targetStoryId: freezed == targetStoryId ? _self.targetStoryId : targetStoryId // ignore: cast_nullable_to_non_nullable
as String?,targetCommentId: freezed == targetCommentId ? _self.targetCommentId : targetCommentId // ignore: cast_nullable_to_non_nullable
as String?,contentPreview: null == contentPreview ? _self.contentPreview : contentPreview // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,deepLinkData: null == deepLinkData ? _self.deepLinkData : deepLinkData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}
/// Create a copy of NotificationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res> get actorUser {
  
  return $UserModelCopyWith<$Res>(_self.actorUser, (value) {
    return _then(_self.copyWith(actorUser: value));
  });
}
}


/// Adds pattern-matching-related methods to [NotificationModel].
extension NotificationModelPatterns on NotificationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationModel value)  $default,){
final _that = this;
switch (_that) {
case _NotificationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationModel value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  NotificationType type, @HiveField(2)  UserModel actorUser, @HiveField(3)  String? targetStoryId, @HiveField(4)  String? targetCommentId, @HiveField(5)  String contentPreview, @HiveField(6)  DateTime timestamp, @HiveField(7)  bool isRead, @HiveField(8)  Map<String, dynamic> deepLinkData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  NotificationType type, @HiveField(2)  UserModel actorUser, @HiveField(3)  String? targetStoryId, @HiveField(4)  String? targetCommentId, @HiveField(5)  String contentPreview, @HiveField(6)  DateTime timestamp, @HiveField(7)  bool isRead, @HiveField(8)  Map<String, dynamic> deepLinkData)  $default,) {final _that = this;
switch (_that) {
case _NotificationModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String id, @HiveField(1)  NotificationType type, @HiveField(2)  UserModel actorUser, @HiveField(3)  String? targetStoryId, @HiveField(4)  String? targetCommentId, @HiveField(5)  String contentPreview, @HiveField(6)  DateTime timestamp, @HiveField(7)  bool isRead, @HiveField(8)  Map<String, dynamic> deepLinkData)?  $default,) {final _that = this;
switch (_that) {
case _NotificationModel() when $default != null:
return $default(_that.id,_that.type,_that.actorUser,_that.targetStoryId,_that.targetCommentId,_that.contentPreview,_that.timestamp,_that.isRead,_that.deepLinkData);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationModel extends NotificationModel {
  const _NotificationModel({@HiveField(0) required this.id, @HiveField(1) required this.type, @HiveField(2) required this.actorUser, @HiveField(3) this.targetStoryId, @HiveField(4) this.targetCommentId, @HiveField(5) required this.contentPreview, @HiveField(6) required this.timestamp, @HiveField(7) this.isRead = false, @HiveField(8) final  Map<String, dynamic> deepLinkData = const {}}): _deepLinkData = deepLinkData,super._();
  factory _NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);

@override@HiveField(0) final  String id;
@override@HiveField(1) final  NotificationType type;
@override@HiveField(2) final  UserModel actorUser;
@override@HiveField(3) final  String? targetStoryId;
@override@HiveField(4) final  String? targetCommentId;
@override@HiveField(5) final  String contentPreview;
@override@HiveField(6) final  DateTime timestamp;
@override@JsonKey()@HiveField(7) final  bool isRead;
 final  Map<String, dynamic> _deepLinkData;
@override@JsonKey()@HiveField(8) Map<String, dynamic> get deepLinkData {
  if (_deepLinkData is EqualUnmodifiableMapView) return _deepLinkData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_deepLinkData);
}


/// Create a copy of NotificationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationModelCopyWith<_NotificationModel> get copyWith => __$NotificationModelCopyWithImpl<_NotificationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.actorUser, actorUser) || other.actorUser == actorUser)&&(identical(other.targetStoryId, targetStoryId) || other.targetStoryId == targetStoryId)&&(identical(other.targetCommentId, targetCommentId) || other.targetCommentId == targetCommentId)&&(identical(other.contentPreview, contentPreview) || other.contentPreview == contentPreview)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&const DeepCollectionEquality().equals(other._deepLinkData, _deepLinkData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,actorUser,targetStoryId,targetCommentId,contentPreview,timestamp,isRead,const DeepCollectionEquality().hash(_deepLinkData));

@override
String toString() {
  return 'NotificationModel(id: $id, type: $type, actorUser: $actorUser, targetStoryId: $targetStoryId, targetCommentId: $targetCommentId, contentPreview: $contentPreview, timestamp: $timestamp, isRead: $isRead, deepLinkData: $deepLinkData)';
}


}

/// @nodoc
abstract mixin class _$NotificationModelCopyWith<$Res> implements $NotificationModelCopyWith<$Res> {
  factory _$NotificationModelCopyWith(_NotificationModel value, $Res Function(_NotificationModel) _then) = __$NotificationModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String id,@HiveField(1) NotificationType type,@HiveField(2) UserModel actorUser,@HiveField(3) String? targetStoryId,@HiveField(4) String? targetCommentId,@HiveField(5) String contentPreview,@HiveField(6) DateTime timestamp,@HiveField(7) bool isRead,@HiveField(8) Map<String, dynamic> deepLinkData
});


@override $UserModelCopyWith<$Res> get actorUser;

}
/// @nodoc
class __$NotificationModelCopyWithImpl<$Res>
    implements _$NotificationModelCopyWith<$Res> {
  __$NotificationModelCopyWithImpl(this._self, this._then);

  final _NotificationModel _self;
  final $Res Function(_NotificationModel) _then;

/// Create a copy of NotificationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? actorUser = null,Object? targetStoryId = freezed,Object? targetCommentId = freezed,Object? contentPreview = null,Object? timestamp = null,Object? isRead = null,Object? deepLinkData = null,}) {
  return _then(_NotificationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationType,actorUser: null == actorUser ? _self.actorUser : actorUser // ignore: cast_nullable_to_non_nullable
as UserModel,targetStoryId: freezed == targetStoryId ? _self.targetStoryId : targetStoryId // ignore: cast_nullable_to_non_nullable
as String?,targetCommentId: freezed == targetCommentId ? _self.targetCommentId : targetCommentId // ignore: cast_nullable_to_non_nullable
as String?,contentPreview: null == contentPreview ? _self.contentPreview : contentPreview // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,deepLinkData: null == deepLinkData ? _self._deepLinkData : deepLinkData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

/// Create a copy of NotificationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res> get actorUser {
  
  return $UserModelCopyWith<$Res>(_self.actorUser, (value) {
    return _then(_self.copyWith(actorUser: value));
  });
}
}

// dart format on
