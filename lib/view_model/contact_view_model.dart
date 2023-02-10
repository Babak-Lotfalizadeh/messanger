import 'package:flutter/cupertino.dart';
import 'package:messenger/firebase/firebase_authentication_service.dart';
import 'package:messenger/view_model/user_view_model.dart';

class ContactViewModel {
  final String chatId;
  final List<UserViewModel> users;
  final String? imageAddress, title;

  const ContactViewModel({
    required this.users,
    required this.chatId,
    this.title,
    this.imageAddress,
  });

  bool get isGroup => title != null;

  String? getTitle() {
    if (title != null) return title;
    try {
      var myUser = FirebaseAuthenticationService().currentUser;
      return users.firstWhere((element) => element.userId != myUser?.uid).name;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  String? getImage() {
    if (imageAddress != null) return imageAddress;
    try {
      var myUser = FirebaseAuthenticationService().currentUser;
      return users
          .firstWhere((element) => element.userId != myUser?.uid)
          .imageURL;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  factory ContactViewModel.fromJson(Map<String, dynamic> json) =>
      ContactViewModel(
        users: (json['users'] as List<dynamic>)
            .map((e) => UserViewModel.fromJson(
                Map<String, dynamic>.from(e as Map<Object?, Object?>)))
            .toList(),
        chatId: json['chatId'] as String,
        title: json['title'] as String?,
        imageAddress: json['imageAddress'] as String?,
      );
}
