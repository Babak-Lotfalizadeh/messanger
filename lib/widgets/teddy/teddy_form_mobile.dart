import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';

class TeddyFormMobile extends StatelessWidget {
  final Widget header;
  final Widget mainBody;

  const TeddyFormMobile({
    required this.header,
    required this.mainBody,
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
            header,
            mainBody,
          ],
        ),
      ),
    );
  }
}
