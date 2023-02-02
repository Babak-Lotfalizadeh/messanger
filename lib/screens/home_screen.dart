import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/providers/contacts_provider.dart';
import 'package:messenger/screens/chat_page.dart';
import 'package:messenger/services/navigation_service.dart';
import 'package:messenger/widgets/contact_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Consumer<ContactsProvider>(
        builder: (context, contactsProvider, child) => ListView.separated(
          padding: const EdgeInsets.all(ScreenValues.paddingNormal),
          itemBuilder: (context, index) {
            var item = contactsProvider.contacts[index];

            return ContactCard(
              imageURL: item.imageAddress,
              title: item.title,
              backupTitle: item.chatId,
              onTab: () {
                NavigationService.push(ChatPage(contactViewModel: item));
              },
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: ScreenValues.paddingNormal,
          ),
          itemCount: contactsProvider.contacts.length,
        ),
      ),
    );
  }
}
