import 'package:flutter/material.dart';
import 'package:messenger/enums/drawer_enum.dart';
import 'package:messenger/providers/contacts_provider.dart';
import 'package:messenger/providers/drawer_provider.dart';
import 'package:messenger/screens/home_screen.dart';
import 'package:messenger/screens/setting_screen.dart';
import 'package:messenger/screens/users_page.dart';
import 'package:messenger/services/navigation_service.dart';
import 'package:messenger/utilities/imports.dart';
import 'package:messenger/widgets/app_bar_widget.dart';
import 'package:messenger/widgets/home/drawer_widget.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  Widget body(DrawerProvider drawerProvider) {
    switch (drawerProvider.selectedPage) {
      case DrawerEnum.home:
        return const HomeScreen();
      case DrawerEnum.setting:
        return const SettingScreen();
    }
  }

  String title(DrawerProvider drawerProvider, BuildContext context) {
    var strings = AppLocalizations.of(context);
    switch (drawerProvider.selectedPage) {
      case DrawerEnum.home:
        return strings?.chats ?? "";
      case DrawerEnum.setting:
        return strings?.setting ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DrawerProvider(),
      child: Consumer2<ContactsProvider, DrawerProvider>(
        builder: (context, contactsProvider, drawerProvider, child) => Scaffold(
          appBar: AppBarWidget(
            title: title(drawerProvider, context),
          ),
          drawer: const HomeDrawer(),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (Widget achild, Animation<double> animation) {
              return SlideTransition(
                position: Tween(
                  begin: const Offset(1.0, 0.0),
                  end: const Offset(0.0, 0.0),
                ).animate(animation),
                child: child,
              );
            },
            child: body(drawerProvider),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.message_outlined),
            onPressed: () => NavigationService.push(const UsersPage()),
          ),
        ),
      ),
    );
  }
}
