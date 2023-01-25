import 'package:flutter/material.dart';
import 'package:messenger/enums/authentication_status_enum.dart';
import 'package:messenger/providers/authentication_provider.dart';
import 'package:messenger/providers/teddy_provider.dart';
import 'package:messenger/screens/forgot_password_screen.dart';
import 'package:messenger/screens/login_screen.dart';
import 'package:messenger/screens/register_screen.dart';
import 'package:messenger/utilities/imports.dart';
import 'package:messenger/widgets/authentication/alread_have_an_account.dart';
import 'package:messenger/widgets/authentication/back_to_login.dart';
import 'package:messenger/widgets/authentication/do_not_have_account_sign_in_widget.dart';
import 'package:messenger/widgets/teddy/teddy_form_widget.dart';
import 'package:messenger/widgets/teddy/teddy_header_widget.dart';
import 'package:provider/provider.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget footer(
      AuthenticationProvider authenticationProvider,
    ) {
      switch (authenticationProvider.authenticationStatusEnum) {
        case AuthenticationStatusEnum.login:
          return const DoNotHaveAccountSignInWidget();
        case AuthenticationStatusEnum.register:
          return const AlreadyHaveAnAccount();
        case AuthenticationStatusEnum.forgetPassword:
          return const BackToLogin();
      }
    }

    Widget child(
      AuthenticationProvider authenticationProvider,
    ) {
      switch (authenticationProvider.authenticationStatusEnum) {
        case AuthenticationStatusEnum.login:
          return const LoginScreen();
        case AuthenticationStatusEnum.register:
          return const RegisterScreen();
        case AuthenticationStatusEnum.forgetPassword:
          return const ForgotPasswordScreen();
      }
    }

    Widget header(
      BuildContext context,
      AuthenticationProvider authenticationProvider,
    ) {
      var strings = AppLocalizations.of(context);
      var title = "";
      switch (authenticationProvider.authenticationStatusEnum) {
        case AuthenticationStatusEnum.login:
          title = strings?.login ?? "";
          break;
        case AuthenticationStatusEnum.register:
          title = strings?.register ?? "";
          break;
        case AuthenticationStatusEnum.forgetPassword:
          title = strings?.forgotPassword ?? "";
          break;
      }
      return TeddyHeaderWidget(
        title: title,
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (context) => TeddyProvider()),
      ],
      child: Consumer<AuthenticationProvider>(
        builder: (context, authenticationProvider, _) {
          return TeddyFormWidget(
            header: header(context, authenticationProvider),
            footer: footer(authenticationProvider),
            child: child(authenticationProvider),
          );
        },
      ),
    );
  }
}
