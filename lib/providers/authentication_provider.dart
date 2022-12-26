import 'package:flutter/material.dart';
import 'package:messenger/enums/authentication_status_enum.dart';

class AuthenticationProvider extends ChangeNotifier {
  var _authenticationStatusEnum = AuthenticationStatusEnum.login;
  AuthenticationStatusEnum get authenticationStatusEnum =>
      _authenticationStatusEnum;

  void goLogin() {
    _authenticationStatusEnum = AuthenticationStatusEnum.login;
    notifyListeners();
  }

  void goRegister() {
    _authenticationStatusEnum = AuthenticationStatusEnum.register;
    notifyListeners();
  }

  void goForgetPassword() {
    _authenticationStatusEnum = AuthenticationStatusEnum.forgetPassword;
    notifyListeners();
  }
}
