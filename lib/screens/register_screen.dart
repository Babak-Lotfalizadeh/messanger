import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/enums/firebase_error_enum.dart';
import 'package:messenger/enums/text_field_rule.dart';
import 'package:messenger/providers/register_provider.dart';
import 'package:messenger/screens/splash_screen.dart';
import 'package:messenger/services/navigation_service.dart';
import 'package:messenger/services/snack_bar_service.dart';
import 'package:messenger/utilities/imports.dart';
import 'package:messenger/widgets/button_widget.dart';
import 'package:messenger/widgets/teddy/teddy_form_widget.dart';
import 'package:messenger/widgets/teddy/text_field_widget.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  void _showError(BuildContext context, String response) {
    var strings = AppLocalizations.of(context);
    var error = strings?.unknownError;
    if (response == FirebaseErrorEnum.weakPassword.code) {
      error = strings?.weakPassword;
    } else if (response == FirebaseErrorEnum.emailAlreadyInUse.code) {
      error = strings?.emailAlreadyInUse;
    }
    SnackBarService().show(error);
  }

  @override
  Widget build(BuildContext context) {
    var strings = AppLocalizations.of(context);

    return ChangeNotifierProvider(
      create: (context) => RegisterProvider()..init(),
      child: Consumer<RegisterProvider>(
        builder: (context, registerProvider, child) {
          var fields = [
            TextFieldWidget(
              labelText: strings?.userName,
              focusNode: registerProvider.userNameFocusNode,
              controller: registerProvider.userNameController,
              textFieldRule: TextFieldRule.email,
              prefixIcon: const Icon(Icons.account_box),
            ),
            TextFieldWidget(
              labelText: strings?.password,
              focusNode: registerProvider.passwordFocusNode,
              controller: registerProvider.passwordController,
              textFieldRule: TextFieldRule.password,
              prefixIcon: const Icon(Icons.lock),
              obscureText: true,
            ),
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
                    NavigationService.pushAndReplace(const SplashScreen());
                  },
                  whenError: (response) {
                    _showError(context, response);
                  },
                );
              },
            ),
          ];

          return TeddyFormWidget(
            title: strings?.register ?? "",
            description: strings?.hereIsYourFirstStepWithUs ?? "",
            check: registerProvider.check,
            handsUp: registerProvider.handsUp,
            success: registerProvider.success,
            fail: registerProvider.fail,
            look: registerProvider.look,
            onClickTeddy: () => registerProvider.removeAllFocuses(),
            child: Form(
              key: registerProvider.formKey,
              child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) => const SizedBox(
                  height: ScreenValues.paddingLarge,
                ),
                itemBuilder: (context, index) => fields[index],
                itemCount: fields.length,
              ),
            ),
          );
        },
      ),
    );
  }
}
