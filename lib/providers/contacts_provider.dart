import 'package:flutter/material.dart';
import 'package:messenger/firebase/firebase_authentication_service.dart';
import 'package:messenger/firebase/firebase_database_service.dart';
import 'package:messenger/view_model/contact_view_model.dart';

class ContactsProvider extends ChangeNotifier {
  final String? _userId = FirebaseAuthenticationService().currentUser?.uid;

  List<ContactViewModel> get contacts => _contacts;
  List<ContactViewModel> _contacts = [];

  void init() {
    getContacts();
  }

  void getContacts() {
    FirebaseDatabaseService().getContacts(_userId)?.listen((newValue) {
      _contacts = newValue ?? [];
      notifyListeners();
    });
  }
}
