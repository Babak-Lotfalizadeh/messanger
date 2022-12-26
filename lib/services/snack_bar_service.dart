import 'package:flutter/material.dart';

class SnackBarService {
  static void show({required String? message, required BuildContext context}) {
    var snackBar = SnackBar(
      content: Text(message ?? ""),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
