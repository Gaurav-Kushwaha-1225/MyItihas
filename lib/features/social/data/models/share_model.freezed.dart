// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'share_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShareModel {

@HiveField(0) String get userId;@HiveField(1) String get storyId;@HiveField(2) ShareType get shareType;@HiveField(3) String? get recipientId;@HiveField(4) DateTime get timestamp;
/// Create a copy of ShareModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShareModelCopyWith<ShareModel> get copyWith => _$ShareModelCopyWithImpl<ShareModel>(this as ShareModel, _$identity);

  /// Serializes this ShareModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShareModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.shareType, shareType) || other.shareType == shareType)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,storyId,shareType,recipientId,timestamp);

@override
String toString() {
  return 'ShareModel(userId: $userId, storyId: $storyId, shareType: $shareType, recipientId: $recipientId, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $ShareModelCopyWith<$Res>  {
  factory $ShareModelCopyWith(ShareModel value, $Res Function(ShareModel) _then) = _$ShareModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String userId,@HiveField(1) String storyId,@HiveField(2) ShareType shareType,@HiveField(3) String? recipientId,@HiveField(4) DateTime timestamp
});




}
/// @nodoc
class _$ShareModelCopyWithImpl<$Res>
    implements $ShareModelCopyWith<$Res> {
  _$ShareModelCopyWithImpl(this._self, this._then);

  final ShareModel _self;
  final $Res Function(ShareModel) _then;

/// Create a copy of ShareModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? storyId = null,Object? shareType = null,Object? recipientId = freezed,Object? timestamp = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as String,shareType: null == shareType ? _self.shareType : shareType // ignore: cast_nullable_to_non_nullable
as ShareType,recipientId: freezed == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ShareModel].
extension ShareModelPatterns on ShareModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShareModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShareModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShareModel value)  $default,){
final _that = this;
switch (_that) {
case _ShareModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShareModel value)?  $default,){
final _that = this;
switch (_that) {
case _ShareModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String userId, @HiveField(1)  String storyId, @HiveField(2)  ShareType shareType, @HiveField(3)  String? recipientId, @HiveField(4)  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShareModel() when $default != null:
return $default(_that.userId,_that.storyId,_that.shareType,_that.recipientId,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String userId, @HiveField(1)  String storyId, @HiveField(2)  ShareType shareType, @HiveField(3)  String? recipientId, @HiveField(4)  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _ShareModel():
return $default(_that.userId,_that.storyId,_that.shareType,_that.recipientId,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String userId, @HiveField(1)  String storyId, @HiveField(2)  ShareType shareType, @HiveField(3)  String? recipientId, @HiveField(4)  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _ShareModel() when $default != null:
return $default(_that.userId,_that.storyId,_that.shareType,_that.recipientId,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShareModel extends ShareModel {
  const _ShareModel({@HiveField(0) required this.userId, @HiveField(1) required this.storyId, @HiveField(2) required this.shareType, @HiveField(3) this.recipientId, @HiveField(4) required this.timestamp}): super._();
  factory _ShareModel.fromJson(Map<String, dynamic> json) => _$ShareModelFromJson(json);

@override@HiveField(0) final  String userId;
@override@HiveField(1) final  String storyId;
@override@HiveField(2) final  ShareType shareType;
@override@HiveField(3) final  String? recipientId;
@override@HiveField(4) final  DateTime timestamp;

/// Create a copy of ShareModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShareModelCopyWith<_ShareModel> get copyWith => __$ShareModelCopyWithImpl<_ShareModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShareModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShareModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.shareType, shareType) || other.shareType == shareType)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,storyId,shareType,recipientId,timestamp);

@override
String toString() {
  return 'ShareModel(userId: $userId, storyId: $storyId, shareType: $shareType, recipientId: $recipientId, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$ShareModelCopyWith<$Res> implements $ShareModelCopyWith<$Res> {
  factory _$ShareModelCopyWith(_ShareModel value, $Res Function(_ShareModel) _then) = __$ShareModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String userId,@HiveField(1) String storyId,@HiveField(2) ShareType shareType,@HiveField(3) String? recipientId,@HiveField(4) DateTime timestamp
});




}
/// @nodoc
class __$ShareModelCopyWithImpl<$Res>
    implements _$ShareModelCopyWith<$Res> {
  __$ShareModelCopyWithImpl(this._self, this._then);

  final _ShareModel _self;
  final $Res Function(_ShareModel) _then;

/// Create a copy of ShareModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? storyId = null,Object? shareType = null,Object? recipientId = freezed,Object? timestamp = null,}) {
  return _then(_ShareModel(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as String,shareType: null == shareType ? _self.shareType : shareType // ignore: cast_nullable_to_non_nullable
as ShareType,recipientId: freezed == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
