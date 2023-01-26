import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  static FirebaseMessaging? _messaging;
  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._internal();

  factory FirebaseMessagingService() {
    return _instance;
  }

  FirebaseMessagingService._internal();

  static void init() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    log("Handling a background message: ${message.messageId}");
  }

  Future<void> setup(Function(String? token) onUpdate) async {
    _messaging = FirebaseMessaging.instance;
    NotificationSettings? settings = await _messaging?.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    log('User granted permission: ${settings?.authorizationStatus}');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');
      log('Message also contained a notification: ${message.notification}');
    });
    _messaging?.onTokenRefresh.listen((fcmToken) {
      onUpdate(fcmToken);
    });
    onUpdate(await _messaging?.getToken());
  }
}
