import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messenger/firebase/firebase_analytics_service.dart';
import 'package:messenger/firebase/firebase_authentication_service.dart';
import 'package:messenger/firebase/firebase_crashlytics_service.dart';
import 'package:messenger/firebase/firebase_database_service.dart';
import 'package:messenger/firebase/firebase_fire_store_service.dart';
import 'package:messenger/firebase/firebase_function_service.dart';
import 'package:messenger/firebase/firebase_messaging_service.dart';
import 'package:messenger/firebase_options.dart';

class FirebaseCoreService {
  const FirebaseCoreService._();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _initMessaging();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await _initAnalytics();
    await _initCrashlytics();
    await _initAuthentication();
    await _initDatabase();
    await _initFirebaseFireStore();
    await _initFunctions();
  }

  static _initAnalytics() => FirebaseAnalyticsService().init();

  static _initCrashlytics() => FirebaseCrashlyticsService().init();

  static _initAuthentication() => FirebaseAuthenticationService().init();

  static _initDatabase() => FirebaseDatabaseService().init();

  static _initFirebaseFireStore() => FirebaseFireStoreService().init();

  static _initFunctions() => FirebaseFunctionService().init();

  static void _initMessaging() => FirebaseMessagingService.init();
}
