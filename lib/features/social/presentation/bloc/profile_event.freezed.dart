// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileEvent {

 String get userId;
/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileEventCopyWith<ProfileEvent> get copyWith => _$ProfileEventCopyWithImpl<ProfileEvent>(this as ProfileEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEvent&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'ProfileEvent(userId: $userId)';
}


}

/// @nodoc
abstract mixin class $ProfileEventCopyWith<$Res>  {
  factory $ProfileEventCopyWith(ProfileEvent value, $Res Function(ProfileEvent) _then) = _$ProfileEventCopyWithImpl;
@useResult
$Res call({
 String userId
});




}
/// @nodoc
class _$ProfileEventCopyWithImpl<$Res>
    implements $ProfileEventCopyWith<$Res> {
  _$ProfileEventCopyWithImpl(this._self, this._then);

  final ProfileEvent _self;
  final $Res Function(ProfileEvent) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileEvent].
extension ProfileEventPatterns on ProfileEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadProfileEvent value)?  loadProfile,TResult Function( ToggleFollowEvent value)?  toggleFollow,TResult Function( LoadFollowersEvent value)?  loadFollowers,TResult Function( LoadFollowingEvent value)?  loadFollowing,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadProfileEvent() when loadProfile != null:
return loadProfile(_that);case ToggleFollowEvent() when toggleFollow != null:
return toggleFollow(_that);case LoadFollowersEvent() when loadFollowers != null:
return loadFollowers(_that);case LoadFollowingEvent() when loadFollowing != null:
return loadFollowing(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadProfileEvent value)  loadProfile,required TResult Function( ToggleFollowEvent value)  toggleFollow,required TResult Function( LoadFollowersEvent value)  loadFollowers,required TResult Function( LoadFollowingEvent value)  loadFollowing,}){
final _that = this;
switch (_that) {
case LoadProfileEvent():
return loadProfile(_that);case ToggleFollowEvent():
return toggleFollow(_that);case LoadFollowersEvent():
return loadFollowers(_that);case LoadFollowingEvent():
return loadFollowing(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadProfileEvent value)?  loadProfile,TResult? Function( ToggleFollowEvent value)?  toggleFollow,TResult? Function( LoadFollowersEvent value)?  loadFollowers,TResult? Function( LoadFollowingEvent value)?  loadFollowing,}){
final _that = this;
switch (_that) {
case LoadProfileEvent() when loadProfile != null:
return loadProfile(_that);case ToggleFollowEvent() when toggleFollow != null:
return toggleFollow(_that);case LoadFollowersEvent() when loadFollowers != null:
return loadFollowers(_that);case LoadFollowingEvent() when loadFollowing != null:
return loadFollowing(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String userId)?  loadProfile,TResult Function( String userId)?  toggleFollow,TResult Function( String userId)?  loadFollowers,TResult Function( String userId)?  loadFollowing,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadProfileEvent() when loadProfile != null:
return loadProfile(_that.userId);case ToggleFollowEvent() when toggleFollow != null:
return toggleFollow(_that.userId);case LoadFollowersEvent() when loadFollowers != null:
return loadFollowers(_that.userId);case LoadFollowingEvent() when loadFollowing != null:
return loadFollowing(_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String userId)  loadProfile,required TResult Function( String userId)  toggleFollow,required TResult Function( String userId)  loadFollowers,required TResult Function( String userId)  loadFollowing,}) {final _that = this;
switch (_that) {
case LoadProfileEvent():
return loadProfile(_that.userId);case ToggleFollowEvent():
return toggleFollow(_that.userId);case LoadFollowersEvent():
return loadFollowers(_that.userId);case LoadFollowingEvent():
return loadFollowing(_that.userId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String userId)?  loadProfile,TResult? Function( String userId)?  toggleFollow,TResult? Function( String userId)?  loadFollowers,TResult? Function( String userId)?  loadFollowing,}) {final _that = this;
switch (_that) {
case LoadProfileEvent() when loadProfile != null:
return loadProfile(_that.userId);case ToggleFollowEvent() when toggleFollow != null:
return toggleFollow(_that.userId);case LoadFollowersEvent() when loadFollowers != null:
return loadFollowers(_that.userId);case LoadFollowingEvent() when loadFollowing != null:
return loadFollowing(_that.userId);case _:
  return null;

}
}

}

/// @nodoc


class LoadProfileEvent implements ProfileEvent {
  const LoadProfileEvent(this.userId);
  

@override final  String userId;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadProfileEventCopyWith<LoadProfileEvent> get copyWith => _$LoadProfileEventCopyWithImpl<LoadProfileEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadProfileEvent&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'ProfileEvent.loadProfile(userId: $userId)';
}


}

/// @nodoc
abstract mixin class $LoadProfileEventCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $LoadProfileEventCopyWith(LoadProfileEvent value, $Res Function(LoadProfileEvent) _then) = _$LoadProfileEventCopyWithImpl;
@override @useResult
$Res call({
 String userId
});




}
/// @nodoc
class _$LoadProfileEventCopyWithImpl<$Res>
    implements $LoadProfileEventCopyWith<$Res> {
  _$LoadProfileEventCopyWithImpl(this._self, this._then);

  final LoadProfileEvent _self;
  final $Res Function(LoadProfileEvent) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,}) {
  return _then(LoadProfileEvent(
null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ToggleFollowEvent implements ProfileEvent {
  const ToggleFollowEvent(this.userId);
  

@override final  String userId;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToggleFollowEventCopyWith<ToggleFollowEvent> get copyWith => _$ToggleFollowEventCopyWithImpl<ToggleFollowEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleFollowEvent&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'ProfileEvent.toggleFollow(userId: $userId)';
}


}

/// @nodoc
abstract mixin class $ToggleFollowEventCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $ToggleFollowEventCopyWith(ToggleFollowEvent value, $Res Function(ToggleFollowEvent) _then) = _$ToggleFollowEventCopyWithImpl;
@override @useResult
$Res call({
 String userId
});




}
/// @nodoc
class _$ToggleFollowEventCopyWithImpl<$Res>
    implements $ToggleFollowEventCopyWith<$Res> {
  _$ToggleFollowEventCopyWithImpl(this._self, this._then);

  final ToggleFollowEvent _self;
  final $Res Function(ToggleFollowEvent) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,}) {
  return _then(ToggleFollowEvent(
null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LoadFollowersEvent implements ProfileEvent {
  const LoadFollowersEvent(this.userId);
  

@override final  String userId;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadFollowersEventCopyWith<LoadFollowersEvent> get copyWith => _$LoadFollowersEventCopyWithImpl<LoadFollowersEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadFollowersEvent&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'ProfileEvent.loadFollowers(userId: $userId)';
}


}

/// @nodoc
abstract mixin class $LoadFollowersEventCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $LoadFollowersEventCopyWith(LoadFollowersEvent value, $Res Function(LoadFollowersEvent) _then) = _$LoadFollowersEventCopyWithImpl;
@override @useResult
$Res call({
 String userId
});




}
/// @nodoc
class _$LoadFollowersEventCopyWithImpl<$Res>
    implements $LoadFollowersEventCopyWith<$Res> {
  _$LoadFollowersEventCopyWithImpl(this._self, this._then);

  final LoadFollowersEvent _self;
  final $Res Function(LoadFollowersEvent) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,}) {
  return _then(LoadFollowersEvent(
null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LoadFollowingEvent implements ProfileEvent {
  const LoadFollowingEvent(this.userId);
  

@override final  String userId;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadFollowingEventCopyWith<LoadFollowingEvent> get copyWith => _$LoadFollowingEventCopyWithImpl<LoadFollowingEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadFollowingEvent&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'ProfileEvent.loadFollowing(userId: $userId)';
}


}

/// @nodoc
abstract mixin class $LoadFollowingEventCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $LoadFollowingEventCopyWith(LoadFollowingEvent value, $Res Function(LoadFollowingEvent) _then) = _$LoadFollowingEventCopyWithImpl;
@override @useResult
$Res call({
 String userId
});




}
/// @nodoc
class _$LoadFollowingEventCopyWithImpl<$Res>
    implements $LoadFollowingEventCopyWith<$Res> {
  _$LoadFollowingEventCopyWithImpl(this._self, this._then);

  final LoadFollowingEvent _self;
  final $Res Function(LoadFollowingEvent) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,}) {
  return _then(LoadFollowingEvent(
null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
