import 'package:flutter/material.dart';
import 'package:messenger/providers/language_provider.dart';
import 'package:messenger/providers/theme_provider.dart';
import 'package:messenger/screens/splash_page.dart';
import 'package:messenger/services/navigation_service.dart';
import 'package:messenger/utilities/imports.dart';
import 'package:provider/provider.dart';

class MessengerApp extends StatelessWidget {
  const MessengerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messenger',
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context)?.appName ?? "",
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: context.watch<LanguageProvider>().locale,
      theme: context.watch<ThemeProvider>().themeData,
      darkTheme: context.watch<ThemeProvider>().darkThemeData,
      themeMode: context.watch<ThemeProvider>().themeMode,
      navigatorKey: NavigationService.navigatorKey,
      home: const SplashPage(),
    );
  }
}
