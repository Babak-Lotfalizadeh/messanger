import 'package:flutter/material.dart';

class SnackBarService {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  static final SnackBarService _instance = SnackBarService._internal();
  factory SnackBarService() {
    return _instance;
  }
  SnackBarService._internal();
}
