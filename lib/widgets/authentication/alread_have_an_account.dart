import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/providers/authentication_provider.dart';
import 'package:messenger/utilities/imports.dart';
import 'package:provider/provider.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  const AlreadyHaveAnAccount({Key? key}) : super(key: key);

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
              strings?.alreadyHaveAnAccount ?? "",
            ),
            Text(
              strings?.login ?? "",
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
