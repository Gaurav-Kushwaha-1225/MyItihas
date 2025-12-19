// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeedEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedEvent()';
}


}

/// @nodoc
class $FeedEventCopyWith<$Res>  {
$FeedEventCopyWith(FeedEvent _, $Res Function(FeedEvent) __);
}


/// Adds pattern-matching-related methods to [FeedEvent].
extension FeedEventPatterns on FeedEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadFeedEvent value)?  loadFeed,TResult Function( LoadMoreFeedEvent value)?  loadMore,TResult Function( RefreshFeedEvent value)?  refreshFeed,TResult Function( ToggleLikeEvent value)?  toggleLike,TResult Function( ToggleBookmarkEvent value)?  toggleBookmark,TResult Function( AddCommentEvent value)?  addComment,TResult Function( ShareStoryEvent value)?  shareStory,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadFeedEvent() when loadFeed != null:
return loadFeed(_that);case LoadMoreFeedEvent() when loadMore != null:
return loadMore(_that);case RefreshFeedEvent() when refreshFeed != null:
return refreshFeed(_that);case ToggleLikeEvent() when toggleLike != null:
return toggleLike(_that);case ToggleBookmarkEvent() when toggleBookmark != null:
return toggleBookmark(_that);case AddCommentEvent() when addComment != null:
return addComment(_that);case ShareStoryEvent() when shareStory != null:
return shareStory(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadFeedEvent value)  loadFeed,required TResult Function( LoadMoreFeedEvent value)  loadMore,required TResult Function( RefreshFeedEvent value)  refreshFeed,required TResult Function( ToggleLikeEvent value)  toggleLike,required TResult Function( ToggleBookmarkEvent value)  toggleBookmark,required TResult Function( AddCommentEvent value)  addComment,required TResult Function( ShareStoryEvent value)  shareStory,}){
final _that = this;
switch (_that) {
case LoadFeedEvent():
return loadFeed(_that);case LoadMoreFeedEvent():
return loadMore(_that);case RefreshFeedEvent():
return refreshFeed(_that);case ToggleLikeEvent():
return toggleLike(_that);case ToggleBookmarkEvent():
return toggleBookmark(_that);case AddCommentEvent():
return addComment(_that);case ShareStoryEvent():
return shareStory(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadFeedEvent value)?  loadFeed,TResult? Function( LoadMoreFeedEvent value)?  loadMore,TResult? Function( RefreshFeedEvent value)?  refreshFeed,TResult? Function( ToggleLikeEvent value)?  toggleLike,TResult? Function( ToggleBookmarkEvent value)?  toggleBookmark,TResult? Function( AddCommentEvent value)?  addComment,TResult? Function( ShareStoryEvent value)?  shareStory,}){
final _that = this;
switch (_that) {
case LoadFeedEvent() when loadFeed != null:
return loadFeed(_that);case LoadMoreFeedEvent() when loadMore != null:
return loadMore(_that);case RefreshFeedEvent() when refreshFeed != null:
return refreshFeed(_that);case ToggleLikeEvent() when toggleLike != null:
return toggleLike(_that);case ToggleBookmarkEvent() when toggleBookmark != null:
return toggleBookmark(_that);case AddCommentEvent() when addComment != null:
return addComment(_that);case ShareStoryEvent() when shareStory != null:
return shareStory(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadFeed,TResult Function()?  loadMore,TResult Function()?  refreshFeed,TResult Function( String storyId)?  toggleLike,TResult Function( String storyId)?  toggleBookmark,TResult Function( String storyId,  String text,  String? parentCommentId)?  addComment,TResult Function( String storyId,  bool isDirect,  String? recipientId)?  shareStory,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadFeedEvent() when loadFeed != null:
return loadFeed();case LoadMoreFeedEvent() when loadMore != null:
return loadMore();case RefreshFeedEvent() when refreshFeed != null:
return refreshFeed();case ToggleLikeEvent() when toggleLike != null:
return toggleLike(_that.storyId);case ToggleBookmarkEvent() when toggleBookmark != null:
return toggleBookmark(_that.storyId);case AddCommentEvent() when addComment != null:
return addComment(_that.storyId,_that.text,_that.parentCommentId);case ShareStoryEvent() when shareStory != null:
return shareStory(_that.storyId,_that.isDirect,_that.recipientId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadFeed,required TResult Function()  loadMore,required TResult Function()  refreshFeed,required TResult Function( String storyId)  toggleLike,required TResult Function( String storyId)  toggleBookmark,required TResult Function( String storyId,  String text,  String? parentCommentId)  addComment,required TResult Function( String storyId,  bool isDirect,  String? recipientId)  shareStory,}) {final _that = this;
switch (_that) {
case LoadFeedEvent():
return loadFeed();case LoadMoreFeedEvent():
return loadMore();case RefreshFeedEvent():
return refreshFeed();case ToggleLikeEvent():
return toggleLike(_that.storyId);case ToggleBookmarkEvent():
return toggleBookmark(_that.storyId);case AddCommentEvent():
return addComment(_that.storyId,_that.text,_that.parentCommentId);case ShareStoryEvent():
return shareStory(_that.storyId,_that.isDirect,_that.recipientId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadFeed,TResult? Function()?  loadMore,TResult? Function()?  refreshFeed,TResult? Function( String storyId)?  toggleLike,TResult? Function( String storyId)?  toggleBookmark,TResult? Function( String storyId,  String text,  String? parentCommentId)?  addComment,TResult? Function( String storyId,  bool isDirect,  String? recipientId)?  shareStory,}) {final _that = this;
switch (_that) {
case LoadFeedEvent() when loadFeed != null:
return loadFeed();case LoadMoreFeedEvent() when loadMore != null:
return loadMore();case RefreshFeedEvent() when refreshFeed != null:
return refreshFeed();case ToggleLikeEvent() when toggleLike != null:
return toggleLike(_that.storyId);case ToggleBookmarkEvent() when toggleBookmark != null:
return toggleBookmark(_that.storyId);case AddCommentEvent() when addComment != null:
return addComment(_that.storyId,_that.text,_that.parentCommentId);case ShareStoryEvent() when shareStory != null:
return shareStory(_that.storyId,_that.isDirect,_that.recipientId);case _:
  return null;

}
}

}

/// @nodoc


class LoadFeedEvent implements FeedEvent {
  const LoadFeedEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadFeedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedEvent.loadFeed()';
}


}




/// @nodoc


class LoadMoreFeedEvent implements FeedEvent {
  const LoadMoreFeedEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadMoreFeedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedEvent.loadMore()';
}


}




/// @nodoc


class RefreshFeedEvent implements FeedEvent {
  const RefreshFeedEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshFeedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FeedEvent.refreshFeed()';
}


}




/// @nodoc


class ToggleLikeEvent implements FeedEvent {
  const ToggleLikeEvent(this.storyId);
  

 final  String storyId;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToggleLikeEventCopyWith<ToggleLikeEvent> get copyWith => _$ToggleLikeEventCopyWithImpl<ToggleLikeEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleLikeEvent&&(identical(other.storyId, storyId) || other.storyId == storyId));
}


@override
int get hashCode => Object.hash(runtimeType,storyId);

@override
String toString() {
  return 'FeedEvent.toggleLike(storyId: $storyId)';
}


}

/// @nodoc
abstract mixin class $ToggleLikeEventCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory $ToggleLikeEventCopyWith(ToggleLikeEvent value, $Res Function(ToggleLikeEvent) _then) = _$ToggleLikeEventCopyWithImpl;
@useResult
$Res call({
 String storyId
});




}
/// @nodoc
class _$ToggleLikeEventCopyWithImpl<$Res>
    implements $ToggleLikeEventCopyWith<$Res> {
  _$ToggleLikeEventCopyWithImpl(this._self, this._then);

  final ToggleLikeEvent _self;
  final $Res Function(ToggleLikeEvent) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? storyId = null,}) {
  return _then(ToggleLikeEvent(
null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ToggleBookmarkEvent implements FeedEvent {
  const ToggleBookmarkEvent(this.storyId);
  

 final  String storyId;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToggleBookmarkEventCopyWith<ToggleBookmarkEvent> get copyWith => _$ToggleBookmarkEventCopyWithImpl<ToggleBookmarkEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleBookmarkEvent&&(identical(other.storyId, storyId) || other.storyId == storyId));
}


@override
int get hashCode => Object.hash(runtimeType,storyId);

@override
String toString() {
  return 'FeedEvent.toggleBookmark(storyId: $storyId)';
}


}

/// @nodoc
abstract mixin class $ToggleBookmarkEventCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory $ToggleBookmarkEventCopyWith(ToggleBookmarkEvent value, $Res Function(ToggleBookmarkEvent) _then) = _$ToggleBookmarkEventCopyWithImpl;
@useResult
$Res call({
 String storyId
});




}
/// @nodoc
class _$ToggleBookmarkEventCopyWithImpl<$Res>
    implements $ToggleBookmarkEventCopyWith<$Res> {
  _$ToggleBookmarkEventCopyWithImpl(this._self, this._then);

  final ToggleBookmarkEvent _self;
  final $Res Function(ToggleBookmarkEvent) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? storyId = null,}) {
  return _then(ToggleBookmarkEvent(
null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AddCommentEvent implements FeedEvent {
  const AddCommentEvent({required this.storyId, required this.text, this.parentCommentId});
  

 final  String storyId;
 final  String text;
 final  String? parentCommentId;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddCommentEventCopyWith<AddCommentEvent> get copyWith => _$AddCommentEventCopyWithImpl<AddCommentEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddCommentEvent&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.text, text) || other.text == text)&&(identical(other.parentCommentId, parentCommentId) || other.parentCommentId == parentCommentId));
}


@override
int get hashCode => Object.hash(runtimeType,storyId,text,parentCommentId);

@override
String toString() {
  return 'FeedEvent.addComment(storyId: $storyId, text: $text, parentCommentId: $parentCommentId)';
}


}

/// @nodoc
abstract mixin class $AddCommentEventCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory $AddCommentEventCopyWith(AddCommentEvent value, $Res Function(AddCommentEvent) _then) = _$AddCommentEventCopyWithImpl;
@useResult
$Res call({
 String storyId, String text, String? parentCommentId
});




}
/// @nodoc
class _$AddCommentEventCopyWithImpl<$Res>
    implements $AddCommentEventCopyWith<$Res> {
  _$AddCommentEventCopyWithImpl(this._self, this._then);

  final AddCommentEvent _self;
  final $Res Function(AddCommentEvent) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? storyId = null,Object? text = null,Object? parentCommentId = freezed,}) {
  return _then(AddCommentEvent(
storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,parentCommentId: freezed == parentCommentId ? _self.parentCommentId : parentCommentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ShareStoryEvent implements FeedEvent {
  const ShareStoryEvent({required this.storyId, required this.isDirect, this.recipientId});
  

 final  String storyId;
 final  bool isDirect;
 final  String? recipientId;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShareStoryEventCopyWith<ShareStoryEvent> get copyWith => _$ShareStoryEventCopyWithImpl<ShareStoryEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShareStoryEvent&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.isDirect, isDirect) || other.isDirect == isDirect)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId));
}


@override
int get hashCode => Object.hash(runtimeType,storyId,isDirect,recipientId);

@override
String toString() {
  return 'FeedEvent.shareStory(storyId: $storyId, isDirect: $isDirect, recipientId: $recipientId)';
}


}

/// @nodoc
abstract mixin class $ShareStoryEventCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory $ShareStoryEventCopyWith(ShareStoryEvent value, $Res Function(ShareStoryEvent) _then) = _$ShareStoryEventCopyWithImpl;
@useResult
$Res call({
 String storyId, bool isDirect, String? recipientId
});




}
/// @nodoc
class _$ShareStoryEventCopyWithImpl<$Res>
    implements $ShareStoryEventCopyWith<$Res> {
  _$ShareStoryEventCopyWithImpl(this._self, this._then);

  final ShareStoryEvent _self;
  final $Res Function(ShareStoryEvent) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? storyId = null,Object? isDirect = null,Object? recipientId = freezed,}) {
  return _then(ShareStoryEvent(
storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as String,isDirect: null == isDirect ? _self.isDirect : isDirect // ignore: cast_nullable_to_non_nullable
as bool,recipientId: freezed == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
