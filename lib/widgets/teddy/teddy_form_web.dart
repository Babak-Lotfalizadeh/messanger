import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';

class TeddyFormWeb extends StatelessWidget {
  final Widget mainBody;
  final Widget? footer;
  final Widget? header;

  const TeddyFormWeb({
    this.header,
    required this.mainBody,
    this.footer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: ScreenValues.webConstraints,
          child: Card(
            margin: const EdgeInsets.all(ScreenValues.paddingXLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      header ?? const SizedBox()
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(
                      ScreenValues.paddingXLarge,
                    ),
                    decoration: const BoxDecoration(
                      color: ScreenValues.teddyBackground,
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(ScreenValues.radiusNormal),
                      ),
                    ),
                    child: Column(
                      children: [mainBody, footer ?? const SizedBox()],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
