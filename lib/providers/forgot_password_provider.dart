import 'dart:async';

import 'package:flutter/material.dart';
import 'package:messenger/firebase/firebase_authentication_service.dart';
import 'package:messenger/providers/teddy_provider.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  late TeddyProvider _teddyProvider;

  final TextEditingController userNameController = TextEditingController();
  final FocusNode userNameFocusNode = FocusNode();

  bool? get validate => formKey.currentState?.validate();

  void init(TeddyProvider teddyProvider) {
    _teddyProvider = teddyProvider;
    userNameController.addListener(_userNameController);
    userNameFocusNode.addListener(_userNameFocusNode);
  }

  void _userNameController() {
    _teddyProvider.setLook(userNameController.text.length.toDouble());
  }

  void _userNameFocusNode() {
    _teddyProvider.setCheck(userNameFocusNode.hasFocus);
  }

  @override
  void dispose() {
    userNameController.removeListener(_userNameController);
    userNameFocusNode.removeListener(_userNameFocusNode);
    super.dispose();
  }

  void removeAllFocuses() {
    userNameFocusNode.unfocus();
  }

  Future<void> forgotPassword({
    void Function(dynamic response)? whenSuccess,
    void Function(String)? whenError,
  }) async {
    removeAllFocuses();

    var response = await FirebaseAuthenticationService().forgotPassword(
      emailAddress: userNameController.text,
    );
    response.fold(
      whenSuccess: (newValue) {
        _teddyProvider.setSuccess().then(
          (value) {
            whenSuccess?.call(true);
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
