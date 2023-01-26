import 'package:flutter/material.dart';
import 'package:messenger/firebase/firebase_core_service.dart';
import 'package:messenger/messenger_app.dart';
import 'package:messenger/providers/contacts_provider.dart';
import 'package:messenger/providers/language_provider.dart';
import 'package:messenger/providers/theme_provider.dart';
import 'package:messenger/services/navigation_service.dart';
import 'package:provider/provider.dart';

void main() async {
  NavigationService();
  await FirebaseCoreService.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContactsProvider()..init()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()..init()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()..init()),
      ],
      child: const MessengerApp(),
    ),
  );
}
