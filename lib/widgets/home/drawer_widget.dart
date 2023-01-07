import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/firebase/firebase_authentication_service.dart';
import 'package:messenger/providers/theme_provider.dart';
import 'package:messenger/widgets/home/dark_light_switch_widget.dart';
import 'package:messenger/widgets/user/user_image_widget.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuthenticationService().currentUser;
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) => Column(
          children: [
            DrawerHeader(
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
                  Text(user?.email ?? ""),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
