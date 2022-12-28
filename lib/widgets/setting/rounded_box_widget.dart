import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';

class RoundedBoxWidget extends StatelessWidget {
  final Color? color;
  const RoundedBoxWidget({required this.color, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenValues.iconNormal,
      height: ScreenValues.iconNormal,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            ScreenValues.radiusNormal,
          ),
        ),
      ),
    );
  }
}
