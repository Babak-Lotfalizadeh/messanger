import 'package:flutter/material.dart';
import 'package:messenger/ui/pages/splash_screen.dart';

class MessengerApp extends StatelessWidget {
  const MessengerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messenger',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
