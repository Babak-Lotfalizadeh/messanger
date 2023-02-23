import 'package:flutter/material.dart';
import 'package:messenger/firebase/firebase_authentication_service.dart';
import 'package:messenger/firebase/firebase_function_service.dart';
import 'package:messenger/view_model/contact_view_model.dart';
import 'package:messenger/view_model/create_contact_view_model.dart';
import 'package:messenger/view_model/user_view_model.dart';

class ContactsProvider extends ChangeNotifier {
  List<ContactViewModel> get contacts => _contacts;
  List<ContactViewModel> _contacts = [];

  bool get loading => _loading;
  bool _loading = false;

  void init() {
    getContacts();
  }

  void getContacts() async {
    _loading = true;
    notifyListeners();
    _contacts = await FirebaseFunctionService().getContacts() ?? [];
    _loading = false;
    notifyListeners();
  }

  ContactViewModel? getContactThatHaveThisUsers(String? user1, String? user2) {
    for (var contact in _contacts) {
      int matches = 0;
      for (var user in contact.users) {
        matches += ((user.userId == user1) || (user.userId == user2)) ? 1 : 0;
      }
      if (matches >= 2) {
        return contact;
      }
    }
    return null;
  }

  Future<ContactViewModel?> createContact(UserViewModel? userViewModel) async {
    _loading = true;
    notifyListeners();
    var currentUser = FirebaseAuthenticationService().currentUser;
    var result = await FirebaseFunctionService().createContact(
      model: CreateContactViewModel(
        user: userViewModel?.userId ?? "",
      ),
    );
    _contacts = result ?? [];
    _loading = false;
    notifyListeners();
    return getContactThatHaveThisUsers(currentUser?.uid, userViewModel?.userId);
  }
}
