import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/widgets/teddy/teddy_form_main_body.dart';
import 'package:messenger/widgets/teddy/teddy_form_mobile.dart';
import 'package:messenger/widgets/teddy/teddy_form_web.dart';

class TeddyFormWidget extends StatelessWidget {
  final Widget? child;
  final Widget? footer;
  final Widget? header;

  const TeddyFormWidget({
    this.header,
    this.child,
    this.footer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget mainBody = TeddyFormMainBody(
      child: child ?? const SizedBox(),
    );

    if (ScreenValues.isMobile(context)) {
      return TeddyFormMobile(
        header: header,
        mainBody: mainBody,
        footer: footer,
      );
    } else {
      return TeddyFormWeb(
        header: header,
        mainBody: mainBody,
        footer: footer,
      );
    }
  }
}
