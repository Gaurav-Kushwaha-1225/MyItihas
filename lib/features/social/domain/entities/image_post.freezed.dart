// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImagePost {

 String get id; String get imageUrl; String? get caption; String? get location; double get aspectRatio; DateTime? get createdAt; String? get authorId; User? get authorUser; int get likes; int get commentCount; int get shareCount; bool get isLikedByCurrentUser; bool get isFavorite; List<String> get tags;
/// Create a copy of ImagePost
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImagePostCopyWith<ImagePost> get copyWith => _$ImagePostCopyWithImpl<ImagePost>(this as ImagePost, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImagePost&&(identical(other.id, id) || other.id == id)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.location, location) || other.location == location)&&(identical(other.aspectRatio, aspectRatio) || other.aspectRatio == aspectRatio)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.authorUser, authorUser) || other.authorUser == authorUser)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&(identical(other.shareCount, shareCount) || other.shareCount == shareCount)&&(identical(other.isLikedByCurrentUser, isLikedByCurrentUser) || other.isLikedByCurrentUser == isLikedByCurrentUser)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&const DeepCollectionEquality().equals(other.tags, tags));
}


@override
int get hashCode => Object.hash(runtimeType,id,imageUrl,caption,location,aspectRatio,createdAt,authorId,authorUser,likes,commentCount,shareCount,isLikedByCurrentUser,isFavorite,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'ImagePost(id: $id, imageUrl: $imageUrl, caption: $caption, location: $location, aspectRatio: $aspectRatio, createdAt: $createdAt, authorId: $authorId, authorUser: $authorUser, likes: $likes, commentCount: $commentCount, shareCount: $shareCount, isLikedByCurrentUser: $isLikedByCurrentUser, isFavorite: $isFavorite, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $ImagePostCopyWith<$Res>  {
  factory $ImagePostCopyWith(ImagePost value, $Res Function(ImagePost) _then) = _$ImagePostCopyWithImpl;
@useResult
$Res call({
 String id, String imageUrl, String? caption, String? location, double aspectRatio, DateTime? createdAt, String? authorId, User? authorUser, int likes, int commentCount, int shareCount, bool isLikedByCurrentUser, bool isFavorite, List<String> tags
});


$UserCopyWith<$Res>? get authorUser;

}
/// @nodoc
class _$ImagePostCopyWithImpl<$Res>
    implements $ImagePostCopyWith<$Res> {
  _$ImagePostCopyWithImpl(this._self, this._then);

  final ImagePost _self;
  final $Res Function(ImagePost) _then;

/// Create a copy of ImagePost
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? imageUrl = null,Object? caption = freezed,Object? location = freezed,Object? aspectRatio = null,Object? createdAt = freezed,Object? authorId = freezed,Object? authorUser = freezed,Object? likes = null,Object? commentCount = null,Object? shareCount = null,Object? isLikedByCurrentUser = null,Object? isFavorite = null,Object? tags = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,aspectRatio: null == aspectRatio ? _self.aspectRatio : aspectRatio // ignore: cast_nullable_to_non_nullable
as double,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
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
/// Create a copy of ImagePost
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


/// Adds pattern-matching-related methods to [ImagePost].
extension ImagePostPatterns on ImagePost {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImagePost value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImagePost() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImagePost value)  $default,){
final _that = this;
switch (_that) {
case _ImagePost():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImagePost value)?  $default,){
final _that = this;
switch (_that) {
case _ImagePost() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String imageUrl,  String? caption,  String? location,  double aspectRatio,  DateTime? createdAt,  String? authorId,  User? authorUser,  int likes,  int commentCount,  int shareCount,  bool isLikedByCurrentUser,  bool isFavorite,  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImagePost() when $default != null:
return $default(_that.id,_that.imageUrl,_that.caption,_that.location,_that.aspectRatio,_that.createdAt,_that.authorId,_that.authorUser,_that.likes,_that.commentCount,_that.shareCount,_that.isLikedByCurrentUser,_that.isFavorite,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String imageUrl,  String? caption,  String? location,  double aspectRatio,  DateTime? createdAt,  String? authorId,  User? authorUser,  int likes,  int commentCount,  int shareCount,  bool isLikedByCurrentUser,  bool isFavorite,  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _ImagePost():
return $default(_that.id,_that.imageUrl,_that.caption,_that.location,_that.aspectRatio,_that.createdAt,_that.authorId,_that.authorUser,_that.likes,_that.commentCount,_that.shareCount,_that.isLikedByCurrentUser,_that.isFavorite,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String imageUrl,  String? caption,  String? location,  double aspectRatio,  DateTime? createdAt,  String? authorId,  User? authorUser,  int likes,  int commentCount,  int shareCount,  bool isLikedByCurrentUser,  bool isFavorite,  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _ImagePost() when $default != null:
return $default(_that.id,_that.imageUrl,_that.caption,_that.location,_that.aspectRatio,_that.createdAt,_that.authorId,_that.authorUser,_that.likes,_that.commentCount,_that.shareCount,_that.isLikedByCurrentUser,_that.isFavorite,_that.tags);case _:
  return null;

}
}

}

/// @nodoc


class _ImagePost extends ImagePost {
  const _ImagePost({required this.id, required this.imageUrl, this.caption, this.location, this.aspectRatio = 1.0, this.createdAt, this.authorId, this.authorUser, this.likes = 0, this.commentCount = 0, this.shareCount = 0, this.isLikedByCurrentUser = false, this.isFavorite = false, final  List<String> tags = const []}): _tags = tags,super._();
  

@override final  String id;
@override final  String imageUrl;
@override final  String? caption;
@override final  String? location;
@override@JsonKey() final  double aspectRatio;
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


/// Create a copy of ImagePost
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImagePostCopyWith<_ImagePost> get copyWith => __$ImagePostCopyWithImpl<_ImagePost>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImagePost&&(identical(other.id, id) || other.id == id)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.location, location) || other.location == location)&&(identical(other.aspectRatio, aspectRatio) || other.aspectRatio == aspectRatio)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.authorUser, authorUser) || other.authorUser == authorUser)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&(identical(other.shareCount, shareCount) || other.shareCount == shareCount)&&(identical(other.isLikedByCurrentUser, isLikedByCurrentUser) || other.isLikedByCurrentUser == isLikedByCurrentUser)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&const DeepCollectionEquality().equals(other._tags, _tags));
}


@override
int get hashCode => Object.hash(runtimeType,id,imageUrl,caption,location,aspectRatio,createdAt,authorId,authorUser,likes,commentCount,shareCount,isLikedByCurrentUser,isFavorite,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'ImagePost(id: $id, imageUrl: $imageUrl, caption: $caption, location: $location, aspectRatio: $aspectRatio, createdAt: $createdAt, authorId: $authorId, authorUser: $authorUser, likes: $likes, commentCount: $commentCount, shareCount: $shareCount, isLikedByCurrentUser: $isLikedByCurrentUser, isFavorite: $isFavorite, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$ImagePostCopyWith<$Res> implements $ImagePostCopyWith<$Res> {
  factory _$ImagePostCopyWith(_ImagePost value, $Res Function(_ImagePost) _then) = __$ImagePostCopyWithImpl;
@override @useResult
$Res call({
 String id, String imageUrl, String? caption, String? location, double aspectRatio, DateTime? createdAt, String? authorId, User? authorUser, int likes, int commentCount, int shareCount, bool isLikedByCurrentUser, bool isFavorite, List<String> tags
});


@override $UserCopyWith<$Res>? get authorUser;

}
/// @nodoc
class __$ImagePostCopyWithImpl<$Res>
    implements _$ImagePostCopyWith<$Res> {
  __$ImagePostCopyWithImpl(this._self, this._then);

  final _ImagePost _self;
  final $Res Function(_ImagePost) _then;

/// Create a copy of ImagePost
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? imageUrl = null,Object? caption = freezed,Object? location = freezed,Object? aspectRatio = null,Object? createdAt = freezed,Object? authorId = freezed,Object? authorUser = freezed,Object? likes = null,Object? commentCount = null,Object? shareCount = null,Object? isLikedByCurrentUser = null,Object? isFavorite = null,Object? tags = null,}) {
  return _then(_ImagePost(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,aspectRatio: null == aspectRatio ? _self.aspectRatio : aspectRatio // ignore: cast_nullable_to_non_nullable
as double,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
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

/// Create a copy of ImagePost
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
