// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_post_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreatePostState {

 PostType get postType; String get content; String get title; List<File> get mediaFiles; PostVisibility get visibility; bool get isSubmitting; String? get errorMessage; bool get isSuccess; String? get createdPostId;
/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePostStateCopyWith<CreatePostState> get copyWith => _$CreatePostStateCopyWithImpl<CreatePostState>(this as CreatePostState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePostState&&(identical(other.postType, postType) || other.postType == postType)&&(identical(other.content, content) || other.content == content)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.mediaFiles, mediaFiles)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.createdPostId, createdPostId) || other.createdPostId == createdPostId));
}


@override
int get hashCode => Object.hash(runtimeType,postType,content,title,const DeepCollectionEquality().hash(mediaFiles),visibility,isSubmitting,errorMessage,isSuccess,createdPostId);

@override
String toString() {
  return 'CreatePostState(postType: $postType, content: $content, title: $title, mediaFiles: $mediaFiles, visibility: $visibility, isSubmitting: $isSubmitting, errorMessage: $errorMessage, isSuccess: $isSuccess, createdPostId: $createdPostId)';
}


}

/// @nodoc
abstract mixin class $CreatePostStateCopyWith<$Res>  {
  factory $CreatePostStateCopyWith(CreatePostState value, $Res Function(CreatePostState) _then) = _$CreatePostStateCopyWithImpl;
@useResult
$Res call({
 PostType postType, String content, String title, List<File> mediaFiles, PostVisibility visibility, bool isSubmitting, String? errorMessage, bool isSuccess, String? createdPostId
});




}
/// @nodoc
class _$CreatePostStateCopyWithImpl<$Res>
    implements $CreatePostStateCopyWith<$Res> {
  _$CreatePostStateCopyWithImpl(this._self, this._then);

  final CreatePostState _self;
  final $Res Function(CreatePostState) _then;

/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? postType = null,Object? content = null,Object? title = null,Object? mediaFiles = null,Object? visibility = null,Object? isSubmitting = null,Object? errorMessage = freezed,Object? isSuccess = null,Object? createdPostId = freezed,}) {
  return _then(_self.copyWith(
postType: null == postType ? _self.postType : postType // ignore: cast_nullable_to_non_nullable
as PostType,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,mediaFiles: null == mediaFiles ? _self.mediaFiles : mediaFiles // ignore: cast_nullable_to_non_nullable
as List<File>,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as PostVisibility,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,createdPostId: freezed == createdPostId ? _self.createdPostId : createdPostId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreatePostState].
extension CreatePostStatePatterns on CreatePostState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatePostState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatePostState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatePostState value)  $default,){
final _that = this;
switch (_that) {
case _CreatePostState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatePostState value)?  $default,){
final _that = this;
switch (_that) {
case _CreatePostState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PostType postType,  String content,  String title,  List<File> mediaFiles,  PostVisibility visibility,  bool isSubmitting,  String? errorMessage,  bool isSuccess,  String? createdPostId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatePostState() when $default != null:
return $default(_that.postType,_that.content,_that.title,_that.mediaFiles,_that.visibility,_that.isSubmitting,_that.errorMessage,_that.isSuccess,_that.createdPostId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PostType postType,  String content,  String title,  List<File> mediaFiles,  PostVisibility visibility,  bool isSubmitting,  String? errorMessage,  bool isSuccess,  String? createdPostId)  $default,) {final _that = this;
switch (_that) {
case _CreatePostState():
return $default(_that.postType,_that.content,_that.title,_that.mediaFiles,_that.visibility,_that.isSubmitting,_that.errorMessage,_that.isSuccess,_that.createdPostId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PostType postType,  String content,  String title,  List<File> mediaFiles,  PostVisibility visibility,  bool isSubmitting,  String? errorMessage,  bool isSuccess,  String? createdPostId)?  $default,) {final _that = this;
switch (_that) {
case _CreatePostState() when $default != null:
return $default(_that.postType,_that.content,_that.title,_that.mediaFiles,_that.visibility,_that.isSubmitting,_that.errorMessage,_that.isSuccess,_that.createdPostId);case _:
  return null;

}
}

}

/// @nodoc


class _CreatePostState extends CreatePostState {
  const _CreatePostState({this.postType = PostType.text, this.content = '', this.title = '', final  List<File> mediaFiles = const [], this.visibility = PostVisibility.public, this.isSubmitting = false, this.errorMessage, this.isSuccess = false, this.createdPostId}): _mediaFiles = mediaFiles,super._();
  

@override@JsonKey() final  PostType postType;
@override@JsonKey() final  String content;
@override@JsonKey() final  String title;
 final  List<File> _mediaFiles;
@override@JsonKey() List<File> get mediaFiles {
  if (_mediaFiles is EqualUnmodifiableListView) return _mediaFiles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mediaFiles);
}

@override@JsonKey() final  PostVisibility visibility;
@override@JsonKey() final  bool isSubmitting;
@override final  String? errorMessage;
@override@JsonKey() final  bool isSuccess;
@override final  String? createdPostId;

/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatePostStateCopyWith<_CreatePostState> get copyWith => __$CreatePostStateCopyWithImpl<_CreatePostState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePostState&&(identical(other.postType, postType) || other.postType == postType)&&(identical(other.content, content) || other.content == content)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._mediaFiles, _mediaFiles)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess)&&(identical(other.createdPostId, createdPostId) || other.createdPostId == createdPostId));
}


@override
int get hashCode => Object.hash(runtimeType,postType,content,title,const DeepCollectionEquality().hash(_mediaFiles),visibility,isSubmitting,errorMessage,isSuccess,createdPostId);

@override
String toString() {
  return 'CreatePostState(postType: $postType, content: $content, title: $title, mediaFiles: $mediaFiles, visibility: $visibility, isSubmitting: $isSubmitting, errorMessage: $errorMessage, isSuccess: $isSuccess, createdPostId: $createdPostId)';
}


}

/// @nodoc
abstract mixin class _$CreatePostStateCopyWith<$Res> implements $CreatePostStateCopyWith<$Res> {
  factory _$CreatePostStateCopyWith(_CreatePostState value, $Res Function(_CreatePostState) _then) = __$CreatePostStateCopyWithImpl;
@override @useResult
$Res call({
 PostType postType, String content, String title, List<File> mediaFiles, PostVisibility visibility, bool isSubmitting, String? errorMessage, bool isSuccess, String? createdPostId
});




}
/// @nodoc
class __$CreatePostStateCopyWithImpl<$Res>
    implements _$CreatePostStateCopyWith<$Res> {
  __$CreatePostStateCopyWithImpl(this._self, this._then);

  final _CreatePostState _self;
  final $Res Function(_CreatePostState) _then;

/// Create a copy of CreatePostState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? postType = null,Object? content = null,Object? title = null,Object? mediaFiles = null,Object? visibility = null,Object? isSubmitting = null,Object? errorMessage = freezed,Object? isSuccess = null,Object? createdPostId = freezed,}) {
  return _then(_CreatePostState(
postType: null == postType ? _self.postType : postType // ignore: cast_nullable_to_non_nullable
as PostType,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,mediaFiles: null == mediaFiles ? _self._mediaFiles : mediaFiles // ignore: cast_nullable_to_non_nullable
as List<File>,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as PostVisibility,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,createdPostId: freezed == createdPostId ? _self.createdPostId : createdPostId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
