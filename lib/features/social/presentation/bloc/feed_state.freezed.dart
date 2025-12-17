// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeedState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedState()';
}


}

/// @nodoc
class $FeedStateCopyWith<$Res>  {
$FeedStateCopyWith(FeedState _, $Res Function(FeedState) __);
}


/// Adds pattern-matching-related methods to [FeedState].
extension FeedStatePatterns on FeedState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FeedInitial value)?  initial,TResult Function( FeedLoading value)?  loading,TResult Function( FeedLoaded value)?  loaded,TResult Function( FeedRefreshing value)?  refreshing,TResult Function( FeedError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FeedInitial() when initial != null:
return initial(_that);case FeedLoading() when loading != null:
return loading(_that);case FeedLoaded() when loaded != null:
return loaded(_that);case FeedRefreshing() when refreshing != null:
return refreshing(_that);case FeedError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FeedInitial value)  initial,required TResult Function( FeedLoading value)  loading,required TResult Function( FeedLoaded value)  loaded,required TResult Function( FeedRefreshing value)  refreshing,required TResult Function( FeedError value)  error,}){
final _that = this;
switch (_that) {
case FeedInitial():
return initial(_that);case FeedLoading():
return loading(_that);case FeedLoaded():
return loaded(_that);case FeedRefreshing():
return refreshing(_that);case FeedError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FeedInitial value)?  initial,TResult? Function( FeedLoading value)?  loading,TResult? Function( FeedLoaded value)?  loaded,TResult? Function( FeedRefreshing value)?  refreshing,TResult? Function( FeedError value)?  error,}){
final _that = this;
switch (_that) {
case FeedInitial() when initial != null:
return initial(_that);case FeedLoading() when loading != null:
return loading(_that);case FeedLoaded() when loaded != null:
return loaded(_that);case FeedRefreshing() when refreshing != null:
return refreshing(_that);case FeedError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Story> stories,  User currentUser,  bool hasMore,  bool isLoadingMore)?  loaded,TResult Function( List<Story> stories,  User currentUser,  bool hasMore)?  refreshing,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FeedInitial() when initial != null:
return initial();case FeedLoading() when loading != null:
return loading();case FeedLoaded() when loaded != null:
return loaded(_that.stories,_that.currentUser,_that.hasMore,_that.isLoadingMore);case FeedRefreshing() when refreshing != null:
return refreshing(_that.stories,_that.currentUser,_that.hasMore);case FeedError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Story> stories,  User currentUser,  bool hasMore,  bool isLoadingMore)  loaded,required TResult Function( List<Story> stories,  User currentUser,  bool hasMore)  refreshing,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case FeedInitial():
return initial();case FeedLoading():
return loading();case FeedLoaded():
return loaded(_that.stories,_that.currentUser,_that.hasMore,_that.isLoadingMore);case FeedRefreshing():
return refreshing(_that.stories,_that.currentUser,_that.hasMore);case FeedError():
return error(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Story> stories,  User currentUser,  bool hasMore,  bool isLoadingMore)?  loaded,TResult? Function( List<Story> stories,  User currentUser,  bool hasMore)?  refreshing,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case FeedInitial() when initial != null:
return initial();case FeedLoading() when loading != null:
return loading();case FeedLoaded() when loaded != null:
return loaded(_that.stories,_that.currentUser,_that.hasMore,_that.isLoadingMore);case FeedRefreshing() when refreshing != null:
return refreshing(_that.stories,_that.currentUser,_that.hasMore);case FeedError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class FeedInitial extends FeedState {
  const FeedInitial(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedState.initial()';
}


}




/// @nodoc


class FeedLoading extends FeedState {
  const FeedLoading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedState.loading()';
}


}




/// @nodoc


class FeedLoaded extends FeedState {
  const FeedLoaded({required final  List<Story> stories, required this.currentUser, required this.hasMore, this.isLoadingMore = false}): _stories = stories,super._();
  

 final  List<Story> _stories;
 List<Story> get stories {
  if (_stories is EqualUnmodifiableListView) return _stories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stories);
}

 final  User currentUser;
 final  bool hasMore;
@JsonKey() final  bool isLoadingMore;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedLoadedCopyWith<FeedLoaded> get copyWith => _$FeedLoadedCopyWithImpl<FeedLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedLoaded&&const DeepCollectionEquality().equals(other._stories, _stories)&&(identical(other.currentUser, currentUser) || other.currentUser == currentUser)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_stories),currentUser,hasMore,isLoadingMore);

@override
String toString() {
  return 'FeedState.loaded(stories: $stories, currentUser: $currentUser, hasMore: $hasMore, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class $FeedLoadedCopyWith<$Res> implements $FeedStateCopyWith<$Res> {
  factory $FeedLoadedCopyWith(FeedLoaded value, $Res Function(FeedLoaded) _then) = _$FeedLoadedCopyWithImpl;
@useResult
$Res call({
 List<Story> stories, User currentUser, bool hasMore, bool isLoadingMore
});


$UserCopyWith<$Res> get currentUser;

}
/// @nodoc
class _$FeedLoadedCopyWithImpl<$Res>
    implements $FeedLoadedCopyWith<$Res> {
  _$FeedLoadedCopyWithImpl(this._self, this._then);

  final FeedLoaded _self;
  final $Res Function(FeedLoaded) _then;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? stories = null,Object? currentUser = null,Object? hasMore = null,Object? isLoadingMore = null,}) {
  return _then(FeedLoaded(
stories: null == stories ? _self._stories : stories // ignore: cast_nullable_to_non_nullable
as List<Story>,currentUser: null == currentUser ? _self.currentUser : currentUser // ignore: cast_nullable_to_non_nullable
as User,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get currentUser {
  
  return $UserCopyWith<$Res>(_self.currentUser, (value) {
    return _then(_self.copyWith(currentUser: value));
  });
}
}

/// @nodoc


class FeedRefreshing extends FeedState {
  const FeedRefreshing({required final  List<Story> stories, required this.currentUser, required this.hasMore}): _stories = stories,super._();
  

 final  List<Story> _stories;
 List<Story> get stories {
  if (_stories is EqualUnmodifiableListView) return _stories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stories);
}

 final  User currentUser;
 final  bool hasMore;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedRefreshingCopyWith<FeedRefreshing> get copyWith => _$FeedRefreshingCopyWithImpl<FeedRefreshing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedRefreshing&&const DeepCollectionEquality().equals(other._stories, _stories)&&(identical(other.currentUser, currentUser) || other.currentUser == currentUser)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_stories),currentUser,hasMore);

@override
String toString() {
  return 'FeedState.refreshing(stories: $stories, currentUser: $currentUser, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $FeedRefreshingCopyWith<$Res> implements $FeedStateCopyWith<$Res> {
  factory $FeedRefreshingCopyWith(FeedRefreshing value, $Res Function(FeedRefreshing) _then) = _$FeedRefreshingCopyWithImpl;
@useResult
$Res call({
 List<Story> stories, User currentUser, bool hasMore
});


$UserCopyWith<$Res> get currentUser;

}
/// @nodoc
class _$FeedRefreshingCopyWithImpl<$Res>
    implements $FeedRefreshingCopyWith<$Res> {
  _$FeedRefreshingCopyWithImpl(this._self, this._then);

  final FeedRefreshing _self;
  final $Res Function(FeedRefreshing) _then;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? stories = null,Object? currentUser = null,Object? hasMore = null,}) {
  return _then(FeedRefreshing(
stories: null == stories ? _self._stories : stories // ignore: cast_nullable_to_non_nullable
as List<Story>,currentUser: null == currentUser ? _self.currentUser : currentUser // ignore: cast_nullable_to_non_nullable
as User,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get currentUser {
  
  return $UserCopyWith<$Res>(_self.currentUser, (value) {
    return _then(_self.copyWith(currentUser: value));
  });
}
}

/// @nodoc


class FeedError extends FeedState {
  const FeedError(this.message): super._();
  

 final  String message;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedErrorCopyWith<FeedError> get copyWith => _$FeedErrorCopyWithImpl<FeedError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'FeedState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $FeedErrorCopyWith<$Res> implements $FeedStateCopyWith<$Res> {
  factory $FeedErrorCopyWith(FeedError value, $Res Function(FeedError) _then) = _$FeedErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$FeedErrorCopyWithImpl<$Res>
    implements $FeedErrorCopyWith<$Res> {
  _$FeedErrorCopyWithImpl(this._self, this._then);

  final FeedError _self;
  final $Res Function(FeedError) _then;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(FeedError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
