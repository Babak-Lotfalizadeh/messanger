import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/screens/chat_page.dart';
import 'package:messenger/services/navigation_service.dart';
import 'package:messenger/view_model/contact_view_model.dart';

class ContactCard extends StatelessWidget {
  final ContactViewModel? contactViewModel;

  const ContactCard({
    required this.contactViewModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigationService.push(ChatPage(contactViewModel: contactViewModel));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(ScreenValues.paddingLarge),
          child: Text(
            contactViewModel?.title ?? "",
          ),
        ),
      ),
    );
  }
}
