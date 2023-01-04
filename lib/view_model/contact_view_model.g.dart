// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactViewModel _$ContactViewModelFromJson(Map<String, dynamic> json) =>
    ContactViewModel(
      id: json['id'] as String,
      title: json['title'] as String,
      chatId: json['chatId'] as String,
      imageAddress: json['imageAddress'] as String?,
    );

Map<String, dynamic> _$ContactViewModelToJson(ContactViewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chatId': instance.chatId,
      'title': instance.title,
      'imageAddress': instance.imageAddress,
    };
