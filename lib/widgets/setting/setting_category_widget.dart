import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';

class SettingCategoryWidget extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const SettingCategoryWidget({
    required this.title,
    required this.items,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: ScreenValues.paddingNormal),
        Padding(
          padding: const EdgeInsets.all(ScreenValues.paddingNormal),
          child: Text(title),
        ),
        ...items,
      ],
    );
  }
}
