import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/providers/contacts_provider.dart';
import 'package:messenger/utilities/imports.dart';
import 'package:messenger/widgets/app_bar_widget.dart';
import 'package:messenger/widgets/contact/contact_card.dart';
import 'package:messenger/widgets/home/drawer_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContactsProvider>(
      create: (context) => ContactsProvider()..init(),
      child: Consumer<ContactsProvider>(
        builder: (context, contactsProvider, child) => Scaffold(
          appBar: AppBarWidget(
            title: AppLocalizations.of(context)?.chats,
          ),
          drawer: const HomeDrawer(),
          body: SafeArea(
            child: ListView.separated(
              padding: const EdgeInsets.all(ScreenValues.paddingNormal),
              itemBuilder: (context, index) => ContactCard(
                contactViewModel: contactsProvider.contacts[index],
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: ScreenValues.paddingNormal,
              ),
              itemCount: contactsProvider.contacts.length,
            ),
          ),
        ),
      ),
    );
  }
}
