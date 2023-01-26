import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/providers/splash_provider.dart';
import 'package:messenger/services/navigation_service.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SplashProvider()
        ..init(
          (nextPage) => NavigationService.pushAndReplace(nextPage),
        ),
      child: Consumer<SplashProvider>(
        builder: (context, splashProvider, child) => const Scaffold(
          body: Center(
            child: SizedBox(
              height: ScreenValues.iconNormal,
              width: ScreenValues.iconNormal,
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
