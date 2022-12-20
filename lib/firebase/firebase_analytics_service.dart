import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsService {
  static FirebaseAnalytics? analytics;
  static final FirebaseAnalyticsService _instance =
      FirebaseAnalyticsService._internal();

  factory FirebaseAnalyticsService() {
    return _instance;
  }

  FirebaseAnalyticsService._internal();

  Future<void> init() async {
    analytics = FirebaseAnalytics.instance;
  }
}
