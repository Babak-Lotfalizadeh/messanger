// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatViewModel _$ChatViewModelFromJson(Map<String, dynamic> json) =>
    ChatViewModel(
      message: json['message'] as String,
      chatId: json['chatId'] as String,
      id: json['id'] as String?,
      sender: json['sender'] as String?,
      send: json['send'] as bool? ?? false,
      received: json['received'] as bool? ?? false,
      seen: json['seen'] as bool? ?? false,
      dateTime: json['dateTime'] as String?,
    );

Map<String, dynamic> _$ChatViewModelToJson(ChatViewModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'chatId': instance.chatId,
      'id': instance.id,
      'sender': instance.sender,
      'dateTime': instance.dateTime,
      'send': instance.send,
      'received': instance.received,
      'seen': instance.seen,
    };
