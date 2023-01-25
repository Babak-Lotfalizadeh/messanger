import 'package:flutter/material.dart';
import 'package:messenger/enums/assets.dart';
import 'package:messenger/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class DarkLightSwitchWidget extends StatefulWidget {
  const DarkLightSwitchWidget({Key? key}) : super(key: key);

  @override
  State<DarkLightSwitchWidget> createState() => _DarkLightSwitchWidgetState();
}

class _DarkLightSwitchWidgetState extends State<DarkLightSwitchWidget> {
  final String _stateMachine = "State Machine 1";
  StateMachineController? controller;
  SMIInput<bool>? isDark;

  void _handleTheme() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bool isDarkMode = context.read<ThemeProvider>().isDarkMode();
      isDark?.change(isDarkMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        bool isDarkMode = context.read<ThemeProvider>().isDarkMode();
        isDark?.change(isDarkMode);
        return InkWell(
          onTap: themeProvider.toggleDarkMode,
          child: SizedBox(
            width: 35,
            height: 35,
            child: RiveAnimation.asset(
              Assets.darkLightSwitch.value,
              fit: BoxFit.cover,
              onInit: (artboard) {
                controller = StateMachineController.fromArtboard(
                  artboard,
                  _stateMachine,
                );
                if (controller == null) return;

                artboard.addController(controller!);
                isDark = controller?.findInput("isDark");
                _handleTheme();
              },
              stateMachines: [_stateMachine],
            ),
          ),
        );
      },
    );
  }
}
