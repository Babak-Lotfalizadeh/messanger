import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/enums/firebase_register_error_enum.dart';
import 'package:messenger/enums/text_field_rule.dart';
import 'package:messenger/providers/register_provider.dart';
import 'package:messenger/providers/teddy_provider.dart';
import 'package:messenger/screens/splash_page.dart';
import 'package:messenger/services/navigation_service.dart';
import 'package:messenger/services/snack_bar_service.dart';
import 'package:messenger/utilities/imports.dart';
import 'package:messenger/widgets/button_widget.dart';
import 'package:messenger/widgets/teddy/text_field_widget.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  void _showError(BuildContext context, String response) {
    var strings = AppLocalizations.of(context);
    var error = strings?.unknownError;
    if (response == FirebaseRegisterErrorEnum.weakPassword.code) {
      error = strings?.weakPassword;
    } else if (response == FirebaseRegisterErrorEnum.emailAlreadyInUse.code) {
      error = strings?.emailAlreadyInUse;
    }
    SnackBarService().show(error);
  }

  @override
  Widget build(BuildContext context) {
    var strings = AppLocalizations.of(context);

    return ChangeNotifierProvider(
      create: (context) => RegisterProvider()
        ..init(
          context.read<TeddyProvider>(),
        ),
      child: Consumer<RegisterProvider>(
        builder: (context, registerProvider, child) => Form(
          key: registerProvider.formKey,
          child: Column(
            children: [
              TextFieldWidget(
                labelText: strings?.userName,
                focusNode: registerProvider.userNameFocusNode,
                controller: registerProvider.userNameController,
                textFieldRule: TextFieldRule.email,
                prefixIcon: const Icon(Icons.account_box),
              ),
              const SizedBox(height: ScreenValues.paddingLarge),
              TextFieldWidget(
                labelText: strings?.password,
                focusNode: registerProvider.passwordFocusNode,
                controller: registerProvider.passwordController,
                textFieldRule: TextFieldRule.password,
                prefixIcon: const Icon(Icons.lock),
                obscureText: true,
              ),
              const SizedBox(height: ScreenValues.paddingLarge),
              TextFieldWidget(
                labelText: strings?.passwordConfirm,
                focusNode: registerProvider.confirmFocusNode,
                controller: registerProvider.confirmController,
                prefixIcon: const Icon(Icons.lock),
                textFieldRule: TextFieldRule.password,
                validator: (input) {
                  if (input != registerProvider.passwordController.text) {
                    return strings?.passwordAndPasswordConfirmValueIsNotMatch;
                  }
                  return null;
                },
                obscureText: true,
              ),
              const SizedBox(height: ScreenValues.paddingXLarge),
              ButtonWidget(
                title: strings?.register ?? "",
                onPressed: () async {
                  var pass = registerProvider.formKey.currentState?.validate();
                  if (pass == false) {
                    registerProvider.validationFailed();
                    return;
                  }
                  await registerProvider.register(
                    whenSuccess: () {
                      NavigationService.pushAndReplace(const SplashPage());
                    },
                    whenError: (response) {
                      _showError(context, response);
                    },
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
