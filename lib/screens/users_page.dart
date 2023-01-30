import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/providers/users_provider.dart';
import 'package:messenger/screens/contact_information_page.dart';
import 'package:messenger/services/navigation_service.dart';
import 'package:messenger/utilities/imports.dart';
import 'package:messenger/widgets/app_bar_widget.dart';
import 'package:messenger/widgets/contact_card.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var strings = AppLocalizations.of(context);
    return ChangeNotifierProvider<UsersProvider>(
      create: (context) => UsersProvider()..init(),
      child: Consumer<UsersProvider>(
        builder: (context, usersProvider, child) => Scaffold(
          appBar: AppBarWidget(
            title: strings?.newMessage,
          ),
          body: SafeArea(
            child: ListView.separated(
              padding: const EdgeInsets.all(ScreenValues.paddingNormal),
              itemBuilder: (context, index) {
                var item = usersProvider.users[index];
                return ContactCard(
                  imageURL: item.imageURL,
                  title: item.name,
                  backupTitle: item.email,
                  heroTag: false,
                  onTab: () {
                    NavigationService.push(
                      ContactInformationPage(
                        userViewModel: item,
                        comeFromChat: false,
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: ScreenValues.paddingNormal,
              ),
              itemCount: usersProvider.users.length,
            ),
          ),
        ),
      ),
    );
  }
}
