// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'user_view_model.g.dart';

@JsonSerializable()
class UserViewModel {
  final String userId, email, imageURL, name, fcmToken;

  UserViewModel({
    required this.userId,
    required this.email,
    required this.imageURL,
    required this.name,
    required this.fcmToken,
  });

  factory UserViewModel.fromJson(Map<String, dynamic> json) =>
      _$UserViewModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserViewModelToJson(this);
}
