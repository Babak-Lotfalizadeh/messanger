import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';

class TeddyFormWeb extends StatelessWidget {
  final Widget header;
  final Widget mainBody;

  const TeddyFormWeb({
    required this.header,
    required this.mainBody,
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
                  child: header,
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
                    child: mainBody,
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
