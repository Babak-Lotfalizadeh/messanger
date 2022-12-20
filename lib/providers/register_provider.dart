import 'dart:async';

import 'package:flutter/material.dart';
import 'package:messenger/firebase/firebase_authentication_service.dart';

class RegisterProvider extends ChangeNotifier {
  Timer? timer;
  final formKey = GlobalKey<FormState>();

  bool get check => _check;
  bool _check = false;

  bool get handsUp => _handsUp;
  bool _handsUp = false;

  bool get success => _success;
  bool _success = false;

  bool get fail => _fail;
  bool _fail = false;

  double get look => _look;
  double _look = 0.0;

  final FocusNode userNameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmFocusNode = FocusNode();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  void init() {
    userNameController.addListener(_userNameController);
    userNameFocusNode.addListener(_userNameFocusNode);
    passwordFocusNode.addListener(_passwordFocusNode);
    confirmFocusNode.addListener(_confirmFocusNode);
  }

  void _userNameController() {
    _look = userNameController.text.length.toDouble();
    notifyListeners();
  }

  void _userNameFocusNode() {
    _check = userNameFocusNode.hasFocus;
    notifyListeners();
  }

  void _passwordFocusNode() {
    _handsUp = passwordFocusNode.hasFocus;
    notifyListeners();
  }

  void _confirmFocusNode() {
    _handsUp = confirmFocusNode.hasFocus;
    notifyListeners();
  }

  void setHandUp(bool value) {
    _handsUp = true;
    notifyListeners();
  }

  @override
  void dispose() {
    userNameController.removeListener(_userNameController);
    userNameFocusNode.removeListener(_userNameFocusNode);
    passwordFocusNode.removeListener(_passwordFocusNode);
    confirmFocusNode.removeListener(_confirmFocusNode);
    super.dispose();
  }

  void removeAllFocuses() {
    userNameFocusNode.unfocus();
    passwordFocusNode.unfocus();
    confirmFocusNode.unfocus();
  }

  void validationFailed() {
    _fail = true;
    Future.delayed(const Duration(milliseconds: 500), () {
      _fail = false;
      notifyListeners();
    });
    notifyListeners();
  }

  Future<void> register({
    void Function()? whenSuccess,
    void Function(String)? whenError,
  }) async {
    removeAllFocuses();
    (await FirebaseAuthenticationService().createUserWithEmailAndPassword(
      emailAddress: userNameController.text,
      password: passwordController.text,
    ))
        .fold(
      whenSuccess: (newValue) {
        // var userCredential = (newValue as UserCredential);
        _success = true;
        notifyListeners();
        Future.delayed(const Duration(milliseconds: 500), () {
          _success = false;
          notifyListeners();
          whenSuccess?.call();
        });
      },
      whenError: (newValue) {
        _fail = true;
        notifyListeners();
        whenError?.call(newValue);
        Future.delayed(const Duration(milliseconds: 500), () {
          _fail = false;
          notifyListeners();
        });
      },
    );
  }
}
