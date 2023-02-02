import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';

class TextButtonWidget extends StatelessWidget {
  final String title;
  final Function() onTap;
  final EdgeInsets? margin;

  const TextButtonWidget({
    required this.title,
    required this.onTap,
    this.margin,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: margin ??
            const EdgeInsets.symmetric(
              vertical: ScreenValues.paddingNormal,
            ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
        ),
      ),
    );
  }
}
