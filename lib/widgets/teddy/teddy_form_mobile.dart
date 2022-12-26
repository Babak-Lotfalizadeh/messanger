import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';

class TeddyFormMobile extends StatelessWidget {
  final Widget mainBody;
  final Widget? footer;
  final Widget? header;

  const TeddyFormMobile({
    this.header,
    required this.mainBody,
    this.footer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ScreenValues.teddyBackground,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            header ?? const SizedBox(),
            mainBody,
            footer ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
