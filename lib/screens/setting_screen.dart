import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/firebase/firebase_authentication_service.dart';
import 'package:messenger/providers/theme_provider.dart';
import 'package:messenger/screens/my_profile_page.dart';
import 'package:messenger/screens/splash_page.dart';
import 'package:messenger/services/bottom_sheet_service.dart';
import 'package:messenger/services/dialog_service.dart';
import 'package:messenger/services/navigation_service.dart';
import 'package:messenger/utilities/imports.dart';
import 'package:messenger/widgets/setting/bottom_sheet_change_language.dart';
import 'package:messenger/widgets/setting/bottom_sheet_change_theme.dart';
import 'package:messenger/widgets/setting/rounded_box_widget.dart';
import 'package:messenger/widgets/setting/setting_category_widget.dart';
import 'package:messenger/widgets/setting/setting_item_card.dart';
import 'package:messenger/widgets/switch_widget.dart';
import 'package:messenger/widgets/user/user_widget.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  void _logout(BuildContext context) {
    var strings = AppLocalizations.of(context);
    DialogService.showYesOrNo(
      title: strings?.logOut ?? "",
      description: strings?.areYouSureYouWantToLogout ?? "",
      context: context,
      onYes: () {
        FirebaseAuthenticationService().signOut().then((value) {
          NavigationService.pushAndRemoveUntil(const SplashPage());
        });
      },
    );
  }

  void _showChangeLanguage(BuildContext context) {
    BottomSheetService.show(
      context: context,
      title: AppLocalizations.of(context)?.language ?? "",
      builder: (context) => const BottomSheetChangeLanguage(),
    );
  }

  void _showChangeThemePrimary(BuildContext context) {
    BottomSheetService.show(
      context: context,
      title: AppLocalizations.of(context)?.primaryColor ?? "",
      builder: (context) => BottomSheetChangeTheme(
        defaultColor: Theme.of(context).primaryColor,
        onSave: (color) {
          context.read<ThemeProvider>().setPrimaryColor(color);
          NavigationService.pop();
        },
      ),
    );
  }

  void _showChangeThemePrimaryText(BuildContext context) {
    BottomSheetService.show(
      context: context,
      title: AppLocalizations.of(context)?.primaryTextColor ?? "",
      builder: (context) => BottomSheetChangeTheme(
        defaultColor:
            Theme.of(context).textTheme.bodyMedium?.color ?? Colors.white,
        onSave: (color) {
          context.read<ThemeProvider>().setPrimaryTextColor(color);
          NavigationService.pop();
        },
      ),
    );
  }

  void _showChangeThemeSecondary(BuildContext context) {
    BottomSheetService.show(
      context: context,
      title: AppLocalizations.of(context)?.secondaryColor ?? "",
      builder: (context) => BottomSheetChangeTheme(
        defaultColor: Theme.of(context).colorScheme.secondary,
        onSave: (color) {
          context.read<ThemeProvider>().setSecondaryColor(color);
          NavigationService.pop();
        },
      ),
    );
  }

  void _showUserInformation(BuildContext context) {
    NavigationService.push(const MyProfilePage(comeFromSetting: true));
  }

  @override
  Widget build(BuildContext context) {
    var strings = AppLocalizations.of(context);
    var currentUser = FirebaseAuthenticationService().currentUser;
    var isDarkMode = context.watch<ThemeProvider>().getIsDarkMode(context);
    String? inThisMode() {
      return isDarkMode ? strings?.inDarkMode : strings?.inLightMode;
    }

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Container(
          constraints: ScreenValues.mobileConstraints,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserWidget(user: currentUser),
              SettingCategoryWidget(
                title: strings?.userSetting ?? "",
                items: [
                  SettingItemCard(
                    title: strings?.language ?? "",
                    iconData: Icons.language_outlined,
                    value: strings?.currentLanguage,
                    onClick: () => _showChangeLanguage(context),
                  ),
                  SettingItemCard(
                    title: strings?.editUserInformation ?? "",
                    iconData: Icons.account_circle,
                    onClick: () => _showUserInformation(context),
                  ),
                  SettingItemCard(
                    title: strings?.logOut ?? "",
                    iconData: Icons.logout,
                    onClick: () => _logout(context),
                  ),
                ],
              ),
              SettingCategoryWidget(
                title: strings?.theme ?? "",
                items: [
                  SettingItemCard(
                    title: strings?.darkMode ?? "",
                    iconData: Icons.dark_mode_outlined,
                    padding: const EdgeInsets.symmetric(
                      horizontal: ScreenValues.paddingLarge,
                    ),
                    widgetValue: SwitchWidget(
                      value: isDarkMode,
                      onChanged: context.read<ThemeProvider>().setDarkMode,
                    ),
                    onClick: () =>
                        context.read<ThemeProvider>().toggleDarkMode(),
                  ),
                  SettingItemCard(
                    title: strings?.material3 ?? "",
                    iconData: Icons.adb,
                    padding: const EdgeInsets.symmetric(
                      horizontal: ScreenValues.paddingLarge,
                    ),
                    widgetValue: SwitchWidget(
                      value: context.watch<ThemeProvider>().material3,
                      onChanged: context.read<ThemeProvider>().setMaterial3,
                    ),
                    onClick: () =>
                        context.read<ThemeProvider>().toggleMaterial3(),
                  ),
                  SettingItemCard(
                    title: "${strings?.primaryColor ?? " "} ${inThisMode()}",
                    iconData: Icons.color_lens_outlined,
                    widgetValue: RoundedBoxWidget(
                      color: Theme.of(context).primaryColor,
                    ),
                    onClick: () => _showChangeThemePrimary(context),
                  ),
                  SettingItemCard(
                    title: "${strings?.primaryTextColor ?? ""} ${inThisMode()}",
                    iconData: Icons.format_color_text_outlined,
                    widgetValue: RoundedBoxWidget(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                    onClick: () => _showChangeThemePrimaryText(context),
                  ),
                  SettingItemCard(
                    title: "${strings?.secondaryColor ?? ""} ${inThisMode()}",
                    iconData: Icons.color_lens_outlined,
                    widgetValue: RoundedBoxWidget(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onClick: () => _showChangeThemeSecondary(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
