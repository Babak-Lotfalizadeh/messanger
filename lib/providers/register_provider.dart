import 'dart:async';

import 'package:flutter/material.dart';
import 'package:messenger/firebase/firebase_authentication_service.dart';
import 'package:messenger/providers/teddy_provider.dart';

class RegisterProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  late TeddyProvider _teddyProvider;

  final FocusNode userNameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmFocusNode = FocusNode();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  void init(TeddyProvider teddyProvider) {
    _teddyProvider = teddyProvider;
    userNameController.addListener(_userNameController);
    userNameFocusNode.addListener(_userNameFocusNode);
    passwordFocusNode.addListener(_passwordFocusNode);
    confirmFocusNode.addListener(_confirmFocusNode);
  }

  void _userNameController() {
    _teddyProvider.setLook(userNameController.text.length.toDouble());
  }

  void _userNameFocusNode() {
    _teddyProvider.setCheck(userNameFocusNode.hasFocus);
  }

  void _passwordFocusNode() {
    _teddyProvider.setHandsUp(passwordFocusNode.hasFocus);
  }

  void _confirmFocusNode() {
    _teddyProvider.setHandsUp(confirmFocusNode.hasFocus);
  }

  void setHandUp(bool value) {
    _teddyProvider.setHandsUp(true);
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
    _teddyProvider.setFail();
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
        _teddyProvider.setSuccess().then(
          (value) {
            whenSuccess?.call();
          },
        );
      },
      whenError: (newValue) {
        _teddyProvider.setFail().then((value) {
          whenError?.call(newValue);
        });
      },
    );
  }
}
