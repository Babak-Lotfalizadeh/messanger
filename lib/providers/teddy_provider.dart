import 'dart:async';

import 'package:flutter/material.dart';

class TeddyProvider extends ChangeNotifier {
  final Duration _toggleDuration = const Duration(milliseconds: 500);

  bool get check => _check;
  bool _check = false;

  bool get handsUp => _handsUp;
  bool _handsUp = false;

  bool get success => _success;
  bool _success = false;

  bool get fail => _fail;
  bool _fail = false;

  double get look => _look;
  double _look = 0.0;

  void setIdle() {
    _look = 0.0;
    _check = false;
    _handsUp = false;
    _success = false;
    _fail = false;
    notifyListeners();
  }

  void setLook(double location) {
    _look = location;
    notifyListeners();
  }

  void setCheck(bool newValue) {
    _check = newValue;
    notifyListeners();
  }

  void setHandsUp(bool newValue) {
    _handsUp = newValue;
    notifyListeners();
  }

  Future<void> setFail() async {
    _fail = true;
    await Future.delayed(_toggleDuration, () {
      _fail = false;
      notifyListeners();
    });
    notifyListeners();
  }

  Future<void> setSuccess() async {
    _success = true;
    notifyListeners();
    await Future.delayed(_toggleDuration, () {
      _success = false;
      notifyListeners();
    });
  }
}
