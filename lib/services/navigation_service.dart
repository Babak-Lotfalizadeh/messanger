import 'package:flutter/material.dart';

class NavigationService {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() {
    return _instance;
  }
  NavigationService._internal();

  static BuildContext? get _context => navigatorKey.currentContext;

  static void pop({Object? object}) {
    if (_context != null) {
      return Navigator.of(_context!).pop(object);
    }
  }
}
