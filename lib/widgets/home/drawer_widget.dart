import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/enums/drawer_enum.dart';
import 'package:messenger/firebase/firebase_authentication_service.dart';
import 'package:messenger/providers/drawer_provider.dart';
import 'package:messenger/providers/theme_provider.dart';
import 'package:messenger/utilities/imports.dart';
import 'package:messenger/widgets/home/dark_light_switch_widget.dart';
import 'package:messenger/widgets/home/drawer_item_widget.dart';
import 'package:messenger/widgets/user/user_image_widget.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var strings = AppLocalizations.of(context);
    var user = FirebaseAuthenticationService().currentUser;
    return Drawer(
      child: Consumer2<ThemeProvider, DrawerProvider>(
        builder: (context, themeProvider, drawerProvider, child) => ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(
                    ScreenValues.radiusLarge,
                  ),
                ),
                color: Theme.of(context).primaryColor,
              ),
              margin: const EdgeInsets.only(bottom: ScreenValues.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserImageWidget(
                          userImageAddress: user?.photoURL ?? "",
                          size: ScreenValues.smallImageSize,
                        ),
                        const Spacer(),
                        const DarkLightSwitchWidget(),
                      ],
                    ),
                  ),
                  const SizedBox(height: ScreenValues.paddingNormal),
                  Text(
                    user?.email ?? "",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
            DrawerItemWidget(
              selected: drawerProvider.selectedPage == DrawerEnum.home,
              icon: const Icon(Icons.home),
              selectedIcon: const Icon(Icons.home_outlined),
              title: strings?.home ?? "",
              onTap: () => drawerProvider.changePage(DrawerEnum.home),
            ),
            DrawerItemWidget(
              selected: drawerProvider.selectedPage == DrawerEnum.setting,
              icon: const Icon(Icons.settings),
              selectedIcon: const Icon(Icons.settings_outlined),
              title: strings?.setting ?? "",
              onTap: () => drawerProvider.changePage(DrawerEnum.setting),
            ),
          ],
        ),
      ),
    );
  }
}
