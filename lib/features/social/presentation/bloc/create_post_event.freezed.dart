// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_post_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreatePostEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePostEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreatePostEvent()';
}


}

/// @nodoc
class $CreatePostEventCopyWith<$Res>  {
$CreatePostEventCopyWith(CreatePostEvent _, $Res Function(CreatePostEvent) __);
}


/// Adds pattern-matching-related methods to [CreatePostEvent].
extension CreatePostEventPatterns on CreatePostEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InitializeCreatePostEvent value)?  initialize,TResult Function( SelectPostTypeEvent value)?  selectType,TResult Function( UpdateContentEvent value)?  updateContent,TResult Function( UpdateTitleEvent value)?  updateTitle,TResult Function( AddMediaEvent value)?  addMedia,TResult Function( RemoveMediaEvent value)?  removeMedia,TResult Function( ChangeVisibilityEvent value)?  changeVisibility,TResult Function( SubmitPostEvent value)?  submit,TResult Function( ResetCreatePostEvent value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InitializeCreatePostEvent() when initialize != null:
return initialize(_that);case SelectPostTypeEvent() when selectType != null:
return selectType(_that);case UpdateContentEvent() when updateContent != null:
return updateContent(_that);case UpdateTitleEvent() when updateTitle != null:
return updateTitle(_that);case AddMediaEvent() when addMedia != null:
return addMedia(_that);case RemoveMediaEvent() when removeMedia != null:
return removeMedia(_that);case ChangeVisibilityEvent() when changeVisibility != null:
return changeVisibility(_that);case SubmitPostEvent() when submit != null:
return submit(_that);case ResetCreatePostEvent() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InitializeCreatePostEvent value)  initialize,required TResult Function( SelectPostTypeEvent value)  selectType,required TResult Function( UpdateContentEvent value)  updateContent,required TResult Function( UpdateTitleEvent value)  updateTitle,required TResult Function( AddMediaEvent value)  addMedia,required TResult Function( RemoveMediaEvent value)  removeMedia,required TResult Function( ChangeVisibilityEvent value)  changeVisibility,required TResult Function( SubmitPostEvent value)  submit,required TResult Function( ResetCreatePostEvent value)  reset,}){
final _that = this;
switch (_that) {
case InitializeCreatePostEvent():
return initialize(_that);case SelectPostTypeEvent():
return selectType(_that);case UpdateContentEvent():
return updateContent(_that);case UpdateTitleEvent():
return updateTitle(_that);case AddMediaEvent():
return addMedia(_that);case RemoveMediaEvent():
return removeMedia(_that);case ChangeVisibilityEvent():
return changeVisibility(_that);case SubmitPostEvent():
return submit(_that);case ResetCreatePostEvent():
return reset(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InitializeCreatePostEvent value)?  initialize,TResult? Function( SelectPostTypeEvent value)?  selectType,TResult? Function( UpdateContentEvent value)?  updateContent,TResult? Function( UpdateTitleEvent value)?  updateTitle,TResult? Function( AddMediaEvent value)?  addMedia,TResult? Function( RemoveMediaEvent value)?  removeMedia,TResult? Function( ChangeVisibilityEvent value)?  changeVisibility,TResult? Function( SubmitPostEvent value)?  submit,TResult? Function( ResetCreatePostEvent value)?  reset,}){
final _that = this;
switch (_that) {
case InitializeCreatePostEvent() when initialize != null:
return initialize(_that);case SelectPostTypeEvent() when selectType != null:
return selectType(_that);case UpdateContentEvent() when updateContent != null:
return updateContent(_that);case UpdateTitleEvent() when updateTitle != null:
return updateTitle(_that);case AddMediaEvent() when addMedia != null:
return addMedia(_that);case RemoveMediaEvent() when removeMedia != null:
return removeMedia(_that);case ChangeVisibilityEvent() when changeVisibility != null:
return changeVisibility(_that);case SubmitPostEvent() when submit != null:
return submit(_that);case ResetCreatePostEvent() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initialize,TResult Function( PostType type)?  selectType,TResult Function( String content)?  updateContent,TResult Function( String title)?  updateTitle,TResult Function( List<File> files)?  addMedia,TResult Function( int index)?  removeMedia,TResult Function( PostVisibility visibility)?  changeVisibility,TResult Function()?  submit,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InitializeCreatePostEvent() when initialize != null:
return initialize();case SelectPostTypeEvent() when selectType != null:
return selectType(_that.type);case UpdateContentEvent() when updateContent != null:
return updateContent(_that.content);case UpdateTitleEvent() when updateTitle != null:
return updateTitle(_that.title);case AddMediaEvent() when addMedia != null:
return addMedia(_that.files);case RemoveMediaEvent() when removeMedia != null:
return removeMedia(_that.index);case ChangeVisibilityEvent() when changeVisibility != null:
return changeVisibility(_that.visibility);case SubmitPostEvent() when submit != null:
return submit();case ResetCreatePostEvent() when reset != null:
return reset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initialize,required TResult Function( PostType type)  selectType,required TResult Function( String content)  updateContent,required TResult Function( String title)  updateTitle,required TResult Function( List<File> files)  addMedia,required TResult Function( int index)  removeMedia,required TResult Function( PostVisibility visibility)  changeVisibility,required TResult Function()  submit,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case InitializeCreatePostEvent():
return initialize();case SelectPostTypeEvent():
return selectType(_that.type);case UpdateContentEvent():
return updateContent(_that.content);case UpdateTitleEvent():
return updateTitle(_that.title);case AddMediaEvent():
return addMedia(_that.files);case RemoveMediaEvent():
return removeMedia(_that.index);case ChangeVisibilityEvent():
return changeVisibility(_that.visibility);case SubmitPostEvent():
return submit();case ResetCreatePostEvent():
return reset();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initialize,TResult? Function( PostType type)?  selectType,TResult? Function( String content)?  updateContent,TResult? Function( String title)?  updateTitle,TResult? Function( List<File> files)?  addMedia,TResult? Function( int index)?  removeMedia,TResult? Function( PostVisibility visibility)?  changeVisibility,TResult? Function()?  submit,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case InitializeCreatePostEvent() when initialize != null:
return initialize();case SelectPostTypeEvent() when selectType != null:
return selectType(_that.type);case UpdateContentEvent() when updateContent != null:
return updateContent(_that.content);case UpdateTitleEvent() when updateTitle != null:
return updateTitle(_that.title);case AddMediaEvent() when addMedia != null:
return addMedia(_that.files);case RemoveMediaEvent() when removeMedia != null:
return removeMedia(_that.index);case ChangeVisibilityEvent() when changeVisibility != null:
return changeVisibility(_that.visibility);case SubmitPostEvent() when submit != null:
return submit();case ResetCreatePostEvent() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class InitializeCreatePostEvent implements CreatePostEvent {
  const InitializeCreatePostEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitializeCreatePostEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreatePostEvent.initialize()';
}


}




/// @nodoc


class SelectPostTypeEvent implements CreatePostEvent {
  const SelectPostTypeEvent(this.type);
  

 final  PostType type;

/// Create a copy of CreatePostEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectPostTypeEventCopyWith<SelectPostTypeEvent> get copyWith => _$SelectPostTypeEventCopyWithImpl<SelectPostTypeEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectPostTypeEvent&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'CreatePostEvent.selectType(type: $type)';
}


}

/// @nodoc
abstract mixin class $SelectPostTypeEventCopyWith<$Res> implements $CreatePostEventCopyWith<$Res> {
  factory $SelectPostTypeEventCopyWith(SelectPostTypeEvent value, $Res Function(SelectPostTypeEvent) _then) = _$SelectPostTypeEventCopyWithImpl;
@useResult
$Res call({
 PostType type
});




}
/// @nodoc
class _$SelectPostTypeEventCopyWithImpl<$Res>
    implements $SelectPostTypeEventCopyWith<$Res> {
  _$SelectPostTypeEventCopyWithImpl(this._self, this._then);

  final SelectPostTypeEvent _self;
  final $Res Function(SelectPostTypeEvent) _then;

/// Create a copy of CreatePostEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(SelectPostTypeEvent(
null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PostType,
  ));
}


}

/// @nodoc


class UpdateContentEvent implements CreatePostEvent {
  const UpdateContentEvent(this.content);
  

 final  String content;

/// Create a copy of CreatePostEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateContentEventCopyWith<UpdateContentEvent> get copyWith => _$UpdateContentEventCopyWithImpl<UpdateContentEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateContentEvent&&(identical(other.content, content) || other.content == content));
}


@override
int get hashCode => Object.hash(runtimeType,content);

@override
String toString() {
  return 'CreatePostEvent.updateContent(content: $content)';
}


}

/// @nodoc
abstract mixin class $UpdateContentEventCopyWith<$Res> implements $CreatePostEventCopyWith<$Res> {
  factory $UpdateContentEventCopyWith(UpdateContentEvent value, $Res Function(UpdateContentEvent) _then) = _$UpdateContentEventCopyWithImpl;
@useResult
$Res call({
 String content
});




}
/// @nodoc
class _$UpdateContentEventCopyWithImpl<$Res>
    implements $UpdateContentEventCopyWith<$Res> {
  _$UpdateContentEventCopyWithImpl(this._self, this._then);

  final UpdateContentEvent _self;
  final $Res Function(UpdateContentEvent) _then;

/// Create a copy of CreatePostEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? content = null,}) {
  return _then(UpdateContentEvent(
null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UpdateTitleEvent implements CreatePostEvent {
  const UpdateTitleEvent(this.title);
  

 final  String title;

/// Create a copy of CreatePostEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateTitleEventCopyWith<UpdateTitleEvent> get copyWith => _$UpdateTitleEventCopyWithImpl<UpdateTitleEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateTitleEvent&&(identical(other.title, title) || other.title == title));
}


@override
int get hashCode => Object.hash(runtimeType,title);

@override
String toString() {
  return 'CreatePostEvent.updateTitle(title: $title)';
}


}

/// @nodoc
abstract mixin class $UpdateTitleEventCopyWith<$Res> implements $CreatePostEventCopyWith<$Res> {
  factory $UpdateTitleEventCopyWith(UpdateTitleEvent value, $Res Function(UpdateTitleEvent) _then) = _$UpdateTitleEventCopyWithImpl;
@useResult
$Res call({
 String title
});




}
/// @nodoc
class _$UpdateTitleEventCopyWithImpl<$Res>
    implements $UpdateTitleEventCopyWith<$Res> {
  _$UpdateTitleEventCopyWithImpl(this._self, this._then);

  final UpdateTitleEvent _self;
  final $Res Function(UpdateTitleEvent) _then;

/// Create a copy of CreatePostEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? title = null,}) {
  return _then(UpdateTitleEvent(
null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AddMediaEvent implements CreatePostEvent {
  const AddMediaEvent(final  List<File> files): _files = files;
  

 final  List<File> _files;
 List<File> get files {
  if (_files is EqualUnmodifiableListView) return _files;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_files);
}


/// Create a copy of CreatePostEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddMediaEventCopyWith<AddMediaEvent> get copyWith => _$AddMediaEventCopyWithImpl<AddMediaEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddMediaEvent&&const DeepCollectionEquality().equals(other._files, _files));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_files));

@override
String toString() {
  return 'CreatePostEvent.addMedia(files: $files)';
}


}

/// @nodoc
abstract mixin class $AddMediaEventCopyWith<$Res> implements $CreatePostEventCopyWith<$Res> {
  factory $AddMediaEventCopyWith(AddMediaEvent value, $Res Function(AddMediaEvent) _then) = _$AddMediaEventCopyWithImpl;
@useResult
$Res call({
 List<File> files
});




}
/// @nodoc
class _$AddMediaEventCopyWithImpl<$Res>
    implements $AddMediaEventCopyWith<$Res> {
  _$AddMediaEventCopyWithImpl(this._self, this._then);

  final AddMediaEvent _self;
  final $Res Function(AddMediaEvent) _then;

/// Create a copy of CreatePostEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? files = null,}) {
  return _then(AddMediaEvent(
null == files ? _self._files : files // ignore: cast_nullable_to_non_nullable
as List<File>,
  ));
}


}

/// @nodoc


class RemoveMediaEvent implements CreatePostEvent {
  const RemoveMediaEvent(this.index);
  

 final  int index;

/// Create a copy of CreatePostEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoveMediaEventCopyWith<RemoveMediaEvent> get copyWith => _$RemoveMediaEventCopyWithImpl<RemoveMediaEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoveMediaEvent&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'CreatePostEvent.removeMedia(index: $index)';
}


}

/// @nodoc
abstract mixin class $RemoveMediaEventCopyWith<$Res> implements $CreatePostEventCopyWith<$Res> {
  factory $RemoveMediaEventCopyWith(RemoveMediaEvent value, $Res Function(RemoveMediaEvent) _then) = _$RemoveMediaEventCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class _$RemoveMediaEventCopyWithImpl<$Res>
    implements $RemoveMediaEventCopyWith<$Res> {
  _$RemoveMediaEventCopyWithImpl(this._self, this._then);

  final RemoveMediaEvent _self;
  final $Res Function(RemoveMediaEvent) _then;

/// Create a copy of CreatePostEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(RemoveMediaEvent(
null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ChangeVisibilityEvent implements CreatePostEvent {
  const ChangeVisibilityEvent(this.visibility);
  

 final  PostVisibility visibility;

/// Create a copy of CreatePostEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeVisibilityEventCopyWith<ChangeVisibilityEvent> get copyWith => _$ChangeVisibilityEventCopyWithImpl<ChangeVisibilityEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeVisibilityEvent&&(identical(other.visibility, visibility) || other.visibility == visibility));
}


@override
int get hashCode => Object.hash(runtimeType,visibility);

@override
String toString() {
  return 'CreatePostEvent.changeVisibility(visibility: $visibility)';
}


}

/// @nodoc
abstract mixin class $ChangeVisibilityEventCopyWith<$Res> implements $CreatePostEventCopyWith<$Res> {
  factory $ChangeVisibilityEventCopyWith(ChangeVisibilityEvent value, $Res Function(ChangeVisibilityEvent) _then) = _$ChangeVisibilityEventCopyWithImpl;
@useResult
$Res call({
 PostVisibility visibility
});




}
/// @nodoc
class _$ChangeVisibilityEventCopyWithImpl<$Res>
    implements $ChangeVisibilityEventCopyWith<$Res> {
  _$ChangeVisibilityEventCopyWithImpl(this._self, this._then);

  final ChangeVisibilityEvent _self;
  final $Res Function(ChangeVisibilityEvent) _then;

/// Create a copy of CreatePostEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? visibility = null,}) {
  return _then(ChangeVisibilityEvent(
null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as PostVisibility,
  ));
}


}

/// @nodoc


class SubmitPostEvent implements CreatePostEvent {
  const SubmitPostEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitPostEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreatePostEvent.submit()';
}


}




/// @nodoc


class ResetCreatePostEvent implements CreatePostEvent {
  const ResetCreatePostEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetCreatePostEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreatePostEvent.reset()';
}


}




// dart format on
