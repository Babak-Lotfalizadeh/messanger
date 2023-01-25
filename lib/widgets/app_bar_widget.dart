import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? prefixIcon;

  const AppBarWidget({
    Key? key,
    this.prefixIcon,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          prefixIcon ?? const SizedBox(),
          Visibility(
            visible: title != null,
            child: Text(
              title ?? "",
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
