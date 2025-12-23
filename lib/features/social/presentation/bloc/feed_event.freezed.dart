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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadFeedEvent value)?  loadFeed,TResult Function( LoadMoreFeedEvent value)?  loadMore,TResult Function( RefreshFeedEvent value)?  refreshFeed,TResult Function( ChangeFeedTypeEvent value)?  changeFeedType,TResult Function( ToggleLikeEvent value)?  toggleLike,TResult Function( ToggleBookmarkEvent value)?  toggleBookmark,TResult Function( AddCommentEvent value)?  addComment,TResult Function( ShareContentEvent value)?  shareContent,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadFeedEvent() when loadFeed != null:
return loadFeed(_that);case LoadMoreFeedEvent() when loadMore != null:
return loadMore(_that);case RefreshFeedEvent() when refreshFeed != null:
return refreshFeed(_that);case ChangeFeedTypeEvent() when changeFeedType != null:
return changeFeedType(_that);case ToggleLikeEvent() when toggleLike != null:
return toggleLike(_that);case ToggleBookmarkEvent() when toggleBookmark != null:
return toggleBookmark(_that);case AddCommentEvent() when addComment != null:
return addComment(_that);case ShareContentEvent() when shareContent != null:
return shareContent(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadFeedEvent value)  loadFeed,required TResult Function( LoadMoreFeedEvent value)  loadMore,required TResult Function( RefreshFeedEvent value)  refreshFeed,required TResult Function( ChangeFeedTypeEvent value)  changeFeedType,required TResult Function( ToggleLikeEvent value)  toggleLike,required TResult Function( ToggleBookmarkEvent value)  toggleBookmark,required TResult Function( AddCommentEvent value)  addComment,required TResult Function( ShareContentEvent value)  shareContent,}){
final _that = this;
switch (_that) {
case LoadFeedEvent():
return loadFeed(_that);case LoadMoreFeedEvent():
return loadMore(_that);case RefreshFeedEvent():
return refreshFeed(_that);case ChangeFeedTypeEvent():
return changeFeedType(_that);case ToggleLikeEvent():
return toggleLike(_that);case ToggleBookmarkEvent():
return toggleBookmark(_that);case AddCommentEvent():
return addComment(_that);case ShareContentEvent():
return shareContent(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadFeedEvent value)?  loadFeed,TResult? Function( LoadMoreFeedEvent value)?  loadMore,TResult? Function( RefreshFeedEvent value)?  refreshFeed,TResult? Function( ChangeFeedTypeEvent value)?  changeFeedType,TResult? Function( ToggleLikeEvent value)?  toggleLike,TResult? Function( ToggleBookmarkEvent value)?  toggleBookmark,TResult? Function( AddCommentEvent value)?  addComment,TResult? Function( ShareContentEvent value)?  shareContent,}){
final _that = this;
switch (_that) {
case LoadFeedEvent() when loadFeed != null:
return loadFeed(_that);case LoadMoreFeedEvent() when loadMore != null:
return loadMore(_that);case RefreshFeedEvent() when refreshFeed != null:
return refreshFeed(_that);case ChangeFeedTypeEvent() when changeFeedType != null:
return changeFeedType(_that);case ToggleLikeEvent() when toggleLike != null:
return toggleLike(_that);case ToggleBookmarkEvent() when toggleBookmark != null:
return toggleBookmark(_that);case AddCommentEvent() when addComment != null:
return addComment(_that);case ShareContentEvent() when shareContent != null:
return shareContent(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadFeed,TResult Function()?  loadMore,TResult Function()?  refreshFeed,TResult Function( FeedType feedType)?  changeFeedType,TResult Function( String contentId,  ContentType contentType)?  toggleLike,TResult Function( String contentId,  ContentType contentType)?  toggleBookmark,TResult Function( String contentId,  ContentType contentType,  String text,  String? parentCommentId)?  addComment,TResult Function( String contentId,  ContentType contentType,  bool isDirect,  String? recipientId)?  shareContent,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadFeedEvent() when loadFeed != null:
return loadFeed();case LoadMoreFeedEvent() when loadMore != null:
return loadMore();case RefreshFeedEvent() when refreshFeed != null:
return refreshFeed();case ChangeFeedTypeEvent() when changeFeedType != null:
return changeFeedType(_that.feedType);case ToggleLikeEvent() when toggleLike != null:
return toggleLike(_that.contentId,_that.contentType);case ToggleBookmarkEvent() when toggleBookmark != null:
return toggleBookmark(_that.contentId,_that.contentType);case AddCommentEvent() when addComment != null:
return addComment(_that.contentId,_that.contentType,_that.text,_that.parentCommentId);case ShareContentEvent() when shareContent != null:
return shareContent(_that.contentId,_that.contentType,_that.isDirect,_that.recipientId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadFeed,required TResult Function()  loadMore,required TResult Function()  refreshFeed,required TResult Function( FeedType feedType)  changeFeedType,required TResult Function( String contentId,  ContentType contentType)  toggleLike,required TResult Function( String contentId,  ContentType contentType)  toggleBookmark,required TResult Function( String contentId,  ContentType contentType,  String text,  String? parentCommentId)  addComment,required TResult Function( String contentId,  ContentType contentType,  bool isDirect,  String? recipientId)  shareContent,}) {final _that = this;
switch (_that) {
case LoadFeedEvent():
return loadFeed();case LoadMoreFeedEvent():
return loadMore();case RefreshFeedEvent():
return refreshFeed();case ChangeFeedTypeEvent():
return changeFeedType(_that.feedType);case ToggleLikeEvent():
return toggleLike(_that.contentId,_that.contentType);case ToggleBookmarkEvent():
return toggleBookmark(_that.contentId,_that.contentType);case AddCommentEvent():
return addComment(_that.contentId,_that.contentType,_that.text,_that.parentCommentId);case ShareContentEvent():
return shareContent(_that.contentId,_that.contentType,_that.isDirect,_that.recipientId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadFeed,TResult? Function()?  loadMore,TResult? Function()?  refreshFeed,TResult? Function( FeedType feedType)?  changeFeedType,TResult? Function( String contentId,  ContentType contentType)?  toggleLike,TResult? Function( String contentId,  ContentType contentType)?  toggleBookmark,TResult? Function( String contentId,  ContentType contentType,  String text,  String? parentCommentId)?  addComment,TResult? Function( String contentId,  ContentType contentType,  bool isDirect,  String? recipientId)?  shareContent,}) {final _that = this;
switch (_that) {
case LoadFeedEvent() when loadFeed != null:
return loadFeed();case LoadMoreFeedEvent() when loadMore != null:
return loadMore();case RefreshFeedEvent() when refreshFeed != null:
return refreshFeed();case ChangeFeedTypeEvent() when changeFeedType != null:
return changeFeedType(_that.feedType);case ToggleLikeEvent() when toggleLike != null:
return toggleLike(_that.contentId,_that.contentType);case ToggleBookmarkEvent() when toggleBookmark != null:
return toggleBookmark(_that.contentId,_that.contentType);case AddCommentEvent() when addComment != null:
return addComment(_that.contentId,_that.contentType,_that.text,_that.parentCommentId);case ShareContentEvent() when shareContent != null:
return shareContent(_that.contentId,_that.contentType,_that.isDirect,_that.recipientId);case _:
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


class ChangeFeedTypeEvent implements FeedEvent {
  const ChangeFeedTypeEvent(this.feedType);
  

 final  FeedType feedType;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeFeedTypeEventCopyWith<ChangeFeedTypeEvent> get copyWith => _$ChangeFeedTypeEventCopyWithImpl<ChangeFeedTypeEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeFeedTypeEvent&&(identical(other.feedType, feedType) || other.feedType == feedType));
}


@override
int get hashCode => Object.hash(runtimeType,feedType);

@override
String toString() {
  return 'FeedEvent.changeFeedType(feedType: $feedType)';
}


}

/// @nodoc
abstract mixin class $ChangeFeedTypeEventCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory $ChangeFeedTypeEventCopyWith(ChangeFeedTypeEvent value, $Res Function(ChangeFeedTypeEvent) _then) = _$ChangeFeedTypeEventCopyWithImpl;
@useResult
$Res call({
 FeedType feedType
});




}
/// @nodoc
class _$ChangeFeedTypeEventCopyWithImpl<$Res>
    implements $ChangeFeedTypeEventCopyWith<$Res> {
  _$ChangeFeedTypeEventCopyWithImpl(this._self, this._then);

  final ChangeFeedTypeEvent _self;
  final $Res Function(ChangeFeedTypeEvent) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? feedType = null,}) {
  return _then(ChangeFeedTypeEvent(
null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as FeedType,
  ));
}


}

/// @nodoc


class ToggleLikeEvent implements FeedEvent {
  const ToggleLikeEvent({required this.contentId, required this.contentType});
  

 final  String contentId;
 final  ContentType contentType;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToggleLikeEventCopyWith<ToggleLikeEvent> get copyWith => _$ToggleLikeEventCopyWithImpl<ToggleLikeEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleLikeEvent&&(identical(other.contentId, contentId) || other.contentId == contentId)&&(identical(other.contentType, contentType) || other.contentType == contentType));
}


@override
int get hashCode => Object.hash(runtimeType,contentId,contentType);

@override
String toString() {
  return 'FeedEvent.toggleLike(contentId: $contentId, contentType: $contentType)';
}


}

/// @nodoc
abstract mixin class $ToggleLikeEventCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory $ToggleLikeEventCopyWith(ToggleLikeEvent value, $Res Function(ToggleLikeEvent) _then) = _$ToggleLikeEventCopyWithImpl;
@useResult
$Res call({
 String contentId, ContentType contentType
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
@pragma('vm:prefer-inline') $Res call({Object? contentId = null,Object? contentType = null,}) {
  return _then(ToggleLikeEvent(
contentId: null == contentId ? _self.contentId : contentId // ignore: cast_nullable_to_non_nullable
as String,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as ContentType,
  ));
}


}

/// @nodoc


class ToggleBookmarkEvent implements FeedEvent {
  const ToggleBookmarkEvent({required this.contentId, required this.contentType});
  

 final  String contentId;
 final  ContentType contentType;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToggleBookmarkEventCopyWith<ToggleBookmarkEvent> get copyWith => _$ToggleBookmarkEventCopyWithImpl<ToggleBookmarkEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleBookmarkEvent&&(identical(other.contentId, contentId) || other.contentId == contentId)&&(identical(other.contentType, contentType) || other.contentType == contentType));
}


@override
int get hashCode => Object.hash(runtimeType,contentId,contentType);

@override
String toString() {
  return 'FeedEvent.toggleBookmark(contentId: $contentId, contentType: $contentType)';
}


}

/// @nodoc
abstract mixin class $ToggleBookmarkEventCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory $ToggleBookmarkEventCopyWith(ToggleBookmarkEvent value, $Res Function(ToggleBookmarkEvent) _then) = _$ToggleBookmarkEventCopyWithImpl;
@useResult
$Res call({
 String contentId, ContentType contentType
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
@pragma('vm:prefer-inline') $Res call({Object? contentId = null,Object? contentType = null,}) {
  return _then(ToggleBookmarkEvent(
contentId: null == contentId ? _self.contentId : contentId // ignore: cast_nullable_to_non_nullable
as String,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as ContentType,
  ));
}


}

/// @nodoc


class AddCommentEvent implements FeedEvent {
  const AddCommentEvent({required this.contentId, required this.contentType, required this.text, this.parentCommentId});
  

 final  String contentId;
 final  ContentType contentType;
 final  String text;
 final  String? parentCommentId;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddCommentEventCopyWith<AddCommentEvent> get copyWith => _$AddCommentEventCopyWithImpl<AddCommentEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddCommentEvent&&(identical(other.contentId, contentId) || other.contentId == contentId)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.text, text) || other.text == text)&&(identical(other.parentCommentId, parentCommentId) || other.parentCommentId == parentCommentId));
}


@override
int get hashCode => Object.hash(runtimeType,contentId,contentType,text,parentCommentId);

@override
String toString() {
  return 'FeedEvent.addComment(contentId: $contentId, contentType: $contentType, text: $text, parentCommentId: $parentCommentId)';
}


}

/// @nodoc
abstract mixin class $AddCommentEventCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory $AddCommentEventCopyWith(AddCommentEvent value, $Res Function(AddCommentEvent) _then) = _$AddCommentEventCopyWithImpl;
@useResult
$Res call({
 String contentId, ContentType contentType, String text, String? parentCommentId
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
@pragma('vm:prefer-inline') $Res call({Object? contentId = null,Object? contentType = null,Object? text = null,Object? parentCommentId = freezed,}) {
  return _then(AddCommentEvent(
contentId: null == contentId ? _self.contentId : contentId // ignore: cast_nullable_to_non_nullable
as String,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as ContentType,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,parentCommentId: freezed == parentCommentId ? _self.parentCommentId : parentCommentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ShareContentEvent implements FeedEvent {
  const ShareContentEvent({required this.contentId, required this.contentType, required this.isDirect, this.recipientId});
  

 final  String contentId;
 final  ContentType contentType;
 final  bool isDirect;
 final  String? recipientId;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShareContentEventCopyWith<ShareContentEvent> get copyWith => _$ShareContentEventCopyWithImpl<ShareContentEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShareContentEvent&&(identical(other.contentId, contentId) || other.contentId == contentId)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.isDirect, isDirect) || other.isDirect == isDirect)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId));
}


@override
int get hashCode => Object.hash(runtimeType,contentId,contentType,isDirect,recipientId);

@override
String toString() {
  return 'FeedEvent.shareContent(contentId: $contentId, contentType: $contentType, isDirect: $isDirect, recipientId: $recipientId)';
}


}

/// @nodoc
abstract mixin class $ShareContentEventCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory $ShareContentEventCopyWith(ShareContentEvent value, $Res Function(ShareContentEvent) _then) = _$ShareContentEventCopyWithImpl;
@useResult
$Res call({
 String contentId, ContentType contentType, bool isDirect, String? recipientId
});




}
/// @nodoc
class _$ShareContentEventCopyWithImpl<$Res>
    implements $ShareContentEventCopyWith<$Res> {
  _$ShareContentEventCopyWithImpl(this._self, this._then);

  final ShareContentEvent _self;
  final $Res Function(ShareContentEvent) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? contentId = null,Object? contentType = null,Object? isDirect = null,Object? recipientId = freezed,}) {
  return _then(ShareContentEvent(
contentId: null == contentId ? _self.contentId : contentId // ignore: cast_nullable_to_non_nullable
as String,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as ContentType,isDirect: null == isDirect ? _self.isDirect : isDirect // ignore: cast_nullable_to_non_nullable
as bool,recipientId: freezed == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
