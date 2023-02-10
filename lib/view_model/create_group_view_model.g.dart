// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_group_view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateGroupViewModel _$CreateGroupViewModelFromJson(
        Map<String, dynamic> json) =>
    CreateGroupViewModel(
      users: (json['users'] as List<dynamic>).map((e) => e as String).toList(),
      imageAddress: json['imageAddress'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$CreateGroupViewModelToJson(
        CreateGroupViewModel instance) =>
    <String, dynamic>{
      'users': instance.users,
      'imageAddress': instance.imageAddress,
      'title': instance.title,
    };
