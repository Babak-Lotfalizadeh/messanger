import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';

class BottomSheetWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final String title;

  const BottomSheetWidget({
    required this.title,
    required this.child,
    this.padding,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(ScreenValues.radiusLarge),
          bottom: Radius.zero,
        ),
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: ScreenValues.paddingSmall,
              width: ScreenValues.paddingXLarge,
              margin: const EdgeInsets.all(ScreenValues.paddingNormal),
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          const SizedBox(height: ScreenValues.paddingLarge),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: ScreenValues.paddingLarge,
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          Padding(
            padding: padding ??
                const EdgeInsets.all(
                  ScreenValues.paddingLarge,
                ),
            child: child,
          ),
        ],
      ),
    );
  }
}
