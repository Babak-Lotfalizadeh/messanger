import 'package:flutter/material.dart';
import 'package:messenger/firebase/firebase_fire_store_service.dart';
import 'package:messenger/view_model/user_view_model.dart';

class UsersProvider extends ChangeNotifier {
  List<UserViewModel> get users => _users;
  List<UserViewModel> _users = [];

  void init() {
    getUsers();
  }

  void getUsers() {
    FirebaseFireStoreService().getUsers()?.listen((newValue) {
      _users = newValue ?? [];
      notifyListeners();
    });
  }
}
