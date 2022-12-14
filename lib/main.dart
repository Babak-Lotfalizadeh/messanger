import 'package:flutter/material.dart';
import 'package:messenger/messenger_app.dart';
import 'package:messenger/providers/language_provider.dart';
import 'package:messenger/providers/theme_provider.dart';
import 'package:messenger/services/navigation_service.dart';
import 'package:messenger/services/snack_bar_service.dart';
import 'package:provider/provider.dart';

void main() {
  NavigationService();
  SnackBarService();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()..init()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()..init()),
      ],
      child: const MessengerApp(),
    ),
  );
}
