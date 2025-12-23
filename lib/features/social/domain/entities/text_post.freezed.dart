// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text_post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TextPost {

 String get id; String get body; int get backgroundColor; int get textColor; double get fontSize; String? get fontFamily; DateTime? get createdAt; String? get authorId; User? get authorUser; int get likes; int get commentCount; int get shareCount; bool get isLikedByCurrentUser; bool get isFavorite; List<String> get tags;
/// Create a copy of TextPost
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextPostCopyWith<TextPost> get copyWith => _$TextPostCopyWithImpl<TextPost>(this as TextPost, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextPost&&(identical(other.id, id) || other.id == id)&&(identical(other.body, body) || other.body == body)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.textColor, textColor) || other.textColor == textColor)&&(identical(other.fontSize, fontSize) || other.fontSize == fontSize)&&(identical(other.fontFamily, fontFamily) || other.fontFamily == fontFamily)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.authorUser, authorUser) || other.authorUser == authorUser)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&(identical(other.shareCount, shareCount) || other.shareCount == shareCount)&&(identical(other.isLikedByCurrentUser, isLikedByCurrentUser) || other.isLikedByCurrentUser == isLikedByCurrentUser)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&const DeepCollectionEquality().equals(other.tags, tags));
}


@override
int get hashCode => Object.hash(runtimeType,id,body,backgroundColor,textColor,fontSize,fontFamily,createdAt,authorId,authorUser,likes,commentCount,shareCount,isLikedByCurrentUser,isFavorite,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'TextPost(id: $id, body: $body, backgroundColor: $backgroundColor, textColor: $textColor, fontSize: $fontSize, fontFamily: $fontFamily, createdAt: $createdAt, authorId: $authorId, authorUser: $authorUser, likes: $likes, commentCount: $commentCount, shareCount: $shareCount, isLikedByCurrentUser: $isLikedByCurrentUser, isFavorite: $isFavorite, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $TextPostCopyWith<$Res>  {
  factory $TextPostCopyWith(TextPost value, $Res Function(TextPost) _then) = _$TextPostCopyWithImpl;
@useResult
$Res call({
 String id, String body, int backgroundColor, int textColor, double fontSize, String? fontFamily, DateTime? createdAt, String? authorId, User? authorUser, int likes, int commentCount, int shareCount, bool isLikedByCurrentUser, bool isFavorite, List<String> tags
});


$UserCopyWith<$Res>? get authorUser;

}
/// @nodoc
class _$TextPostCopyWithImpl<$Res>
    implements $TextPostCopyWith<$Res> {
  _$TextPostCopyWithImpl(this._self, this._then);

  final TextPost _self;
  final $Res Function(TextPost) _then;

/// Create a copy of TextPost
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? body = null,Object? backgroundColor = null,Object? textColor = null,Object? fontSize = null,Object? fontFamily = freezed,Object? createdAt = freezed,Object? authorId = freezed,Object? authorUser = freezed,Object? likes = null,Object? commentCount = null,Object? shareCount = null,Object? isLikedByCurrentUser = null,Object? isFavorite = null,Object? tags = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as int,textColor: null == textColor ? _self.textColor : textColor // ignore: cast_nullable_to_non_nullable
as int,fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as double,fontFamily: freezed == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,authorId: freezed == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String?,authorUser: freezed == authorUser ? _self.authorUser : authorUser // ignore: cast_nullable_to_non_nullable
as User?,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,shareCount: null == shareCount ? _self.shareCount : shareCount // ignore: cast_nullable_to_non_nullable
as int,isLikedByCurrentUser: null == isLikedByCurrentUser ? _self.isLikedByCurrentUser : isLikedByCurrentUser // ignore: cast_nullable_to_non_nullable
as bool,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of TextPost
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get authorUser {
    if (_self.authorUser == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.authorUser!, (value) {
    return _then(_self.copyWith(authorUser: value));
  });
}
}


/// Adds pattern-matching-related methods to [TextPost].
extension TextPostPatterns on TextPost {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TextPost value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TextPost() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TextPost value)  $default,){
final _that = this;
switch (_that) {
case _TextPost():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TextPost value)?  $default,){
final _that = this;
switch (_that) {
case _TextPost() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String body,  int backgroundColor,  int textColor,  double fontSize,  String? fontFamily,  DateTime? createdAt,  String? authorId,  User? authorUser,  int likes,  int commentCount,  int shareCount,  bool isLikedByCurrentUser,  bool isFavorite,  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TextPost() when $default != null:
return $default(_that.id,_that.body,_that.backgroundColor,_that.textColor,_that.fontSize,_that.fontFamily,_that.createdAt,_that.authorId,_that.authorUser,_that.likes,_that.commentCount,_that.shareCount,_that.isLikedByCurrentUser,_that.isFavorite,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String body,  int backgroundColor,  int textColor,  double fontSize,  String? fontFamily,  DateTime? createdAt,  String? authorId,  User? authorUser,  int likes,  int commentCount,  int shareCount,  bool isLikedByCurrentUser,  bool isFavorite,  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _TextPost():
return $default(_that.id,_that.body,_that.backgroundColor,_that.textColor,_that.fontSize,_that.fontFamily,_that.createdAt,_that.authorId,_that.authorUser,_that.likes,_that.commentCount,_that.shareCount,_that.isLikedByCurrentUser,_that.isFavorite,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String body,  int backgroundColor,  int textColor,  double fontSize,  String? fontFamily,  DateTime? createdAt,  String? authorId,  User? authorUser,  int likes,  int commentCount,  int shareCount,  bool isLikedByCurrentUser,  bool isFavorite,  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _TextPost() when $default != null:
return $default(_that.id,_that.body,_that.backgroundColor,_that.textColor,_that.fontSize,_that.fontFamily,_that.createdAt,_that.authorId,_that.authorUser,_that.likes,_that.commentCount,_that.shareCount,_that.isLikedByCurrentUser,_that.isFavorite,_that.tags);case _:
  return null;

}
}

}

/// @nodoc


class _TextPost extends TextPost {
  const _TextPost({required this.id, required this.body, this.backgroundColor = 0xFF1E3A5F, this.textColor = 0xFFFFFFFF, this.fontSize = 18.0, this.fontFamily, this.createdAt, this.authorId, this.authorUser, this.likes = 0, this.commentCount = 0, this.shareCount = 0, this.isLikedByCurrentUser = false, this.isFavorite = false, final  List<String> tags = const []}): _tags = tags,super._();
  

@override final  String id;
@override final  String body;
@override@JsonKey() final  int backgroundColor;
@override@JsonKey() final  int textColor;
@override@JsonKey() final  double fontSize;
@override final  String? fontFamily;
@override final  DateTime? createdAt;
@override final  String? authorId;
@override final  User? authorUser;
@override@JsonKey() final  int likes;
@override@JsonKey() final  int commentCount;
@override@JsonKey() final  int shareCount;
@override@JsonKey() final  bool isLikedByCurrentUser;
@override@JsonKey() final  bool isFavorite;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of TextPost
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TextPostCopyWith<_TextPost> get copyWith => __$TextPostCopyWithImpl<_TextPost>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TextPost&&(identical(other.id, id) || other.id == id)&&(identical(other.body, body) || other.body == body)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.textColor, textColor) || other.textColor == textColor)&&(identical(other.fontSize, fontSize) || other.fontSize == fontSize)&&(identical(other.fontFamily, fontFamily) || other.fontFamily == fontFamily)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.authorUser, authorUser) || other.authorUser == authorUser)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&(identical(other.shareCount, shareCount) || other.shareCount == shareCount)&&(identical(other.isLikedByCurrentUser, isLikedByCurrentUser) || other.isLikedByCurrentUser == isLikedByCurrentUser)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&const DeepCollectionEquality().equals(other._tags, _tags));
}


@override
int get hashCode => Object.hash(runtimeType,id,body,backgroundColor,textColor,fontSize,fontFamily,createdAt,authorId,authorUser,likes,commentCount,shareCount,isLikedByCurrentUser,isFavorite,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'TextPost(id: $id, body: $body, backgroundColor: $backgroundColor, textColor: $textColor, fontSize: $fontSize, fontFamily: $fontFamily, createdAt: $createdAt, authorId: $authorId, authorUser: $authorUser, likes: $likes, commentCount: $commentCount, shareCount: $shareCount, isLikedByCurrentUser: $isLikedByCurrentUser, isFavorite: $isFavorite, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$TextPostCopyWith<$Res> implements $TextPostCopyWith<$Res> {
  factory _$TextPostCopyWith(_TextPost value, $Res Function(_TextPost) _then) = __$TextPostCopyWithImpl;
@override @useResult
$Res call({
 String id, String body, int backgroundColor, int textColor, double fontSize, String? fontFamily, DateTime? createdAt, String? authorId, User? authorUser, int likes, int commentCount, int shareCount, bool isLikedByCurrentUser, bool isFavorite, List<String> tags
});


@override $UserCopyWith<$Res>? get authorUser;

}
/// @nodoc
class __$TextPostCopyWithImpl<$Res>
    implements _$TextPostCopyWith<$Res> {
  __$TextPostCopyWithImpl(this._self, this._then);

  final _TextPost _self;
  final $Res Function(_TextPost) _then;

/// Create a copy of TextPost
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? body = null,Object? backgroundColor = null,Object? textColor = null,Object? fontSize = null,Object? fontFamily = freezed,Object? createdAt = freezed,Object? authorId = freezed,Object? authorUser = freezed,Object? likes = null,Object? commentCount = null,Object? shareCount = null,Object? isLikedByCurrentUser = null,Object? isFavorite = null,Object? tags = null,}) {
  return _then(_TextPost(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,backgroundColor: null == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as int,textColor: null == textColor ? _self.textColor : textColor // ignore: cast_nullable_to_non_nullable
as int,fontSize: null == fontSize ? _self.fontSize : fontSize // ignore: cast_nullable_to_non_nullable
as double,fontFamily: freezed == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,authorId: freezed == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String?,authorUser: freezed == authorUser ? _self.authorUser : authorUser // ignore: cast_nullable_to_non_nullable
as User?,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,shareCount: null == shareCount ? _self.shareCount : shareCount // ignore: cast_nullable_to_non_nullable
as int,isLikedByCurrentUser: null == isLikedByCurrentUser ? _self.isLikedByCurrentUser : isLikedByCurrentUser // ignore: cast_nullable_to_non_nullable
as bool,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of TextPost
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get authorUser {
    if (_self.authorUser == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.authorUser!, (value) {
    return _then(_self.copyWith(authorUser: value));
  });
}
}

// dart format on
