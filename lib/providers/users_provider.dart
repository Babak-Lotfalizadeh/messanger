import 'package:flutter/material.dart';
import 'package:messenger/firebase/firebase_function_service.dart';
import 'package:messenger/view_model/user_view_model.dart';

class UsersProvider extends ChangeNotifier {
  List<UserViewModel> get users => _users;
  List<UserViewModel> _users = [];

  bool get loading => _loading;
  bool _loading = false;

  void init() {
    getUsers();
  }

  Future<void> getUsers() async {
    _loading = true;
    notifyListeners();
    _users = await FirebaseFunctionService().getUsers() ?? [];
    _loading = false;
    notifyListeners();
  }
}
