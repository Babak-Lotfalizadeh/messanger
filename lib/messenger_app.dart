import 'package:flutter/material.dart';
import 'package:messenger/providers/language_provider.dart';
import 'package:messenger/providers/theme_provider.dart';
import 'package:messenger/screens/setting_screen.dart';
import 'package:messenger/services/navigation_service.dart';
import 'package:messenger/services/snack_bar_service.dart';
import 'package:messenger/utilities/imports.dart';
import 'package:provider/provider.dart';

class MessengerApp extends StatelessWidget {
  const MessengerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messenger',
      onGenerateTitle: (context) => AppLocalizations.of(context)?.appName ?? "",
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: context.watch<LanguageProvider>().locale,
      theme: context.watch<ThemeProvider>().themeData,
      darkTheme: context.watch<ThemeProvider>().darkThemeData,
      themeMode: context.watch<ThemeProvider>().themeMode,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: SnackBarService.scaffoldMessengerKey,
      home: const SettingScreen(),
    );
  }
}
