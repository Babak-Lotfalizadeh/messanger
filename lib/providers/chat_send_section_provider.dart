import 'package:flutter/material.dart';
import 'package:messenger/firebase/firebase_authentication_service.dart';
import 'package:messenger/firebase/firebase_function_service.dart';
import 'package:messenger/view_model/contact_view_model.dart';

class ChatSendSectionProvider extends ChangeNotifier {
  final String? _userId = FirebaseAuthenticationService().currentUser?.uid;

  var controller = TextEditingController();
  var focusNode = FocusNode();

  Future<void> sendMessage(ContactViewModel? contactViewModel) async {
    if (controller.text.isEmpty) {
      return;
    }
    FirebaseFunctionService().addMessage(
        userId: _userId,
        message: controller.text,
        contactViewModel: contactViewModel,
    );
    controller.clear();
  }
}
