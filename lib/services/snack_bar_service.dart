import 'package:flutter/material.dart';

class SnackBarService {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  static BuildContext? get _context => scaffoldMessengerKey.currentContext;
  static final SnackBarService _instance = SnackBarService._internal();
  factory SnackBarService() {
    return _instance;
  }
  SnackBarService._internal();

  void show(String? message) {
    var snackBar = SnackBar(
      content: Text(message ?? ""),
    );
    if (_context != null) {
      ScaffoldMessenger.of(_context!).showSnackBar(snackBar);
    }
  }
}
