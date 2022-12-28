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

  static void pushAndReplace(Widget page) {
    if (_context != null) {
      Navigator.of(_context!).pushReplacement(
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );
    }
  }

  static void pushAndRemoveUntil(Widget page) {
    if (_context != null) {
      Navigator.of(_context!).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => page,
          ),
          (Route<dynamic> route) => false);
    }
  }

  static void push(Widget page) {
    if (_context != null) {
      Navigator.of(_context!).push(
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );
    }
  }
}
