// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommentModel {

@HiveField(0) String get id;@HiveField(1) String get storyId;@HiveField(2) String get userId;@HiveField(3) String get userName;@HiveField(4) String get userAvatar;@HiveField(5) String get text;@HiveField(6) DateTime get timestamp;@HiveField(7) int get likeCount;@HiveField(8) String? get parentCommentId;@HiveField(9) List<CommentModel> get replies;@HiveField(10) int get depth;@HiveField(11) bool get isCollapsed;@HiveField(12) bool get isLikedByCurrentUser;
/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentModelCopyWith<CommentModel> get copyWith => _$CommentModelCopyWithImpl<CommentModel>(this as CommentModel, _$identity);

  /// Serializes this CommentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userAvatar, userAvatar) || other.userAvatar == userAvatar)&&(identical(other.text, text) || other.text == text)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.parentCommentId, parentCommentId) || other.parentCommentId == parentCommentId)&&const DeepCollectionEquality().equals(other.replies, replies)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.isCollapsed, isCollapsed) || other.isCollapsed == isCollapsed)&&(identical(other.isLikedByCurrentUser, isLikedByCurrentUser) || other.isLikedByCurrentUser == isLikedByCurrentUser));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,storyId,userId,userName,userAvatar,text,timestamp,likeCount,parentCommentId,const DeepCollectionEquality().hash(replies),depth,isCollapsed,isLikedByCurrentUser);

@override
String toString() {
  return 'CommentModel(id: $id, storyId: $storyId, userId: $userId, userName: $userName, userAvatar: $userAvatar, text: $text, timestamp: $timestamp, likeCount: $likeCount, parentCommentId: $parentCommentId, replies: $replies, depth: $depth, isCollapsed: $isCollapsed, isLikedByCurrentUser: $isLikedByCurrentUser)';
}


}

/// @nodoc
abstract mixin class $CommentModelCopyWith<$Res>  {
  factory $CommentModelCopyWith(CommentModel value, $Res Function(CommentModel) _then) = _$CommentModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String storyId,@HiveField(2) String userId,@HiveField(3) String userName,@HiveField(4) String userAvatar,@HiveField(5) String text,@HiveField(6) DateTime timestamp,@HiveField(7) int likeCount,@HiveField(8) String? parentCommentId,@HiveField(9) List<CommentModel> replies,@HiveField(10) int depth,@HiveField(11) bool isCollapsed,@HiveField(12) bool isLikedByCurrentUser
});




}
/// @nodoc
class _$CommentModelCopyWithImpl<$Res>
    implements $CommentModelCopyWith<$Res> {
  _$CommentModelCopyWithImpl(this._self, this._then);

  final CommentModel _self;
  final $Res Function(CommentModel) _then;

/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? storyId = null,Object? userId = null,Object? userName = null,Object? userAvatar = null,Object? text = null,Object? timestamp = null,Object? likeCount = null,Object? parentCommentId = freezed,Object? replies = null,Object? depth = null,Object? isCollapsed = null,Object? isLikedByCurrentUser = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userAvatar: null == userAvatar ? _self.userAvatar : userAvatar // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,parentCommentId: freezed == parentCommentId ? _self.parentCommentId : parentCommentId // ignore: cast_nullable_to_non_nullable
as String?,replies: null == replies ? _self.replies : replies // ignore: cast_nullable_to_non_nullable
as List<CommentModel>,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int,isCollapsed: null == isCollapsed ? _self.isCollapsed : isCollapsed // ignore: cast_nullable_to_non_nullable
as bool,isLikedByCurrentUser: null == isLikedByCurrentUser ? _self.isLikedByCurrentUser : isLikedByCurrentUser // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentModel].
extension CommentModelPatterns on CommentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentModel value)  $default,){
final _that = this;
switch (_that) {
case _CommentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentModel value)?  $default,){
final _that = this;
switch (_that) {
case _CommentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String storyId, @HiveField(2)  String userId, @HiveField(3)  String userName, @HiveField(4)  String userAvatar, @HiveField(5)  String text, @HiveField(6)  DateTime timestamp, @HiveField(7)  int likeCount, @HiveField(8)  String? parentCommentId, @HiveField(9)  List<CommentModel> replies, @HiveField(10)  int depth, @HiveField(11)  bool isCollapsed, @HiveField(12)  bool isLikedByCurrentUser)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentModel() when $default != null:
return $default(_that.id,_that.storyId,_that.userId,_that.userName,_that.userAvatar,_that.text,_that.timestamp,_that.likeCount,_that.parentCommentId,_that.replies,_that.depth,_that.isCollapsed,_that.isLikedByCurrentUser);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String storyId, @HiveField(2)  String userId, @HiveField(3)  String userName, @HiveField(4)  String userAvatar, @HiveField(5)  String text, @HiveField(6)  DateTime timestamp, @HiveField(7)  int likeCount, @HiveField(8)  String? parentCommentId, @HiveField(9)  List<CommentModel> replies, @HiveField(10)  int depth, @HiveField(11)  bool isCollapsed, @HiveField(12)  bool isLikedByCurrentUser)  $default,) {final _that = this;
switch (_that) {
case _CommentModel():
return $default(_that.id,_that.storyId,_that.userId,_that.userName,_that.userAvatar,_that.text,_that.timestamp,_that.likeCount,_that.parentCommentId,_that.replies,_that.depth,_that.isCollapsed,_that.isLikedByCurrentUser);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String id, @HiveField(1)  String storyId, @HiveField(2)  String userId, @HiveField(3)  String userName, @HiveField(4)  String userAvatar, @HiveField(5)  String text, @HiveField(6)  DateTime timestamp, @HiveField(7)  int likeCount, @HiveField(8)  String? parentCommentId, @HiveField(9)  List<CommentModel> replies, @HiveField(10)  int depth, @HiveField(11)  bool isCollapsed, @HiveField(12)  bool isLikedByCurrentUser)?  $default,) {final _that = this;
switch (_that) {
case _CommentModel() when $default != null:
return $default(_that.id,_that.storyId,_that.userId,_that.userName,_that.userAvatar,_that.text,_that.timestamp,_that.likeCount,_that.parentCommentId,_that.replies,_that.depth,_that.isCollapsed,_that.isLikedByCurrentUser);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentModel extends CommentModel {
  const _CommentModel({@HiveField(0) required this.id, @HiveField(1) required this.storyId, @HiveField(2) required this.userId, @HiveField(3) required this.userName, @HiveField(4) required this.userAvatar, @HiveField(5) required this.text, @HiveField(6) required this.timestamp, @HiveField(7) this.likeCount = 0, @HiveField(8) this.parentCommentId, @HiveField(9) final  List<CommentModel> replies = const [], @HiveField(10) this.depth = 0, @HiveField(11) this.isCollapsed = false, @HiveField(12) this.isLikedByCurrentUser = false}): _replies = replies,super._();
  factory _CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);

@override@HiveField(0) final  String id;
@override@HiveField(1) final  String storyId;
@override@HiveField(2) final  String userId;
@override@HiveField(3) final  String userName;
@override@HiveField(4) final  String userAvatar;
@override@HiveField(5) final  String text;
@override@HiveField(6) final  DateTime timestamp;
@override@JsonKey()@HiveField(7) final  int likeCount;
@override@HiveField(8) final  String? parentCommentId;
 final  List<CommentModel> _replies;
@override@JsonKey()@HiveField(9) List<CommentModel> get replies {
  if (_replies is EqualUnmodifiableListView) return _replies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_replies);
}

@override@JsonKey()@HiveField(10) final  int depth;
@override@JsonKey()@HiveField(11) final  bool isCollapsed;
@override@JsonKey()@HiveField(12) final  bool isLikedByCurrentUser;

/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentModelCopyWith<_CommentModel> get copyWith => __$CommentModelCopyWithImpl<_CommentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userAvatar, userAvatar) || other.userAvatar == userAvatar)&&(identical(other.text, text) || other.text == text)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.parentCommentId, parentCommentId) || other.parentCommentId == parentCommentId)&&const DeepCollectionEquality().equals(other._replies, _replies)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.isCollapsed, isCollapsed) || other.isCollapsed == isCollapsed)&&(identical(other.isLikedByCurrentUser, isLikedByCurrentUser) || other.isLikedByCurrentUser == isLikedByCurrentUser));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,storyId,userId,userName,userAvatar,text,timestamp,likeCount,parentCommentId,const DeepCollectionEquality().hash(_replies),depth,isCollapsed,isLikedByCurrentUser);

@override
String toString() {
  return 'CommentModel(id: $id, storyId: $storyId, userId: $userId, userName: $userName, userAvatar: $userAvatar, text: $text, timestamp: $timestamp, likeCount: $likeCount, parentCommentId: $parentCommentId, replies: $replies, depth: $depth, isCollapsed: $isCollapsed, isLikedByCurrentUser: $isLikedByCurrentUser)';
}


}

/// @nodoc
abstract mixin class _$CommentModelCopyWith<$Res> implements $CommentModelCopyWith<$Res> {
  factory _$CommentModelCopyWith(_CommentModel value, $Res Function(_CommentModel) _then) = __$CommentModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String storyId,@HiveField(2) String userId,@HiveField(3) String userName,@HiveField(4) String userAvatar,@HiveField(5) String text,@HiveField(6) DateTime timestamp,@HiveField(7) int likeCount,@HiveField(8) String? parentCommentId,@HiveField(9) List<CommentModel> replies,@HiveField(10) int depth,@HiveField(11) bool isCollapsed,@HiveField(12) bool isLikedByCurrentUser
});




}
/// @nodoc
class __$CommentModelCopyWithImpl<$Res>
    implements _$CommentModelCopyWith<$Res> {
  __$CommentModelCopyWithImpl(this._self, this._then);

  final _CommentModel _self;
  final $Res Function(_CommentModel) _then;

/// Create a copy of CommentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? storyId = null,Object? userId = null,Object? userName = null,Object? userAvatar = null,Object? text = null,Object? timestamp = null,Object? likeCount = null,Object? parentCommentId = freezed,Object? replies = null,Object? depth = null,Object? isCollapsed = null,Object? isLikedByCurrentUser = null,}) {
  return _then(_CommentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userAvatar: null == userAvatar ? _self.userAvatar : userAvatar // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,likeCount: null == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int,parentCommentId: freezed == parentCommentId ? _self.parentCommentId : parentCommentId // ignore: cast_nullable_to_non_nullable
as String?,replies: null == replies ? _self._replies : replies // ignore: cast_nullable_to_non_nullable
as List<CommentModel>,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as int,isCollapsed: null == isCollapsed ? _self.isCollapsed : isCollapsed // ignore: cast_nullable_to_non_nullable
as bool,isLikedByCurrentUser: null == isLikedByCurrentUser ? _self.isLikedByCurrentUser : isLikedByCurrentUser // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
