import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/enums/text_field_rule.dart';
import 'package:messenger/providers/authentication_provider.dart';
import 'package:messenger/providers/forgot_password_provider.dart';
import 'package:messenger/providers/teddy_provider.dart';
import 'package:messenger/services/snack_bar_service.dart';
import 'package:messenger/utilities/imports.dart';
import 'package:messenger/widgets/button_widget.dart';
import 'package:messenger/widgets/teddy/text_field_widget.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  void _showSuccess(BuildContext context) {
    var strings = AppLocalizations.of(context);
    var message = strings?.passwordResetLinkAreSendToEmail;
    SnackBarService.show(message: message, context: context);
    context.read<AuthenticationProvider>().goLogin();
  }

  void _showError(BuildContext context, String response) {
    var strings = AppLocalizations.of(context);
    var error = strings?.unknownError;
    SnackBarService.show(message: error, context: context);
  }

  @override
  Widget build(BuildContext context) {
    var strings = AppLocalizations.of(context);

    return ChangeNotifierProvider(
      create: (context) => ForgotPasswordProvider()
        ..init(
          context.read<TeddyProvider>(),
        ),
      child: Consumer<ForgotPasswordProvider>(
        builder: (context, forgotPasswordProvider, child) => Form(
          key: forgotPasswordProvider.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(strings?.passwordResetLinkAreSendToEmail ?? ""),
              const SizedBox(height: ScreenValues.paddingLarge),
              TextFieldWidget(
                labelText: strings?.userName,
                controller: forgotPasswordProvider.userNameController,
                focusNode: forgotPasswordProvider.userNameFocusNode,
                textFieldRule: TextFieldRule.email,
                prefixIcon: const Icon(Icons.account_box),
              ),
              const SizedBox(height: ScreenValues.paddingXLarge),
              ButtonWidget(
                title: strings?.continueText ?? "",
                onPressed: () async {
                  if (forgotPasswordProvider.validate == false) {
                    return;
                  }

                  await forgotPasswordProvider.forgotPassword(
                    whenSuccess: (response) {
                      _showSuccess(context);
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
