import 'package:flutter/material.dart';
import 'package:messenger/firebase/firebase_authentication_service.dart';
import 'package:messenger/screens/home_page.dart';
import 'package:messenger/screens/login_screen.dart';
import 'package:messenger/services/navigation_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _handleUser();
    });
  }

  void _handleUser() {
    var currentUser = FirebaseAuthenticationService().currentUser;
    Widget destination = const LoginScreen();
    if (currentUser != null) {
      destination = const HomePage();
    }
    NavigationService.pushAndReplace(destination);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
