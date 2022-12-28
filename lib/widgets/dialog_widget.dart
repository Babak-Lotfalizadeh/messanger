import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/services/navigation_service.dart';

class DialogWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final String title;
  final bool showClose;

  const DialogWidget({
    required this.title,
    required this.child,
    this.padding,
    this.showClose = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(ScreenValues.paddingLarge),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(ScreenValues.radiusLarge),
              ),
              color: Theme.of(context).cardColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: ScreenValues.paddingLarge),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ScreenValues.paddingLarge,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style:
                              Theme.of(context).textTheme.headline5?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ),
                      Visibility(
                        visible: showClose,
                        child: IconButton(
                          onPressed: () => NavigationService.pop(),
                          icon: const Icon(Icons.close),
                        ),
                      ),
                    ],
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
          ),
        ),
      ),
    );
  }
}
