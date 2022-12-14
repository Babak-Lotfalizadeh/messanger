import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final double? minWidth;

  const ButtonWidget({
    required this.onPressed,
    required this.title,
    this.minWidth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: minWidth,
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(ScreenValues.radiusNormal),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: ScreenValues.paddingNormal),
      child: Text(title),
    );
  }
}
