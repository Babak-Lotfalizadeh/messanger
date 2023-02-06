import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:messenger/firebase/firebase_fire_store_service.dart';

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
    RemoteMessage message,
  ) async {
    await Firebase.initializeApp();
    var firebaseFireStoreService = FirebaseFireStoreService();
    await firebaseFireStoreService.init();
    firebaseFireStoreService.updateMessage(
      id: message.data["body"],
      received: true,
      seen: false,
    );
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
      FirebaseFireStoreService().updateMessage(
        id: message.data["body"],
        received: true,
        seen: false,
      );
    });
    _messaging?.onTokenRefresh.listen((fcmToken) {
      onUpdate(fcmToken);
    });
    onUpdate(await _messaging?.getToken());
  }
}
