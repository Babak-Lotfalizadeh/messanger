import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:messenger/view_model/chat_view_model.dart';

class FirebaseFunctionService {
  static FirebaseFunctions? _functions;
  static final FirebaseFunctionService _instance =
      FirebaseFunctionService._internal();

  factory FirebaseFunctionService() {
    return _instance;
  }

  FirebaseFunctionService._internal();

  Future<void> init() async {
    _functions = FirebaseFunctions.instance;
  }

  Future<void> addMessage({
    required ChatViewModel model,
  }) async {
    try {
      await _functions?.httpsCallable('addMessage').call(model.toJson());
    } on FirebaseFunctionsException catch (error) {
      debugPrint(error.code);
    }
  }
}
