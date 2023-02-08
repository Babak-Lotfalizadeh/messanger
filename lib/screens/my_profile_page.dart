import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/enums/loading_update_user_enum.dart';
import 'package:messenger/enums/update_user_enum.dart';
import 'package:messenger/providers/user_information_provider.dart';
import 'package:messenger/screens/splash_page.dart';
import 'package:messenger/services/bottom_sheet_service.dart';
import 'package:messenger/services/navigation_service.dart';
import 'package:messenger/services/snack_bar_service.dart';
import 'package:messenger/utilities/imports.dart';
import 'package:messenger/widgets/bottom_sheet_change_image.dart';
import 'package:messenger/widgets/teddy/text_field_widget.dart';
import 'package:messenger/widgets/user/user_image_widget.dart';
import 'package:provider/provider.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var strings = AppLocalizations.of(context);

    void editImage(UserInformationProvider userInformationProvider) {
      BottomSheetService.show(
        context: context,
        title: strings?.changeImage ?? "",
        builder: (_) => BottomSheetChangeImage(
          onFilePicked: (file) {
            if (file == null || userInformationProvider.loading != null) return;
            userInformationProvider.editImage(file);
          },
        ),
      );
    }

    return ChangeNotifierProvider(
      create: (context) => UserInformationProvider()..init(),
      child: Consumer<UserInformationProvider>(
        builder: (context, provider, child) {
          var user = provider.user;

          if (user == null) {
            return const CircularProgressIndicator();
          }

          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(ScreenValues.paddingLarge),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: double.infinity),
                    Center(
                      child: UserImageWidget(
                        userImageAddress: provider.photoUrl ?? user.photoURL,
                        loading:
                            provider.loading == LoadingUpdateUserEnum.image,
                        onEdit: () => editImage(provider),
                      ),
                    ),
                    const SizedBox(height: ScreenValues.paddingLarge),
                    Text(strings?.email ?? ""),
                    const SizedBox(height: ScreenValues.paddingNormal),
                    Text(user.email ?? ""),
                    const SizedBox(height: ScreenValues.paddingLarge),
                    Text(strings?.displayName ?? ""),
                    const SizedBox(height: ScreenValues.paddingNormal),
                    TextFieldWidget(
                      hintText: strings?.displayName ?? "",
                      controller: provider.displayNameController,
                    ),
                    Text(user.displayName ?? ""),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: provider.loading == LoadingUpdateUserEnum.save
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.navigate_next_outlined),
              onPressed: () {
                provider.save().then((value) {
                  NavigationService.pushAndReplace(const SplashPage());
                }, onError: (ex) {
                  if (ex == UpdateUserEnum.displayName) {
                    SnackBarService.show(
                      message: strings?.displayNameIsAMust,
                      context: context,
                    );
                  }
                });
              },
            ),
          );
        },
      ),
    );
  }
}
