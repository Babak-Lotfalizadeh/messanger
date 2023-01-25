import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/providers/authentication_provider.dart';
import 'package:messenger/utilities/imports.dart';
import 'package:provider/provider.dart';

class BackToLogin extends StatelessWidget {
  const BackToLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var strings = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(ScreenValues.paddingXLarge),
      child: InkWell(
        onTap: context.read<AuthenticationProvider>().goLogin,
        child: Column(
          children: [
            Text(
              strings?.backToLogin ?? "",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
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
