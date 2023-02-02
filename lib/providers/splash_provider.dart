import 'package:flutter/material.dart';
import 'package:messenger/firebase/firebase_authentication_service.dart';
import 'package:messenger/firebase/firebase_fire_store_service.dart';
import 'package:messenger/firebase/firebase_messaging_service.dart';
import 'package:messenger/screens/authentication_page.dart';
import 'package:messenger/screens/main_page.dart';

class SplashProvider extends ChangeNotifier {
  var currentUser = FirebaseAuthenticationService().currentUser;

  bool _weHaveUser() {
    return currentUser != null;
  }

  Future<void> _handleUserToken() async {
    await FirebaseMessagingService().setup((token) {
      FirebaseFireStoreService().setNewUser(
        fcmToken: token,
        user: currentUser,
      );
    });
  }

  void init(Function(Widget nextPage) onFinishLoading) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (_weHaveUser()) {
        await _handleUserToken();
        onFinishLoading(const MainPage());
      } else {
        onFinishLoading(const AuthenticationPage());
      }
    });
  }
}
