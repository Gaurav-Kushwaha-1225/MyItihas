// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageModel {

@HiveField(0) String get id;@HiveField(1) String get conversationId;@HiveField(2) String get senderId;@HiveField(3) String get senderName;@HiveField(4) String get senderAvatar;@HiveField(5) String get text;@HiveField(6) DateTime get timestamp;@HiveField(7) MessageDeliveryStatus get deliveryStatus;@HiveField(8) List<String> get readBy;@HiveField(9) String? get sharedStoryId;
/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageModelCopyWith<MessageModel> get copyWith => _$MessageModelCopyWithImpl<MessageModel>(this as MessageModel, _$identity);

  /// Serializes this MessageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.senderAvatar, senderAvatar) || other.senderAvatar == senderAvatar)&&(identical(other.text, text) || other.text == text)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.deliveryStatus, deliveryStatus) || other.deliveryStatus == deliveryStatus)&&const DeepCollectionEquality().equals(other.readBy, readBy)&&(identical(other.sharedStoryId, sharedStoryId) || other.sharedStoryId == sharedStoryId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,conversationId,senderId,senderName,senderAvatar,text,timestamp,deliveryStatus,const DeepCollectionEquality().hash(readBy),sharedStoryId);

@override
String toString() {
  return 'MessageModel(id: $id, conversationId: $conversationId, senderId: $senderId, senderName: $senderName, senderAvatar: $senderAvatar, text: $text, timestamp: $timestamp, deliveryStatus: $deliveryStatus, readBy: $readBy, sharedStoryId: $sharedStoryId)';
}


}

/// @nodoc
abstract mixin class $MessageModelCopyWith<$Res>  {
  factory $MessageModelCopyWith(MessageModel value, $Res Function(MessageModel) _then) = _$MessageModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String conversationId,@HiveField(2) String senderId,@HiveField(3) String senderName,@HiveField(4) String senderAvatar,@HiveField(5) String text,@HiveField(6) DateTime timestamp,@HiveField(7) MessageDeliveryStatus deliveryStatus,@HiveField(8) List<String> readBy,@HiveField(9) String? sharedStoryId
});




}
/// @nodoc
class _$MessageModelCopyWithImpl<$Res>
    implements $MessageModelCopyWith<$Res> {
  _$MessageModelCopyWithImpl(this._self, this._then);

  final MessageModel _self;
  final $Res Function(MessageModel) _then;

/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? conversationId = null,Object? senderId = null,Object? senderName = null,Object? senderAvatar = null,Object? text = null,Object? timestamp = null,Object? deliveryStatus = null,Object? readBy = null,Object? sharedStoryId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,senderAvatar: null == senderAvatar ? _self.senderAvatar : senderAvatar // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,deliveryStatus: null == deliveryStatus ? _self.deliveryStatus : deliveryStatus // ignore: cast_nullable_to_non_nullable
as MessageDeliveryStatus,readBy: null == readBy ? _self.readBy : readBy // ignore: cast_nullable_to_non_nullable
as List<String>,sharedStoryId: freezed == sharedStoryId ? _self.sharedStoryId : sharedStoryId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageModel].
extension MessageModelPatterns on MessageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageModel value)  $default,){
final _that = this;
switch (_that) {
case _MessageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageModel value)?  $default,){
final _that = this;
switch (_that) {
case _MessageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String conversationId, @HiveField(2)  String senderId, @HiveField(3)  String senderName, @HiveField(4)  String senderAvatar, @HiveField(5)  String text, @HiveField(6)  DateTime timestamp, @HiveField(7)  MessageDeliveryStatus deliveryStatus, @HiveField(8)  List<String> readBy, @HiveField(9)  String? sharedStoryId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageModel() when $default != null:
return $default(_that.id,_that.conversationId,_that.senderId,_that.senderName,_that.senderAvatar,_that.text,_that.timestamp,_that.deliveryStatus,_that.readBy,_that.sharedStoryId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String conversationId, @HiveField(2)  String senderId, @HiveField(3)  String senderName, @HiveField(4)  String senderAvatar, @HiveField(5)  String text, @HiveField(6)  DateTime timestamp, @HiveField(7)  MessageDeliveryStatus deliveryStatus, @HiveField(8)  List<String> readBy, @HiveField(9)  String? sharedStoryId)  $default,) {final _that = this;
switch (_that) {
case _MessageModel():
return $default(_that.id,_that.conversationId,_that.senderId,_that.senderName,_that.senderAvatar,_that.text,_that.timestamp,_that.deliveryStatus,_that.readBy,_that.sharedStoryId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String id, @HiveField(1)  String conversationId, @HiveField(2)  String senderId, @HiveField(3)  String senderName, @HiveField(4)  String senderAvatar, @HiveField(5)  String text, @HiveField(6)  DateTime timestamp, @HiveField(7)  MessageDeliveryStatus deliveryStatus, @HiveField(8)  List<String> readBy, @HiveField(9)  String? sharedStoryId)?  $default,) {final _that = this;
switch (_that) {
case _MessageModel() when $default != null:
return $default(_that.id,_that.conversationId,_that.senderId,_that.senderName,_that.senderAvatar,_that.text,_that.timestamp,_that.deliveryStatus,_that.readBy,_that.sharedStoryId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessageModel extends MessageModel {
  const _MessageModel({@HiveField(0) required this.id, @HiveField(1) required this.conversationId, @HiveField(2) required this.senderId, @HiveField(3) required this.senderName, @HiveField(4) required this.senderAvatar, @HiveField(5) required this.text, @HiveField(6) required this.timestamp, @HiveField(7) this.deliveryStatus = MessageDeliveryStatus.sending, @HiveField(8) final  List<String> readBy = const [], @HiveField(9) this.sharedStoryId}): _readBy = readBy,super._();
  factory _MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);

@override@HiveField(0) final  String id;
@override@HiveField(1) final  String conversationId;
@override@HiveField(2) final  String senderId;
@override@HiveField(3) final  String senderName;
@override@HiveField(4) final  String senderAvatar;
@override@HiveField(5) final  String text;
@override@HiveField(6) final  DateTime timestamp;
@override@JsonKey()@HiveField(7) final  MessageDeliveryStatus deliveryStatus;
 final  List<String> _readBy;
@override@JsonKey()@HiveField(8) List<String> get readBy {
  if (_readBy is EqualUnmodifiableListView) return _readBy;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_readBy);
}

@override@HiveField(9) final  String? sharedStoryId;

/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageModelCopyWith<_MessageModel> get copyWith => __$MessageModelCopyWithImpl<_MessageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.senderAvatar, senderAvatar) || other.senderAvatar == senderAvatar)&&(identical(other.text, text) || other.text == text)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.deliveryStatus, deliveryStatus) || other.deliveryStatus == deliveryStatus)&&const DeepCollectionEquality().equals(other._readBy, _readBy)&&(identical(other.sharedStoryId, sharedStoryId) || other.sharedStoryId == sharedStoryId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,conversationId,senderId,senderName,senderAvatar,text,timestamp,deliveryStatus,const DeepCollectionEquality().hash(_readBy),sharedStoryId);

@override
String toString() {
  return 'MessageModel(id: $id, conversationId: $conversationId, senderId: $senderId, senderName: $senderName, senderAvatar: $senderAvatar, text: $text, timestamp: $timestamp, deliveryStatus: $deliveryStatus, readBy: $readBy, sharedStoryId: $sharedStoryId)';
}


}

/// @nodoc
abstract mixin class _$MessageModelCopyWith<$Res> implements $MessageModelCopyWith<$Res> {
  factory _$MessageModelCopyWith(_MessageModel value, $Res Function(_MessageModel) _then) = __$MessageModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String conversationId,@HiveField(2) String senderId,@HiveField(3) String senderName,@HiveField(4) String senderAvatar,@HiveField(5) String text,@HiveField(6) DateTime timestamp,@HiveField(7) MessageDeliveryStatus deliveryStatus,@HiveField(8) List<String> readBy,@HiveField(9) String? sharedStoryId
});




}
/// @nodoc
class __$MessageModelCopyWithImpl<$Res>
    implements _$MessageModelCopyWith<$Res> {
  __$MessageModelCopyWithImpl(this._self, this._then);

  final _MessageModel _self;
  final $Res Function(_MessageModel) _then;

/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? conversationId = null,Object? senderId = null,Object? senderName = null,Object? senderAvatar = null,Object? text = null,Object? timestamp = null,Object? deliveryStatus = null,Object? readBy = null,Object? sharedStoryId = freezed,}) {
  return _then(_MessageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,senderAvatar: null == senderAvatar ? _self.senderAvatar : senderAvatar // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,deliveryStatus: null == deliveryStatus ? _self.deliveryStatus : deliveryStatus // ignore: cast_nullable_to_non_nullable
as MessageDeliveryStatus,readBy: null == readBy ? _self._readBy : readBy // ignore: cast_nullable_to_non_nullable
as List<String>,sharedStoryId: freezed == sharedStoryId ? _self.sharedStoryId : sharedStoryId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
