import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:messenger/view_model/chat_view_model.dart';
import 'package:messenger/view_model/contact_view_model.dart';

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
    required String? userId,
    required String message,
    required ContactViewModel? contactViewModel,
  }) async {
    try {
      var model = ChatViewModel(
        message: message,
        chatId: contactViewModel?.chatId ?? "",
        receiver: contactViewModel?.contactId ?? "",
      );

      await _functions?.httpsCallable('addMessage').call(model.toJson());
    } on FirebaseFunctionsException catch (error) {
      debugPrint(error.code);
    }
  }
}
