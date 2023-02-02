import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/services/navigation_service.dart';

class DrawerItemWidget extends StatelessWidget {
  final bool selected;
  final Widget icon;
  final Widget selectedIcon;
  final String title;
  final Function() onTap;

  const DrawerItemWidget({
    required this.selected,
    required this.icon,
    required this.selectedIcon,
    required this.title,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selected
          ? null
          : () {
              NavigationService.pop();
              onTap();
            },
      child: Container(
        height: ScreenValues.navItemHeight,
        margin: const EdgeInsets.symmetric(
          horizontal: ScreenValues.paddingXNormal,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: ScreenValues.paddingLarge,
        ),
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).primaryColorLight : null,
          borderRadius: const BorderRadius.all(
            Radius.circular(ScreenValues.navItemRadius),
          ),
        ),
        child: Row(
          children: [
            selected ? selectedIcon : icon,
            const SizedBox(width: ScreenValues.paddingXNormal),
            Text(title),
          ],
        ),
      ),
    );
  }
}
