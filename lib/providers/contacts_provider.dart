import 'package:flutter/material.dart';
import 'package:messenger/firebase/firebase_authentication_service.dart';
import 'package:messenger/firebase/firebase_fire_store_service.dart';
import 'package:messenger/view_model/contact_view_model.dart';
import 'package:messenger/view_model/user_view_model.dart';

class ContactsProvider extends ChangeNotifier {
  final String? _userId = FirebaseAuthenticationService().currentUser?.uid;

  List<ContactViewModel> get contacts => _contacts;
  List<ContactViewModel> _contacts = [];

  bool get loading => _loading;
  bool _loading = false;

  void init() {
    getContacts();
  }

  void getContacts() {
    FirebaseFireStoreService().getContacts(_userId)?.listen((newValue) {
      _contacts = newValue ?? [];
      notifyListeners();
    });
  }

  Future<ContactViewModel?> createContact(UserViewModel? userViewModel) async {
    _loading = true;
    notifyListeners();
    var result = await FirebaseFireStoreService().createContact(
      userViewModel: userViewModel,
      userId: _userId,
    );
    _loading = false;
    notifyListeners();
    return result;
  }
}
