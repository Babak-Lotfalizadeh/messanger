// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatViewModel _$ChatViewModelFromJson(Map<String, dynamic> json) =>
    ChatViewModel(
      id: json['id'] as String,
      message: json['message'] as String,
      chatId: json['chatId'] as String,
      sender: json['sender'] as String,
      receiver: json['receiver'] as String,
      received: json['received'] as bool,
      seen: json['seen'] as bool,
      dateTime:
          const TimestampConverter().fromJson(json['dateTime'] as Timestamp),
    );

Map<String, dynamic> _$ChatViewModelToJson(ChatViewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'chatId': instance.chatId,
      'received': instance.received,
      'seen': instance.seen,
      'dateTime': const TimestampConverter().toJson(instance.dateTime),
    };
