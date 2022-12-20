import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messenger/firebase/firebase_analytics_service.dart';
import 'package:messenger/firebase/firebase_authentication_service.dart';
import 'package:messenger/firebase/firebase_crashlytics_service.dart';
import 'package:messenger/firebase_options.dart';

class FirebaseCoreService {
  static final FirebaseCoreService _instance = FirebaseCoreService._internal();

  factory FirebaseCoreService() {
    return _instance;
  }

  FirebaseCoreService._internal();

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await _initAnalytics();
    await _initCrashlytics();
    await _initAuthentication();
  }

  Future<void> _initAnalytics() => FirebaseAnalyticsService().init();

  Future<void> _initCrashlytics() => FirebaseCrashlyticsService().init();

  Future<void> _initAuthentication() => FirebaseAuthenticationService().init();
}
