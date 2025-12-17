// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StoryModel {

@HiveField(0) String get id;@HiveField(1) String get title;@HiveField(2) String get scripture;@HiveField(3) String get story;@HiveField(4) String get quotes;@HiveField(5) String get trivia;@HiveField(6) String get activity;@HiveField(7) String get lesson;@HiveField(8) StoryAttributesModel get attributes;@HiveField(9) String? get imageUrl;@HiveField(10) String? get author;@HiveField(11) DateTime? get publishedAt;@HiveField(12) int get likes;@HiveField(13) int get views;@HiveField(14) bool get isFavorite;
/// Create a copy of StoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoryModelCopyWith<StoryModel> get copyWith => _$StoryModelCopyWithImpl<StoryModel>(this as StoryModel, _$identity);

  /// Serializes this StoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.scripture, scripture) || other.scripture == scripture)&&(identical(other.story, story) || other.story == story)&&(identical(other.quotes, quotes) || other.quotes == quotes)&&(identical(other.trivia, trivia) || other.trivia == trivia)&&(identical(other.activity, activity) || other.activity == activity)&&(identical(other.lesson, lesson) || other.lesson == lesson)&&(identical(other.attributes, attributes) || other.attributes == attributes)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.author, author) || other.author == author)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.views, views) || other.views == views)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,scripture,story,quotes,trivia,activity,lesson,attributes,imageUrl,author,publishedAt,likes,views,isFavorite);

@override
String toString() {
  return 'StoryModel(id: $id, title: $title, scripture: $scripture, story: $story, quotes: $quotes, trivia: $trivia, activity: $activity, lesson: $lesson, attributes: $attributes, imageUrl: $imageUrl, author: $author, publishedAt: $publishedAt, likes: $likes, views: $views, isFavorite: $isFavorite)';
}


}

/// @nodoc
abstract mixin class $StoryModelCopyWith<$Res>  {
  factory $StoryModelCopyWith(StoryModel value, $Res Function(StoryModel) _then) = _$StoryModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String title,@HiveField(2) String scripture,@HiveField(3) String story,@HiveField(4) String quotes,@HiveField(5) String trivia,@HiveField(6) String activity,@HiveField(7) String lesson,@HiveField(8) StoryAttributesModel attributes,@HiveField(9) String? imageUrl,@HiveField(10) String? author,@HiveField(11) DateTime? publishedAt,@HiveField(12) int likes,@HiveField(13) int views,@HiveField(14) bool isFavorite
});


$StoryAttributesModelCopyWith<$Res> get attributes;

}
/// @nodoc
class _$StoryModelCopyWithImpl<$Res>
    implements $StoryModelCopyWith<$Res> {
  _$StoryModelCopyWithImpl(this._self, this._then);

  final StoryModel _self;
  final $Res Function(StoryModel) _then;

/// Create a copy of StoryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? scripture = null,Object? story = null,Object? quotes = null,Object? trivia = null,Object? activity = null,Object? lesson = null,Object? attributes = null,Object? imageUrl = freezed,Object? author = freezed,Object? publishedAt = freezed,Object? likes = null,Object? views = null,Object? isFavorite = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,scripture: null == scripture ? _self.scripture : scripture // ignore: cast_nullable_to_non_nullable
as String,story: null == story ? _self.story : story // ignore: cast_nullable_to_non_nullable
as String,quotes: null == quotes ? _self.quotes : quotes // ignore: cast_nullable_to_non_nullable
as String,trivia: null == trivia ? _self.trivia : trivia // ignore: cast_nullable_to_non_nullable
as String,activity: null == activity ? _self.activity : activity // ignore: cast_nullable_to_non_nullable
as String,lesson: null == lesson ? _self.lesson : lesson // ignore: cast_nullable_to_non_nullable
as String,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as StoryAttributesModel,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of StoryModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StoryAttributesModelCopyWith<$Res> get attributes {
  
  return $StoryAttributesModelCopyWith<$Res>(_self.attributes, (value) {
    return _then(_self.copyWith(attributes: value));
  });
}
}


/// Adds pattern-matching-related methods to [StoryModel].
extension StoryModelPatterns on StoryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoryModel value)  $default,){
final _that = this;
switch (_that) {
case _StoryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _StoryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String title, @HiveField(2)  String scripture, @HiveField(3)  String story, @HiveField(4)  String quotes, @HiveField(5)  String trivia, @HiveField(6)  String activity, @HiveField(7)  String lesson, @HiveField(8)  StoryAttributesModel attributes, @HiveField(9)  String? imageUrl, @HiveField(10)  String? author, @HiveField(11)  DateTime? publishedAt, @HiveField(12)  int likes, @HiveField(13)  int views, @HiveField(14)  bool isFavorite)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoryModel() when $default != null:
return $default(_that.id,_that.title,_that.scripture,_that.story,_that.quotes,_that.trivia,_that.activity,_that.lesson,_that.attributes,_that.imageUrl,_that.author,_that.publishedAt,_that.likes,_that.views,_that.isFavorite);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String title, @HiveField(2)  String scripture, @HiveField(3)  String story, @HiveField(4)  String quotes, @HiveField(5)  String trivia, @HiveField(6)  String activity, @HiveField(7)  String lesson, @HiveField(8)  StoryAttributesModel attributes, @HiveField(9)  String? imageUrl, @HiveField(10)  String? author, @HiveField(11)  DateTime? publishedAt, @HiveField(12)  int likes, @HiveField(13)  int views, @HiveField(14)  bool isFavorite)  $default,) {final _that = this;
switch (_that) {
case _StoryModel():
return $default(_that.id,_that.title,_that.scripture,_that.story,_that.quotes,_that.trivia,_that.activity,_that.lesson,_that.attributes,_that.imageUrl,_that.author,_that.publishedAt,_that.likes,_that.views,_that.isFavorite);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String id, @HiveField(1)  String title, @HiveField(2)  String scripture, @HiveField(3)  String story, @HiveField(4)  String quotes, @HiveField(5)  String trivia, @HiveField(6)  String activity, @HiveField(7)  String lesson, @HiveField(8)  StoryAttributesModel attributes, @HiveField(9)  String? imageUrl, @HiveField(10)  String? author, @HiveField(11)  DateTime? publishedAt, @HiveField(12)  int likes, @HiveField(13)  int views, @HiveField(14)  bool isFavorite)?  $default,) {final _that = this;
switch (_that) {
case _StoryModel() when $default != null:
return $default(_that.id,_that.title,_that.scripture,_that.story,_that.quotes,_that.trivia,_that.activity,_that.lesson,_that.attributes,_that.imageUrl,_that.author,_that.publishedAt,_that.likes,_that.views,_that.isFavorite);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StoryModel extends StoryModel {
  const _StoryModel({@HiveField(0) required this.id, @HiveField(1) required this.title, @HiveField(2) required this.scripture, @HiveField(3) required this.story, @HiveField(4) required this.quotes, @HiveField(5) required this.trivia, @HiveField(6) required this.activity, @HiveField(7) required this.lesson, @HiveField(8) required this.attributes, @HiveField(9) this.imageUrl, @HiveField(10) this.author, @HiveField(11) this.publishedAt, @HiveField(12) this.likes = 0, @HiveField(13) this.views = 0, @HiveField(14) this.isFavorite = false}): super._();
  factory _StoryModel.fromJson(Map<String, dynamic> json) => _$StoryModelFromJson(json);

@override@HiveField(0) final  String id;
@override@HiveField(1) final  String title;
@override@HiveField(2) final  String scripture;
@override@HiveField(3) final  String story;
@override@HiveField(4) final  String quotes;
@override@HiveField(5) final  String trivia;
@override@HiveField(6) final  String activity;
@override@HiveField(7) final  String lesson;
@override@HiveField(8) final  StoryAttributesModel attributes;
@override@HiveField(9) final  String? imageUrl;
@override@HiveField(10) final  String? author;
@override@HiveField(11) final  DateTime? publishedAt;
@override@JsonKey()@HiveField(12) final  int likes;
@override@JsonKey()@HiveField(13) final  int views;
@override@JsonKey()@HiveField(14) final  bool isFavorite;

/// Create a copy of StoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoryModelCopyWith<_StoryModel> get copyWith => __$StoryModelCopyWithImpl<_StoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.scripture, scripture) || other.scripture == scripture)&&(identical(other.story, story) || other.story == story)&&(identical(other.quotes, quotes) || other.quotes == quotes)&&(identical(other.trivia, trivia) || other.trivia == trivia)&&(identical(other.activity, activity) || other.activity == activity)&&(identical(other.lesson, lesson) || other.lesson == lesson)&&(identical(other.attributes, attributes) || other.attributes == attributes)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.author, author) || other.author == author)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.views, views) || other.views == views)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,scripture,story,quotes,trivia,activity,lesson,attributes,imageUrl,author,publishedAt,likes,views,isFavorite);

@override
String toString() {
  return 'StoryModel(id: $id, title: $title, scripture: $scripture, story: $story, quotes: $quotes, trivia: $trivia, activity: $activity, lesson: $lesson, attributes: $attributes, imageUrl: $imageUrl, author: $author, publishedAt: $publishedAt, likes: $likes, views: $views, isFavorite: $isFavorite)';
}


}

/// @nodoc
abstract mixin class _$StoryModelCopyWith<$Res> implements $StoryModelCopyWith<$Res> {
  factory _$StoryModelCopyWith(_StoryModel value, $Res Function(_StoryModel) _then) = __$StoryModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String title,@HiveField(2) String scripture,@HiveField(3) String story,@HiveField(4) String quotes,@HiveField(5) String trivia,@HiveField(6) String activity,@HiveField(7) String lesson,@HiveField(8) StoryAttributesModel attributes,@HiveField(9) String? imageUrl,@HiveField(10) String? author,@HiveField(11) DateTime? publishedAt,@HiveField(12) int likes,@HiveField(13) int views,@HiveField(14) bool isFavorite
});


@override $StoryAttributesModelCopyWith<$Res> get attributes;

}
/// @nodoc
class __$StoryModelCopyWithImpl<$Res>
    implements _$StoryModelCopyWith<$Res> {
  __$StoryModelCopyWithImpl(this._self, this._then);

  final _StoryModel _self;
  final $Res Function(_StoryModel) _then;

/// Create a copy of StoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? scripture = null,Object? story = null,Object? quotes = null,Object? trivia = null,Object? activity = null,Object? lesson = null,Object? attributes = null,Object? imageUrl = freezed,Object? author = freezed,Object? publishedAt = freezed,Object? likes = null,Object? views = null,Object? isFavorite = null,}) {
  return _then(_StoryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,scripture: null == scripture ? _self.scripture : scripture // ignore: cast_nullable_to_non_nullable
as String,story: null == story ? _self.story : story // ignore: cast_nullable_to_non_nullable
as String,quotes: null == quotes ? _self.quotes : quotes // ignore: cast_nullable_to_non_nullable
as String,trivia: null == trivia ? _self.trivia : trivia // ignore: cast_nullable_to_non_nullable
as String,activity: null == activity ? _self.activity : activity // ignore: cast_nullable_to_non_nullable
as String,lesson: null == lesson ? _self.lesson : lesson // ignore: cast_nullable_to_non_nullable
as String,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as StoryAttributesModel,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of StoryModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StoryAttributesModelCopyWith<$Res> get attributes {
  
  return $StoryAttributesModelCopyWith<$Res>(_self.attributes, (value) {
    return _then(_self.copyWith(attributes: value));
  });
}
}


/// @nodoc
mixin _$StoryAttributesModel {

@HiveField(0) String get storyType;@HiveField(1) String get theme;@HiveField(2) String get mainCharacterType;@HiveField(3) String get storySetting;@HiveField(4) String get timeEra;@HiveField(5) String get narrativePerspective;@HiveField(6) String get languageStyle;@HiveField(7) String get emotionalTone;@HiveField(8) String get narrativeStyle;@HiveField(9) String get plotStructure;@HiveField(10) String get storyLength;@HiveField(11) List<String> get references;@HiveField(12) List<String> get tags;
/// Create a copy of StoryAttributesModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoryAttributesModelCopyWith<StoryAttributesModel> get copyWith => _$StoryAttributesModelCopyWithImpl<StoryAttributesModel>(this as StoryAttributesModel, _$identity);

  /// Serializes this StoryAttributesModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoryAttributesModel&&(identical(other.storyType, storyType) || other.storyType == storyType)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.mainCharacterType, mainCharacterType) || other.mainCharacterType == mainCharacterType)&&(identical(other.storySetting, storySetting) || other.storySetting == storySetting)&&(identical(other.timeEra, timeEra) || other.timeEra == timeEra)&&(identical(other.narrativePerspective, narrativePerspective) || other.narrativePerspective == narrativePerspective)&&(identical(other.languageStyle, languageStyle) || other.languageStyle == languageStyle)&&(identical(other.emotionalTone, emotionalTone) || other.emotionalTone == emotionalTone)&&(identical(other.narrativeStyle, narrativeStyle) || other.narrativeStyle == narrativeStyle)&&(identical(other.plotStructure, plotStructure) || other.plotStructure == plotStructure)&&(identical(other.storyLength, storyLength) || other.storyLength == storyLength)&&const DeepCollectionEquality().equals(other.references, references)&&const DeepCollectionEquality().equals(other.tags, tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,storyType,theme,mainCharacterType,storySetting,timeEra,narrativePerspective,languageStyle,emotionalTone,narrativeStyle,plotStructure,storyLength,const DeepCollectionEquality().hash(references),const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'StoryAttributesModel(storyType: $storyType, theme: $theme, mainCharacterType: $mainCharacterType, storySetting: $storySetting, timeEra: $timeEra, narrativePerspective: $narrativePerspective, languageStyle: $languageStyle, emotionalTone: $emotionalTone, narrativeStyle: $narrativeStyle, plotStructure: $plotStructure, storyLength: $storyLength, references: $references, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $StoryAttributesModelCopyWith<$Res>  {
  factory $StoryAttributesModelCopyWith(StoryAttributesModel value, $Res Function(StoryAttributesModel) _then) = _$StoryAttributesModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String storyType,@HiveField(1) String theme,@HiveField(2) String mainCharacterType,@HiveField(3) String storySetting,@HiveField(4) String timeEra,@HiveField(5) String narrativePerspective,@HiveField(6) String languageStyle,@HiveField(7) String emotionalTone,@HiveField(8) String narrativeStyle,@HiveField(9) String plotStructure,@HiveField(10) String storyLength,@HiveField(11) List<String> references,@HiveField(12) List<String> tags
});




}
/// @nodoc
class _$StoryAttributesModelCopyWithImpl<$Res>
    implements $StoryAttributesModelCopyWith<$Res> {
  _$StoryAttributesModelCopyWithImpl(this._self, this._then);

  final StoryAttributesModel _self;
  final $Res Function(StoryAttributesModel) _then;

/// Create a copy of StoryAttributesModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? storyType = null,Object? theme = null,Object? mainCharacterType = null,Object? storySetting = null,Object? timeEra = null,Object? narrativePerspective = null,Object? languageStyle = null,Object? emotionalTone = null,Object? narrativeStyle = null,Object? plotStructure = null,Object? storyLength = null,Object? references = null,Object? tags = null,}) {
  return _then(_self.copyWith(
storyType: null == storyType ? _self.storyType : storyType // ignore: cast_nullable_to_non_nullable
as String,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String,mainCharacterType: null == mainCharacterType ? _self.mainCharacterType : mainCharacterType // ignore: cast_nullable_to_non_nullable
as String,storySetting: null == storySetting ? _self.storySetting : storySetting // ignore: cast_nullable_to_non_nullable
as String,timeEra: null == timeEra ? _self.timeEra : timeEra // ignore: cast_nullable_to_non_nullable
as String,narrativePerspective: null == narrativePerspective ? _self.narrativePerspective : narrativePerspective // ignore: cast_nullable_to_non_nullable
as String,languageStyle: null == languageStyle ? _self.languageStyle : languageStyle // ignore: cast_nullable_to_non_nullable
as String,emotionalTone: null == emotionalTone ? _self.emotionalTone : emotionalTone // ignore: cast_nullable_to_non_nullable
as String,narrativeStyle: null == narrativeStyle ? _self.narrativeStyle : narrativeStyle // ignore: cast_nullable_to_non_nullable
as String,plotStructure: null == plotStructure ? _self.plotStructure : plotStructure // ignore: cast_nullable_to_non_nullable
as String,storyLength: null == storyLength ? _self.storyLength : storyLength // ignore: cast_nullable_to_non_nullable
as String,references: null == references ? _self.references : references // ignore: cast_nullable_to_non_nullable
as List<String>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [StoryAttributesModel].
extension StoryAttributesModelPatterns on StoryAttributesModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoryAttributesModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoryAttributesModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoryAttributesModel value)  $default,){
final _that = this;
switch (_that) {
case _StoryAttributesModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoryAttributesModel value)?  $default,){
final _that = this;
switch (_that) {
case _StoryAttributesModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String storyType, @HiveField(1)  String theme, @HiveField(2)  String mainCharacterType, @HiveField(3)  String storySetting, @HiveField(4)  String timeEra, @HiveField(5)  String narrativePerspective, @HiveField(6)  String languageStyle, @HiveField(7)  String emotionalTone, @HiveField(8)  String narrativeStyle, @HiveField(9)  String plotStructure, @HiveField(10)  String storyLength, @HiveField(11)  List<String> references, @HiveField(12)  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoryAttributesModel() when $default != null:
return $default(_that.storyType,_that.theme,_that.mainCharacterType,_that.storySetting,_that.timeEra,_that.narrativePerspective,_that.languageStyle,_that.emotionalTone,_that.narrativeStyle,_that.plotStructure,_that.storyLength,_that.references,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String storyType, @HiveField(1)  String theme, @HiveField(2)  String mainCharacterType, @HiveField(3)  String storySetting, @HiveField(4)  String timeEra, @HiveField(5)  String narrativePerspective, @HiveField(6)  String languageStyle, @HiveField(7)  String emotionalTone, @HiveField(8)  String narrativeStyle, @HiveField(9)  String plotStructure, @HiveField(10)  String storyLength, @HiveField(11)  List<String> references, @HiveField(12)  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _StoryAttributesModel():
return $default(_that.storyType,_that.theme,_that.mainCharacterType,_that.storySetting,_that.timeEra,_that.narrativePerspective,_that.languageStyle,_that.emotionalTone,_that.narrativeStyle,_that.plotStructure,_that.storyLength,_that.references,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String storyType, @HiveField(1)  String theme, @HiveField(2)  String mainCharacterType, @HiveField(3)  String storySetting, @HiveField(4)  String timeEra, @HiveField(5)  String narrativePerspective, @HiveField(6)  String languageStyle, @HiveField(7)  String emotionalTone, @HiveField(8)  String narrativeStyle, @HiveField(9)  String plotStructure, @HiveField(10)  String storyLength, @HiveField(11)  List<String> references, @HiveField(12)  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _StoryAttributesModel() when $default != null:
return $default(_that.storyType,_that.theme,_that.mainCharacterType,_that.storySetting,_that.timeEra,_that.narrativePerspective,_that.languageStyle,_that.emotionalTone,_that.narrativeStyle,_that.plotStructure,_that.storyLength,_that.references,_that.tags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StoryAttributesModel extends StoryAttributesModel {
  const _StoryAttributesModel({@HiveField(0) required this.storyType, @HiveField(1) required this.theme, @HiveField(2) required this.mainCharacterType, @HiveField(3) required this.storySetting, @HiveField(4) required this.timeEra, @HiveField(5) required this.narrativePerspective, @HiveField(6) required this.languageStyle, @HiveField(7) required this.emotionalTone, @HiveField(8) required this.narrativeStyle, @HiveField(9) required this.plotStructure, @HiveField(10) required this.storyLength, @HiveField(11) final  List<String> references = const [], @HiveField(12) final  List<String> tags = const []}): _references = references,_tags = tags,super._();
  factory _StoryAttributesModel.fromJson(Map<String, dynamic> json) => _$StoryAttributesModelFromJson(json);

@override@HiveField(0) final  String storyType;
@override@HiveField(1) final  String theme;
@override@HiveField(2) final  String mainCharacterType;
@override@HiveField(3) final  String storySetting;
@override@HiveField(4) final  String timeEra;
@override@HiveField(5) final  String narrativePerspective;
@override@HiveField(6) final  String languageStyle;
@override@HiveField(7) final  String emotionalTone;
@override@HiveField(8) final  String narrativeStyle;
@override@HiveField(9) final  String plotStructure;
@override@HiveField(10) final  String storyLength;
 final  List<String> _references;
@override@JsonKey()@HiveField(11) List<String> get references {
  if (_references is EqualUnmodifiableListView) return _references;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_references);
}

 final  List<String> _tags;
@override@JsonKey()@HiveField(12) List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of StoryAttributesModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoryAttributesModelCopyWith<_StoryAttributesModel> get copyWith => __$StoryAttributesModelCopyWithImpl<_StoryAttributesModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoryAttributesModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoryAttributesModel&&(identical(other.storyType, storyType) || other.storyType == storyType)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.mainCharacterType, mainCharacterType) || other.mainCharacterType == mainCharacterType)&&(identical(other.storySetting, storySetting) || other.storySetting == storySetting)&&(identical(other.timeEra, timeEra) || other.timeEra == timeEra)&&(identical(other.narrativePerspective, narrativePerspective) || other.narrativePerspective == narrativePerspective)&&(identical(other.languageStyle, languageStyle) || other.languageStyle == languageStyle)&&(identical(other.emotionalTone, emotionalTone) || other.emotionalTone == emotionalTone)&&(identical(other.narrativeStyle, narrativeStyle) || other.narrativeStyle == narrativeStyle)&&(identical(other.plotStructure, plotStructure) || other.plotStructure == plotStructure)&&(identical(other.storyLength, storyLength) || other.storyLength == storyLength)&&const DeepCollectionEquality().equals(other._references, _references)&&const DeepCollectionEquality().equals(other._tags, _tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,storyType,theme,mainCharacterType,storySetting,timeEra,narrativePerspective,languageStyle,emotionalTone,narrativeStyle,plotStructure,storyLength,const DeepCollectionEquality().hash(_references),const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'StoryAttributesModel(storyType: $storyType, theme: $theme, mainCharacterType: $mainCharacterType, storySetting: $storySetting, timeEra: $timeEra, narrativePerspective: $narrativePerspective, languageStyle: $languageStyle, emotionalTone: $emotionalTone, narrativeStyle: $narrativeStyle, plotStructure: $plotStructure, storyLength: $storyLength, references: $references, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$StoryAttributesModelCopyWith<$Res> implements $StoryAttributesModelCopyWith<$Res> {
  factory _$StoryAttributesModelCopyWith(_StoryAttributesModel value, $Res Function(_StoryAttributesModel) _then) = __$StoryAttributesModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String storyType,@HiveField(1) String theme,@HiveField(2) String mainCharacterType,@HiveField(3) String storySetting,@HiveField(4) String timeEra,@HiveField(5) String narrativePerspective,@HiveField(6) String languageStyle,@HiveField(7) String emotionalTone,@HiveField(8) String narrativeStyle,@HiveField(9) String plotStructure,@HiveField(10) String storyLength,@HiveField(11) List<String> references,@HiveField(12) List<String> tags
});




}
/// @nodoc
class __$StoryAttributesModelCopyWithImpl<$Res>
    implements _$StoryAttributesModelCopyWith<$Res> {
  __$StoryAttributesModelCopyWithImpl(this._self, this._then);

  final _StoryAttributesModel _self;
  final $Res Function(_StoryAttributesModel) _then;

/// Create a copy of StoryAttributesModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? storyType = null,Object? theme = null,Object? mainCharacterType = null,Object? storySetting = null,Object? timeEra = null,Object? narrativePerspective = null,Object? languageStyle = null,Object? emotionalTone = null,Object? narrativeStyle = null,Object? plotStructure = null,Object? storyLength = null,Object? references = null,Object? tags = null,}) {
  return _then(_StoryAttributesModel(
storyType: null == storyType ? _self.storyType : storyType // ignore: cast_nullable_to_non_nullable
as String,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String,mainCharacterType: null == mainCharacterType ? _self.mainCharacterType : mainCharacterType // ignore: cast_nullable_to_non_nullable
as String,storySetting: null == storySetting ? _self.storySetting : storySetting // ignore: cast_nullable_to_non_nullable
as String,timeEra: null == timeEra ? _self.timeEra : timeEra // ignore: cast_nullable_to_non_nullable
as String,narrativePerspective: null == narrativePerspective ? _self.narrativePerspective : narrativePerspective // ignore: cast_nullable_to_non_nullable
as String,languageStyle: null == languageStyle ? _self.languageStyle : languageStyle // ignore: cast_nullable_to_non_nullable
as String,emotionalTone: null == emotionalTone ? _self.emotionalTone : emotionalTone // ignore: cast_nullable_to_non_nullable
as String,narrativeStyle: null == narrativeStyle ? _self.narrativeStyle : narrativeStyle // ignore: cast_nullable_to_non_nullable
as String,plotStructure: null == plotStructure ? _self.plotStructure : plotStructure // ignore: cast_nullable_to_non_nullable
as String,storyLength: null == storyLength ? _self.storyLength : storyLength // ignore: cast_nullable_to_non_nullable
as String,references: null == references ? _self._references : references // ignore: cast_nullable_to_non_nullable
as List<String>,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
