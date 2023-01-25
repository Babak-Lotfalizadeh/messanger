import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class FirebaseCrashlyticsService {
  static final FirebaseCrashlyticsService _instance =
      FirebaseCrashlyticsService._internal();

  factory FirebaseCrashlyticsService() {
    return _instance;
  }

  FirebaseCrashlyticsService._internal();

  Future<void> init() async {
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
}
