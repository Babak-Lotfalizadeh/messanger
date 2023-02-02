import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/providers/authentication_provider.dart';
import 'package:messenger/utilities/imports.dart';
import 'package:provider/provider.dart';

class DoNotHaveAccountSignInWidget extends StatelessWidget {
  const DoNotHaveAccountSignInWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var strings = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(ScreenValues.paddingXLarge),
      child: InkWell(
        onTap: context.read<AuthenticationProvider>().goRegister,
        child: Column(
          children: [
            Text(
              strings?.doNotHaveAnAccount ?? "",
            ),
            Text(
              strings?.createAccount ?? "",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
