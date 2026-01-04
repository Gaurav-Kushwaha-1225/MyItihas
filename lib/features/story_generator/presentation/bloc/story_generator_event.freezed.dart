// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_generator_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StoryGeneratorEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoryGeneratorEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StoryGeneratorEvent()';
}


}

/// @nodoc
class $StoryGeneratorEventCopyWith<$Res>  {
$StoryGeneratorEventCopyWith(StoryGeneratorEvent _, $Res Function(StoryGeneratorEvent) __);
}


/// Adds pattern-matching-related methods to [StoryGeneratorEvent].
extension StoryGeneratorEventPatterns on StoryGeneratorEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initialize value)?  initialize,TResult Function( _TogglePromptType value)?  togglePromptType,TResult Function( _SelectOption value)?  selectOption,TResult Function( _UpdateRawPrompt value)?  updateRawPrompt,TResult Function( _ApplyQuickPrompt value)?  applyQuickPrompt,TResult Function( _Randomize value)?  randomize,TResult Function( _UpdateGeneratorOptions value)?  updateGeneratorOptions,TResult Function( _Generate value)?  generate,TResult Function( _GenerateImage value)?  generateImage,TResult Function( _Reset value)?  reset,TResult Function( _LoadHistory value)?  loadHistory,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initialize() when initialize != null:
return initialize(_that);case _TogglePromptType() when togglePromptType != null:
return togglePromptType(_that);case _SelectOption() when selectOption != null:
return selectOption(_that);case _UpdateRawPrompt() when updateRawPrompt != null:
return updateRawPrompt(_that);case _ApplyQuickPrompt() when applyQuickPrompt != null:
return applyQuickPrompt(_that);case _Randomize() when randomize != null:
return randomize(_that);case _UpdateGeneratorOptions() when updateGeneratorOptions != null:
return updateGeneratorOptions(_that);case _Generate() when generate != null:
return generate(_that);case _GenerateImage() when generateImage != null:
return generateImage(_that);case _Reset() when reset != null:
return reset(_that);case _LoadHistory() when loadHistory != null:
return loadHistory(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initialize value)  initialize,required TResult Function( _TogglePromptType value)  togglePromptType,required TResult Function( _SelectOption value)  selectOption,required TResult Function( _UpdateRawPrompt value)  updateRawPrompt,required TResult Function( _ApplyQuickPrompt value)  applyQuickPrompt,required TResult Function( _Randomize value)  randomize,required TResult Function( _UpdateGeneratorOptions value)  updateGeneratorOptions,required TResult Function( _Generate value)  generate,required TResult Function( _GenerateImage value)  generateImage,required TResult Function( _Reset value)  reset,required TResult Function( _LoadHistory value)  loadHistory,}){
final _that = this;
switch (_that) {
case _Initialize():
return initialize(_that);case _TogglePromptType():
return togglePromptType(_that);case _SelectOption():
return selectOption(_that);case _UpdateRawPrompt():
return updateRawPrompt(_that);case _ApplyQuickPrompt():
return applyQuickPrompt(_that);case _Randomize():
return randomize(_that);case _UpdateGeneratorOptions():
return updateGeneratorOptions(_that);case _Generate():
return generate(_that);case _GenerateImage():
return generateImage(_that);case _Reset():
return reset(_that);case _LoadHistory():
return loadHistory(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initialize value)?  initialize,TResult? Function( _TogglePromptType value)?  togglePromptType,TResult? Function( _SelectOption value)?  selectOption,TResult? Function( _UpdateRawPrompt value)?  updateRawPrompt,TResult? Function( _ApplyQuickPrompt value)?  applyQuickPrompt,TResult? Function( _Randomize value)?  randomize,TResult? Function( _UpdateGeneratorOptions value)?  updateGeneratorOptions,TResult? Function( _Generate value)?  generate,TResult? Function( _GenerateImage value)?  generateImage,TResult? Function( _Reset value)?  reset,TResult? Function( _LoadHistory value)?  loadHistory,}){
final _that = this;
switch (_that) {
case _Initialize() when initialize != null:
return initialize(_that);case _TogglePromptType() when togglePromptType != null:
return togglePromptType(_that);case _SelectOption() when selectOption != null:
return selectOption(_that);case _UpdateRawPrompt() when updateRawPrompt != null:
return updateRawPrompt(_that);case _ApplyQuickPrompt() when applyQuickPrompt != null:
return applyQuickPrompt(_that);case _Randomize() when randomize != null:
return randomize(_that);case _UpdateGeneratorOptions() when updateGeneratorOptions != null:
return updateGeneratorOptions(_that);case _Generate() when generate != null:
return generate(_that);case _GenerateImage() when generateImage != null:
return generateImage(_that);case _Reset() when reset != null:
return reset(_that);case _LoadHistory() when loadHistory != null:
return loadHistory(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initialize,TResult Function( bool isRawPrompt)?  togglePromptType,TResult Function( String category,  String value,  String? parentValue)?  selectOption,TResult Function( String text)?  updateRawPrompt,TResult Function( QuickPrompt quickPrompt)?  applyQuickPrompt,TResult Function()?  randomize,TResult Function( StoryLanguage? language,  StoryFormat? format,  StoryLength? length)?  updateGeneratorOptions,TResult Function()?  generate,TResult Function()?  generateImage,TResult Function()?  reset,TResult Function()?  loadHistory,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initialize() when initialize != null:
return initialize();case _TogglePromptType() when togglePromptType != null:
return togglePromptType(_that.isRawPrompt);case _SelectOption() when selectOption != null:
return selectOption(_that.category,_that.value,_that.parentValue);case _UpdateRawPrompt() when updateRawPrompt != null:
return updateRawPrompt(_that.text);case _ApplyQuickPrompt() when applyQuickPrompt != null:
return applyQuickPrompt(_that.quickPrompt);case _Randomize() when randomize != null:
return randomize();case _UpdateGeneratorOptions() when updateGeneratorOptions != null:
return updateGeneratorOptions(_that.language,_that.format,_that.length);case _Generate() when generate != null:
return generate();case _GenerateImage() when generateImage != null:
return generateImage();case _Reset() when reset != null:
return reset();case _LoadHistory() when loadHistory != null:
return loadHistory();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initialize,required TResult Function( bool isRawPrompt)  togglePromptType,required TResult Function( String category,  String value,  String? parentValue)  selectOption,required TResult Function( String text)  updateRawPrompt,required TResult Function( QuickPrompt quickPrompt)  applyQuickPrompt,required TResult Function()  randomize,required TResult Function( StoryLanguage? language,  StoryFormat? format,  StoryLength? length)  updateGeneratorOptions,required TResult Function()  generate,required TResult Function()  generateImage,required TResult Function()  reset,required TResult Function()  loadHistory,}) {final _that = this;
switch (_that) {
case _Initialize():
return initialize();case _TogglePromptType():
return togglePromptType(_that.isRawPrompt);case _SelectOption():
return selectOption(_that.category,_that.value,_that.parentValue);case _UpdateRawPrompt():
return updateRawPrompt(_that.text);case _ApplyQuickPrompt():
return applyQuickPrompt(_that.quickPrompt);case _Randomize():
return randomize();case _UpdateGeneratorOptions():
return updateGeneratorOptions(_that.language,_that.format,_that.length);case _Generate():
return generate();case _GenerateImage():
return generateImage();case _Reset():
return reset();case _LoadHistory():
return loadHistory();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initialize,TResult? Function( bool isRawPrompt)?  togglePromptType,TResult? Function( String category,  String value,  String? parentValue)?  selectOption,TResult? Function( String text)?  updateRawPrompt,TResult? Function( QuickPrompt quickPrompt)?  applyQuickPrompt,TResult? Function()?  randomize,TResult? Function( StoryLanguage? language,  StoryFormat? format,  StoryLength? length)?  updateGeneratorOptions,TResult? Function()?  generate,TResult? Function()?  generateImage,TResult? Function()?  reset,TResult? Function()?  loadHistory,}) {final _that = this;
switch (_that) {
case _Initialize() when initialize != null:
return initialize();case _TogglePromptType() when togglePromptType != null:
return togglePromptType(_that.isRawPrompt);case _SelectOption() when selectOption != null:
return selectOption(_that.category,_that.value,_that.parentValue);case _UpdateRawPrompt() when updateRawPrompt != null:
return updateRawPrompt(_that.text);case _ApplyQuickPrompt() when applyQuickPrompt != null:
return applyQuickPrompt(_that.quickPrompt);case _Randomize() when randomize != null:
return randomize();case _UpdateGeneratorOptions() when updateGeneratorOptions != null:
return updateGeneratorOptions(_that.language,_that.format,_that.length);case _Generate() when generate != null:
return generate();case _GenerateImage() when generateImage != null:
return generateImage();case _Reset() when reset != null:
return reset();case _LoadHistory() when loadHistory != null:
return loadHistory();case _:
  return null;

}
}

}

/// @nodoc


class _Initialize implements StoryGeneratorEvent {
  const _Initialize();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initialize);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StoryGeneratorEvent.initialize()';
}


}




/// @nodoc


class _TogglePromptType implements StoryGeneratorEvent {
  const _TogglePromptType({required this.isRawPrompt});
  

 final  bool isRawPrompt;

/// Create a copy of StoryGeneratorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TogglePromptTypeCopyWith<_TogglePromptType> get copyWith => __$TogglePromptTypeCopyWithImpl<_TogglePromptType>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TogglePromptType&&(identical(other.isRawPrompt, isRawPrompt) || other.isRawPrompt == isRawPrompt));
}


@override
int get hashCode => Object.hash(runtimeType,isRawPrompt);

@override
String toString() {
  return 'StoryGeneratorEvent.togglePromptType(isRawPrompt: $isRawPrompt)';
}


}

/// @nodoc
abstract mixin class _$TogglePromptTypeCopyWith<$Res> implements $StoryGeneratorEventCopyWith<$Res> {
  factory _$TogglePromptTypeCopyWith(_TogglePromptType value, $Res Function(_TogglePromptType) _then) = __$TogglePromptTypeCopyWithImpl;
@useResult
$Res call({
 bool isRawPrompt
});




}
/// @nodoc
class __$TogglePromptTypeCopyWithImpl<$Res>
    implements _$TogglePromptTypeCopyWith<$Res> {
  __$TogglePromptTypeCopyWithImpl(this._self, this._then);

  final _TogglePromptType _self;
  final $Res Function(_TogglePromptType) _then;

/// Create a copy of StoryGeneratorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isRawPrompt = null,}) {
  return _then(_TogglePromptType(
isRawPrompt: null == isRawPrompt ? _self.isRawPrompt : isRawPrompt // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _SelectOption implements StoryGeneratorEvent {
  const _SelectOption({required this.category, required this.value, this.parentValue});
  

 final  String category;
 final  String value;
 final  String? parentValue;

/// Create a copy of StoryGeneratorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectOptionCopyWith<_SelectOption> get copyWith => __$SelectOptionCopyWithImpl<_SelectOption>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectOption&&(identical(other.category, category) || other.category == category)&&(identical(other.value, value) || other.value == value)&&(identical(other.parentValue, parentValue) || other.parentValue == parentValue));
}


@override
int get hashCode => Object.hash(runtimeType,category,value,parentValue);

@override
String toString() {
  return 'StoryGeneratorEvent.selectOption(category: $category, value: $value, parentValue: $parentValue)';
}


}

/// @nodoc
abstract mixin class _$SelectOptionCopyWith<$Res> implements $StoryGeneratorEventCopyWith<$Res> {
  factory _$SelectOptionCopyWith(_SelectOption value, $Res Function(_SelectOption) _then) = __$SelectOptionCopyWithImpl;
@useResult
$Res call({
 String category, String value, String? parentValue
});




}
/// @nodoc
class __$SelectOptionCopyWithImpl<$Res>
    implements _$SelectOptionCopyWith<$Res> {
  __$SelectOptionCopyWithImpl(this._self, this._then);

  final _SelectOption _self;
  final $Res Function(_SelectOption) _then;

/// Create a copy of StoryGeneratorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? category = null,Object? value = null,Object? parentValue = freezed,}) {
  return _then(_SelectOption(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,parentValue: freezed == parentValue ? _self.parentValue : parentValue // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _UpdateRawPrompt implements StoryGeneratorEvent {
  const _UpdateRawPrompt({required this.text});
  

 final  String text;

/// Create a copy of StoryGeneratorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateRawPromptCopyWith<_UpdateRawPrompt> get copyWith => __$UpdateRawPromptCopyWithImpl<_UpdateRawPrompt>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateRawPrompt&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'StoryGeneratorEvent.updateRawPrompt(text: $text)';
}


}

/// @nodoc
abstract mixin class _$UpdateRawPromptCopyWith<$Res> implements $StoryGeneratorEventCopyWith<$Res> {
  factory _$UpdateRawPromptCopyWith(_UpdateRawPrompt value, $Res Function(_UpdateRawPrompt) _then) = __$UpdateRawPromptCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class __$UpdateRawPromptCopyWithImpl<$Res>
    implements _$UpdateRawPromptCopyWith<$Res> {
  __$UpdateRawPromptCopyWithImpl(this._self, this._then);

  final _UpdateRawPrompt _self;
  final $Res Function(_UpdateRawPrompt) _then;

/// Create a copy of StoryGeneratorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(_UpdateRawPrompt(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ApplyQuickPrompt implements StoryGeneratorEvent {
  const _ApplyQuickPrompt({required this.quickPrompt});
  

 final  QuickPrompt quickPrompt;

/// Create a copy of StoryGeneratorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplyQuickPromptCopyWith<_ApplyQuickPrompt> get copyWith => __$ApplyQuickPromptCopyWithImpl<_ApplyQuickPrompt>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplyQuickPrompt&&(identical(other.quickPrompt, quickPrompt) || other.quickPrompt == quickPrompt));
}


@override
int get hashCode => Object.hash(runtimeType,quickPrompt);

@override
String toString() {
  return 'StoryGeneratorEvent.applyQuickPrompt(quickPrompt: $quickPrompt)';
}


}

/// @nodoc
abstract mixin class _$ApplyQuickPromptCopyWith<$Res> implements $StoryGeneratorEventCopyWith<$Res> {
  factory _$ApplyQuickPromptCopyWith(_ApplyQuickPrompt value, $Res Function(_ApplyQuickPrompt) _then) = __$ApplyQuickPromptCopyWithImpl;
@useResult
$Res call({
 QuickPrompt quickPrompt
});




}
/// @nodoc
class __$ApplyQuickPromptCopyWithImpl<$Res>
    implements _$ApplyQuickPromptCopyWith<$Res> {
  __$ApplyQuickPromptCopyWithImpl(this._self, this._then);

  final _ApplyQuickPrompt _self;
  final $Res Function(_ApplyQuickPrompt) _then;

/// Create a copy of StoryGeneratorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? quickPrompt = null,}) {
  return _then(_ApplyQuickPrompt(
quickPrompt: null == quickPrompt ? _self.quickPrompt : quickPrompt // ignore: cast_nullable_to_non_nullable
as QuickPrompt,
  ));
}


}

/// @nodoc


class _Randomize implements StoryGeneratorEvent {
  const _Randomize();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Randomize);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StoryGeneratorEvent.randomize()';
}


}




/// @nodoc


class _UpdateGeneratorOptions implements StoryGeneratorEvent {
  const _UpdateGeneratorOptions({this.language, this.format, this.length});
  

 final  StoryLanguage? language;
 final  StoryFormat? format;
 final  StoryLength? length;

/// Create a copy of StoryGeneratorEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateGeneratorOptionsCopyWith<_UpdateGeneratorOptions> get copyWith => __$UpdateGeneratorOptionsCopyWithImpl<_UpdateGeneratorOptions>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateGeneratorOptions&&(identical(other.language, language) || other.language == language)&&(identical(other.format, format) || other.format == format)&&(identical(other.length, length) || other.length == length));
}


@override
int get hashCode => Object.hash(runtimeType,language,format,length);

@override
String toString() {
  return 'StoryGeneratorEvent.updateGeneratorOptions(language: $language, format: $format, length: $length)';
}


}

/// @nodoc
abstract mixin class _$UpdateGeneratorOptionsCopyWith<$Res> implements $StoryGeneratorEventCopyWith<$Res> {
  factory _$UpdateGeneratorOptionsCopyWith(_UpdateGeneratorOptions value, $Res Function(_UpdateGeneratorOptions) _then) = __$UpdateGeneratorOptionsCopyWithImpl;
@useResult
$Res call({
 StoryLanguage? language, StoryFormat? format, StoryLength? length
});




}
/// @nodoc
class __$UpdateGeneratorOptionsCopyWithImpl<$Res>
    implements _$UpdateGeneratorOptionsCopyWith<$Res> {
  __$UpdateGeneratorOptionsCopyWithImpl(this._self, this._then);

  final _UpdateGeneratorOptions _self;
  final $Res Function(_UpdateGeneratorOptions) _then;

/// Create a copy of StoryGeneratorEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? language = freezed,Object? format = freezed,Object? length = freezed,}) {
  return _then(_UpdateGeneratorOptions(
language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as StoryLanguage?,format: freezed == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as StoryFormat?,length: freezed == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as StoryLength?,
  ));
}


}

/// @nodoc


class _Generate implements StoryGeneratorEvent {
  const _Generate();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Generate);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StoryGeneratorEvent.generate()';
}


}




/// @nodoc


class _GenerateImage implements StoryGeneratorEvent {
  const _GenerateImage();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GenerateImage);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StoryGeneratorEvent.generateImage()';
}


}




/// @nodoc


class _Reset implements StoryGeneratorEvent {
  const _Reset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StoryGeneratorEvent.reset()';
}


}




/// @nodoc


class _LoadHistory implements StoryGeneratorEvent {
  const _LoadHistory();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadHistory);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StoryGeneratorEvent.loadHistory()';
}


}




// dart format on
