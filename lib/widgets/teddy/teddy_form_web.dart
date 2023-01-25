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
    return SafeArea(
      child: Material(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(ScreenValues.paddingXLarge),
            constraints: ScreenValues.webConstraints,
            child: Card(
              margin: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        header ?? const SizedBox(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // padding: const EdgeInsets.all(
                      //   ScreenValues.paddingXLarge,
                      // ),todo
                      decoration: const BoxDecoration(
                        color: ScreenValues.teddyBackground,
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(ScreenValues.radiusNormal),
                        ),
                      ),
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        body: SingleChildScrollView(
                          child: Column(
                            children: [
                              mainBody,
                              footer ?? const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
