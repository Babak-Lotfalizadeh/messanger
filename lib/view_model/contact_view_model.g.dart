// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactViewModel _$ContactViewModelFromJson(Map<String, dynamic> json) =>
    ContactViewModel(
      userId: json['userId'] as String,
      contactId: json['contactId'] as String,
      title: json['title'] as String,
      chatId: json['chatId'] as String,
      imageAddress: json['imageAddress'] as String?,
    );

Map<String, dynamic> _$ContactViewModelToJson(ContactViewModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'chatId': instance.chatId,
      'title': instance.title,
      'contactId': instance.contactId,
      'imageAddress': instance.imageAddress,
    };
