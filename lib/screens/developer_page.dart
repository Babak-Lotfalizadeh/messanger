import 'package:flutter/material.dart';
import 'package:messenger/widgets/button_widget.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ButtonWidget(
              onPressed: () async {
                // var result = await FirebaseFunctionService().getContacts();
              },
              title: "get",
            ),
            ButtonWidget(
              onPressed: () async {
                // var result = await FirebaseFunctionService().createContact(
                //   model: const CreateContactViewModel(
                //     user: "dH4HsdlqwfRSnHpOaVWhSxU8owy1",
                //   ),
                // );
              },
              title: "create",
            ),
          ],
        ),
      ),
    );
  }
}
