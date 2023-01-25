// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserViewModel _$UserViewModelFromJson(Map<String, dynamic> json) =>
    UserViewModel(
      userId: json['userId'] as String,
      email: json['email'] as String,
      imageURL: json['imageURL'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$UserViewModelToJson(UserViewModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'imageURL': instance.imageURL,
      'name': instance.name,
    };
