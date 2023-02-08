import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/enums/loading_update_user_enum.dart';
import 'package:messenger/enums/update_user_enum.dart';
import 'package:messenger/firebase/firebase_authentication_service.dart';
import 'package:messenger/firebase/firebase_storage_service.dart';

class UserInformationProvider extends ChangeNotifier {
  String? get photoUrl => _photoUrl;
  String? _photoUrl;

  User? get user => _user;
  User? _user;

  LoadingUpdateUserEnum? get loading => _loading;
  LoadingUpdateUserEnum? _loading;

  final TextEditingController displayNameController = TextEditingController();

  void init() {
    getUsers();
  }

  void getUsers() {
    FirebaseAuthenticationService().auth?.userChanges().listen((event) {
      _user = event;
      displayNameController.text = _user?.displayName ?? "";
      notifyListeners();
    });
  }

  Future<void> editImage(File? file) async {
    _loading = LoadingUpdateUserEnum.image;
    notifyListeners();
    await _upload(file);
    _loading = null;
    notifyListeners();
  }

  Future<void> save() async {
    if (_loading != null) return;
    if (displayNameController.text.isEmpty) {
      throw Exception(UpdateUserEnum.displayName);
    }

    await FirebaseAuthenticationService().updateUserImage(_photoUrl);
    await FirebaseAuthenticationService().updateUserDisplayName(
      displayNameController.text,
    );
  }

  Future<void> _upload(File? file) async {
    var userId = FirebaseAuthenticationService().currentUser;
    _photoUrl = await FirebaseStorageService().upload(
      file: File(file?.path ?? ""),
      key: userId?.uid ?? "",
    );
  }
}
