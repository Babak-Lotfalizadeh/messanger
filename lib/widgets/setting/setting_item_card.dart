import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';

class SettingItemCard extends StatelessWidget {
  final String title;
  final String? value;
  final EdgeInsets? padding;
  final Widget? widgetValue;
  final IconData iconData;
  final Function()? onClick;

  const SettingItemCard({
    required this.title,
    required this.iconData,
    this.padding,
    this.value,
    this.widgetValue,
    this.onClick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(ScreenValues.paddingLarge),
          child: Row(
            children: [
              Icon(iconData),
              const SizedBox(width: ScreenValues.paddingNormal),
              Expanded(child: Text(title)),
              const SizedBox(width: ScreenValues.paddingNormal),
              Visibility(
                visible: value != null,
                child: Text(value ?? ""),
              ),
              Visibility(
                visible: widgetValue != null,
                child: widgetValue ?? const SizedBox(),
              ),
              Visibility(
                visible: widgetValue == null && value == null,
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: ScreenValues.iconSmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
