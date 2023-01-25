import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/providers/contacts_provider.dart';
import 'package:messenger/screens/chat_page.dart';
import 'package:messenger/screens/users_page.dart';
import 'package:messenger/services/navigation_service.dart';
import 'package:messenger/utilities/imports.dart';
import 'package:messenger/widgets/app_bar_widget.dart';
import 'package:messenger/widgets/contact_card.dart';
import 'package:messenger/widgets/home/drawer_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactsProvider>(
      builder: (context, contactsProvider, child) => Scaffold(
        appBar: AppBarWidget(
          title: AppLocalizations.of(context)?.chats,
        ),
        drawer: const HomeDrawer(),
        body: ListView.separated(
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
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.message_outlined),
          onPressed: () => NavigationService.push(const UsersPage()),
        ),
      ),
    );
  }
}
