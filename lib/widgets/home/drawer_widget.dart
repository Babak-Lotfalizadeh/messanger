import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/firebase/firebase_authentication_service.dart';
import 'package:messenger/providers/theme_provider.dart';
import 'package:messenger/screens/setting_page.dart';
import 'package:messenger/services/navigation_service.dart';
import 'package:messenger/utilities/imports.dart';
import 'package:messenger/widgets/home/dark_light_switch_widget.dart';
import 'package:messenger/widgets/user/user_image_widget.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var strings = AppLocalizations.of(context);
    var user = FirebaseAuthenticationService().currentUser;
    return Drawer(
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) => ListView(
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
              margin: EdgeInsets.zero,
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
            ListTile(
              title: Text(strings?.setting ?? ""),
              leading: const Icon(Icons.settings_outlined),
              onTap: () => NavigationService.popPush(const SettingPage()),
            ),
          ],
        ),
      ),
    );
  }
}
