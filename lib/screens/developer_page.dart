import 'package:flutter/material.dart';
import 'package:messenger/firebase/firebase_authentication_service.dart';
import 'package:messenger/firebase/firebase_fire_store_service.dart';
import 'package:messenger/widgets/button_widget.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ButtonWidget(
              onPressed: () async {
                final String? userId =
                    FirebaseAuthenticationService().currentUser?.uid;
                FirebaseFireStoreService().getContacts(userId);
              },
              title: "get"),
        ],
      ),
    );
  }
}
