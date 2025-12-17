// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_detail_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatDetailEvent {

 String get conversationId;
/// Create a copy of ChatDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatDetailEventCopyWith<ChatDetailEvent> get copyWith => _$ChatDetailEventCopyWithImpl<ChatDetailEvent>(this as ChatDetailEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatDetailEvent&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId);

@override
String toString() {
  return 'ChatDetailEvent(conversationId: $conversationId)';
}


}

/// @nodoc
abstract mixin class $ChatDetailEventCopyWith<$Res>  {
  factory $ChatDetailEventCopyWith(ChatDetailEvent value, $Res Function(ChatDetailEvent) _then) = _$ChatDetailEventCopyWithImpl;
@useResult
$Res call({
 String conversationId
});




}
/// @nodoc
class _$ChatDetailEventCopyWithImpl<$Res>
    implements $ChatDetailEventCopyWith<$Res> {
  _$ChatDetailEventCopyWithImpl(this._self, this._then);

  final ChatDetailEvent _self;
  final $Res Function(ChatDetailEvent) _then;

/// Create a copy of ChatDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? conversationId = null,}) {
  return _then(_self.copyWith(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatDetailEvent].
extension ChatDetailEventPatterns on ChatDetailEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadMessagesEvent value)?  loadMessages,TResult Function( SendMessageEvent value)?  sendMessage,TResult Function( SendStoryMessageEvent value)?  sendStoryMessage,TResult Function( MarkAsReadEvent value)?  markAsRead,TResult Function( TypingStartedEvent value)?  typingStarted,TResult Function( TypingStoppedEvent value)?  typingStopped,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadMessagesEvent() when loadMessages != null:
return loadMessages(_that);case SendMessageEvent() when sendMessage != null:
return sendMessage(_that);case SendStoryMessageEvent() when sendStoryMessage != null:
return sendStoryMessage(_that);case MarkAsReadEvent() when markAsRead != null:
return markAsRead(_that);case TypingStartedEvent() when typingStarted != null:
return typingStarted(_that);case TypingStoppedEvent() when typingStopped != null:
return typingStopped(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadMessagesEvent value)  loadMessages,required TResult Function( SendMessageEvent value)  sendMessage,required TResult Function( SendStoryMessageEvent value)  sendStoryMessage,required TResult Function( MarkAsReadEvent value)  markAsRead,required TResult Function( TypingStartedEvent value)  typingStarted,required TResult Function( TypingStoppedEvent value)  typingStopped,}){
final _that = this;
switch (_that) {
case LoadMessagesEvent():
return loadMessages(_that);case SendMessageEvent():
return sendMessage(_that);case SendStoryMessageEvent():
return sendStoryMessage(_that);case MarkAsReadEvent():
return markAsRead(_that);case TypingStartedEvent():
return typingStarted(_that);case TypingStoppedEvent():
return typingStopped(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadMessagesEvent value)?  loadMessages,TResult? Function( SendMessageEvent value)?  sendMessage,TResult? Function( SendStoryMessageEvent value)?  sendStoryMessage,TResult? Function( MarkAsReadEvent value)?  markAsRead,TResult? Function( TypingStartedEvent value)?  typingStarted,TResult? Function( TypingStoppedEvent value)?  typingStopped,}){
final _that = this;
switch (_that) {
case LoadMessagesEvent() when loadMessages != null:
return loadMessages(_that);case SendMessageEvent() when sendMessage != null:
return sendMessage(_that);case SendStoryMessageEvent() when sendStoryMessage != null:
return sendStoryMessage(_that);case MarkAsReadEvent() when markAsRead != null:
return markAsRead(_that);case TypingStartedEvent() when typingStarted != null:
return typingStarted(_that);case TypingStoppedEvent() when typingStopped != null:
return typingStopped(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String conversationId)?  loadMessages,TResult Function( String conversationId,  String text)?  sendMessage,TResult Function( String conversationId,  String storyId)?  sendStoryMessage,TResult Function( String conversationId,  List<String> messageIds)?  markAsRead,TResult Function( String conversationId)?  typingStarted,TResult Function( String conversationId)?  typingStopped,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadMessagesEvent() when loadMessages != null:
return loadMessages(_that.conversationId);case SendMessageEvent() when sendMessage != null:
return sendMessage(_that.conversationId,_that.text);case SendStoryMessageEvent() when sendStoryMessage != null:
return sendStoryMessage(_that.conversationId,_that.storyId);case MarkAsReadEvent() when markAsRead != null:
return markAsRead(_that.conversationId,_that.messageIds);case TypingStartedEvent() when typingStarted != null:
return typingStarted(_that.conversationId);case TypingStoppedEvent() when typingStopped != null:
return typingStopped(_that.conversationId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String conversationId)  loadMessages,required TResult Function( String conversationId,  String text)  sendMessage,required TResult Function( String conversationId,  String storyId)  sendStoryMessage,required TResult Function( String conversationId,  List<String> messageIds)  markAsRead,required TResult Function( String conversationId)  typingStarted,required TResult Function( String conversationId)  typingStopped,}) {final _that = this;
switch (_that) {
case LoadMessagesEvent():
return loadMessages(_that.conversationId);case SendMessageEvent():
return sendMessage(_that.conversationId,_that.text);case SendStoryMessageEvent():
return sendStoryMessage(_that.conversationId,_that.storyId);case MarkAsReadEvent():
return markAsRead(_that.conversationId,_that.messageIds);case TypingStartedEvent():
return typingStarted(_that.conversationId);case TypingStoppedEvent():
return typingStopped(_that.conversationId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String conversationId)?  loadMessages,TResult? Function( String conversationId,  String text)?  sendMessage,TResult? Function( String conversationId,  String storyId)?  sendStoryMessage,TResult? Function( String conversationId,  List<String> messageIds)?  markAsRead,TResult? Function( String conversationId)?  typingStarted,TResult? Function( String conversationId)?  typingStopped,}) {final _that = this;
switch (_that) {
case LoadMessagesEvent() when loadMessages != null:
return loadMessages(_that.conversationId);case SendMessageEvent() when sendMessage != null:
return sendMessage(_that.conversationId,_that.text);case SendStoryMessageEvent() when sendStoryMessage != null:
return sendStoryMessage(_that.conversationId,_that.storyId);case MarkAsReadEvent() when markAsRead != null:
return markAsRead(_that.conversationId,_that.messageIds);case TypingStartedEvent() when typingStarted != null:
return typingStarted(_that.conversationId);case TypingStoppedEvent() when typingStopped != null:
return typingStopped(_that.conversationId);case _:
  return null;

}
}

}

/// @nodoc


class LoadMessagesEvent implements ChatDetailEvent {
  const LoadMessagesEvent(this.conversationId);
  

@override final  String conversationId;

/// Create a copy of ChatDetailEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadMessagesEventCopyWith<LoadMessagesEvent> get copyWith => _$LoadMessagesEventCopyWithImpl<LoadMessagesEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadMessagesEvent&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId);

@override
String toString() {
  return 'ChatDetailEvent.loadMessages(conversationId: $conversationId)';
}


}

/// @nodoc
abstract mixin class $LoadMessagesEventCopyWith<$Res> implements $ChatDetailEventCopyWith<$Res> {
  factory $LoadMessagesEventCopyWith(LoadMessagesEvent value, $Res Function(LoadMessagesEvent) _then) = _$LoadMessagesEventCopyWithImpl;
@override @useResult
$Res call({
 String conversationId
});




}
/// @nodoc
class _$LoadMessagesEventCopyWithImpl<$Res>
    implements $LoadMessagesEventCopyWith<$Res> {
  _$LoadMessagesEventCopyWithImpl(this._self, this._then);

  final LoadMessagesEvent _self;
  final $Res Function(LoadMessagesEvent) _then;

/// Create a copy of ChatDetailEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conversationId = null,}) {
  return _then(LoadMessagesEvent(
null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SendMessageEvent implements ChatDetailEvent {
  const SendMessageEvent({required this.conversationId, required this.text});
  

@override final  String conversationId;
 final  String text;

/// Create a copy of ChatDetailEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendMessageEventCopyWith<SendMessageEvent> get copyWith => _$SendMessageEventCopyWithImpl<SendMessageEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendMessageEvent&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,text);

@override
String toString() {
  return 'ChatDetailEvent.sendMessage(conversationId: $conversationId, text: $text)';
}


}

/// @nodoc
abstract mixin class $SendMessageEventCopyWith<$Res> implements $ChatDetailEventCopyWith<$Res> {
  factory $SendMessageEventCopyWith(SendMessageEvent value, $Res Function(SendMessageEvent) _then) = _$SendMessageEventCopyWithImpl;
@override @useResult
$Res call({
 String conversationId, String text
});




}
/// @nodoc
class _$SendMessageEventCopyWithImpl<$Res>
    implements $SendMessageEventCopyWith<$Res> {
  _$SendMessageEventCopyWithImpl(this._self, this._then);

  final SendMessageEvent _self;
  final $Res Function(SendMessageEvent) _then;

/// Create a copy of ChatDetailEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? text = null,}) {
  return _then(SendMessageEvent(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SendStoryMessageEvent implements ChatDetailEvent {
  const SendStoryMessageEvent({required this.conversationId, required this.storyId});
  

@override final  String conversationId;
 final  String storyId;

/// Create a copy of ChatDetailEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendStoryMessageEventCopyWith<SendStoryMessageEvent> get copyWith => _$SendStoryMessageEventCopyWithImpl<SendStoryMessageEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendStoryMessageEvent&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.storyId, storyId) || other.storyId == storyId));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,storyId);

@override
String toString() {
  return 'ChatDetailEvent.sendStoryMessage(conversationId: $conversationId, storyId: $storyId)';
}


}

/// @nodoc
abstract mixin class $SendStoryMessageEventCopyWith<$Res> implements $ChatDetailEventCopyWith<$Res> {
  factory $SendStoryMessageEventCopyWith(SendStoryMessageEvent value, $Res Function(SendStoryMessageEvent) _then) = _$SendStoryMessageEventCopyWithImpl;
@override @useResult
$Res call({
 String conversationId, String storyId
});




}
/// @nodoc
class _$SendStoryMessageEventCopyWithImpl<$Res>
    implements $SendStoryMessageEventCopyWith<$Res> {
  _$SendStoryMessageEventCopyWithImpl(this._self, this._then);

  final SendStoryMessageEvent _self;
  final $Res Function(SendStoryMessageEvent) _then;

/// Create a copy of ChatDetailEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? storyId = null,}) {
  return _then(SendStoryMessageEvent(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class MarkAsReadEvent implements ChatDetailEvent {
  const MarkAsReadEvent({required this.conversationId, required final  List<String> messageIds}): _messageIds = messageIds;
  

@override final  String conversationId;
 final  List<String> _messageIds;
 List<String> get messageIds {
  if (_messageIds is EqualUnmodifiableListView) return _messageIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messageIds);
}


/// Create a copy of ChatDetailEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarkAsReadEventCopyWith<MarkAsReadEvent> get copyWith => _$MarkAsReadEventCopyWithImpl<MarkAsReadEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarkAsReadEvent&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&const DeepCollectionEquality().equals(other._messageIds, _messageIds));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId,const DeepCollectionEquality().hash(_messageIds));

@override
String toString() {
  return 'ChatDetailEvent.markAsRead(conversationId: $conversationId, messageIds: $messageIds)';
}


}

/// @nodoc
abstract mixin class $MarkAsReadEventCopyWith<$Res> implements $ChatDetailEventCopyWith<$Res> {
  factory $MarkAsReadEventCopyWith(MarkAsReadEvent value, $Res Function(MarkAsReadEvent) _then) = _$MarkAsReadEventCopyWithImpl;
@override @useResult
$Res call({
 String conversationId, List<String> messageIds
});




}
/// @nodoc
class _$MarkAsReadEventCopyWithImpl<$Res>
    implements $MarkAsReadEventCopyWith<$Res> {
  _$MarkAsReadEventCopyWithImpl(this._self, this._then);

  final MarkAsReadEvent _self;
  final $Res Function(MarkAsReadEvent) _then;

/// Create a copy of ChatDetailEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conversationId = null,Object? messageIds = null,}) {
  return _then(MarkAsReadEvent(
conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,messageIds: null == messageIds ? _self._messageIds : messageIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class TypingStartedEvent implements ChatDetailEvent {
  const TypingStartedEvent(this.conversationId);
  

@override final  String conversationId;

/// Create a copy of ChatDetailEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TypingStartedEventCopyWith<TypingStartedEvent> get copyWith => _$TypingStartedEventCopyWithImpl<TypingStartedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TypingStartedEvent&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId);

@override
String toString() {
  return 'ChatDetailEvent.typingStarted(conversationId: $conversationId)';
}


}

/// @nodoc
abstract mixin class $TypingStartedEventCopyWith<$Res> implements $ChatDetailEventCopyWith<$Res> {
  factory $TypingStartedEventCopyWith(TypingStartedEvent value, $Res Function(TypingStartedEvent) _then) = _$TypingStartedEventCopyWithImpl;
@override @useResult
$Res call({
 String conversationId
});




}
/// @nodoc
class _$TypingStartedEventCopyWithImpl<$Res>
    implements $TypingStartedEventCopyWith<$Res> {
  _$TypingStartedEventCopyWithImpl(this._self, this._then);

  final TypingStartedEvent _self;
  final $Res Function(TypingStartedEvent) _then;

/// Create a copy of ChatDetailEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conversationId = null,}) {
  return _then(TypingStartedEvent(
null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TypingStoppedEvent implements ChatDetailEvent {
  const TypingStoppedEvent(this.conversationId);
  

@override final  String conversationId;

/// Create a copy of ChatDetailEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TypingStoppedEventCopyWith<TypingStoppedEvent> get copyWith => _$TypingStoppedEventCopyWithImpl<TypingStoppedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TypingStoppedEvent&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId);

@override
String toString() {
  return 'ChatDetailEvent.typingStopped(conversationId: $conversationId)';
}


}

/// @nodoc
abstract mixin class $TypingStoppedEventCopyWith<$Res> implements $ChatDetailEventCopyWith<$Res> {
  factory $TypingStoppedEventCopyWith(TypingStoppedEvent value, $Res Function(TypingStoppedEvent) _then) = _$TypingStoppedEventCopyWithImpl;
@override @useResult
$Res call({
 String conversationId
});




}
/// @nodoc
class _$TypingStoppedEventCopyWithImpl<$Res>
    implements $TypingStoppedEventCopyWith<$Res> {
  _$TypingStoppedEventCopyWithImpl(this._self, this._then);

  final TypingStoppedEvent _self;
  final $Res Function(TypingStoppedEvent) _then;

/// Create a copy of ChatDetailEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conversationId = null,}) {
  return _then(TypingStoppedEvent(
null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
