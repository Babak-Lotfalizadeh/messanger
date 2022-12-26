import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/enums/firebase_login_error_enum.dart';
import 'package:messenger/enums/text_field_rule.dart';
import 'package:messenger/providers/authentication_provider.dart';
import 'package:messenger/providers/login_provider.dart';
import 'package:messenger/providers/teddy_provider.dart';
import 'package:messenger/screens/splash_page.dart';
import 'package:messenger/services/navigation_service.dart';
import 'package:messenger/services/snack_bar_service.dart';
import 'package:messenger/utilities/imports.dart';
import 'package:messenger/widgets/button_widget.dart';
import 'package:messenger/widgets/teddy/text_field_widget.dart';
import 'package:messenger/widgets/text_button_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  void _showError(BuildContext context, String response) {
    var strings = AppLocalizations.of(context);
    var error = strings?.unknownError;
    if (response == FirebaseLoginErrorEnum.userNotFound.code) {
      error = strings?.userNotFound;
    } else if (response == FirebaseLoginErrorEnum.wrongPassword.code) {
      error = strings?.wrongPassword;
    }
    SnackBarService.show(message: error, context: context);
  }

  @override
  Widget build(BuildContext context) {
    var strings = AppLocalizations.of(context);
    var authenticationProvider = context.read<AuthenticationProvider>();

    return ChangeNotifierProvider(
      create: (context) => LoginProvider()
        ..init(
          context.read<TeddyProvider>(),
        ),
      child: Consumer<LoginProvider>(
        builder: (context, loginProvider, child) => Form(
          key: loginProvider.formKey,
          child: Column(
            children: [
              TextFieldWidget(
                labelText: strings?.userName,
                focusNode: loginProvider.userNameFocusNode,
                controller: loginProvider.userNameController,
                textFieldRule: TextFieldRule.email,
                prefixIcon: const Icon(Icons.account_box),
              ),
              const SizedBox(height: ScreenValues.paddingLarge),
              TextFieldWidget(
                labelText: strings?.password,
                focusNode: loginProvider.passwordFocusNode,
                controller: loginProvider.passwordController,
                prefixIcon: const Icon(Icons.lock),
                obscureText: true,
              ),
              const SizedBox(height: ScreenValues.paddingNormal),
              Align(
                alignment: Alignment.topRight,
                child: TextButtonWidget(
                  onTap: authenticationProvider.goForgetPassword,
                  title: strings?.forgotPassword ?? "",
                ),
              ),
              const SizedBox(height: ScreenValues.paddingNormal),
              ButtonWidget(
                title: strings?.login ?? "",
                onPressed: () async {
                  var pass = loginProvider.formKey.currentState?.validate();
                  if (pass == false) {
                    loginProvider.validationFailed();
                    return;
                  }
                  await loginProvider.login(
                    whenSuccess: () {
                      NavigationService.pushAndReplace(const SplashPage());
                    },
                    whenError: (response) => _showError(context, response),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
