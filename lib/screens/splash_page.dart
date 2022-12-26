import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/firebase/firebase_authentication_service.dart';
import 'package:messenger/screens/authentication_page.dart';
import 'package:messenger/screens/home_page.dart';
import 'package:messenger/services/navigation_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _handleUser();
    });
  }

  void _handleUser() {
    var currentUser = FirebaseAuthenticationService().currentUser;
    Widget destination = const AuthenticationPage();
    if (currentUser != null) {
      destination = const HomePage();
    }
    NavigationService.pushAndReplace(destination);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: ScreenValues.iconNormal,
          width: ScreenValues.iconNormal,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
