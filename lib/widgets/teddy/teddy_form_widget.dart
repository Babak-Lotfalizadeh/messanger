import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/widgets/teddy/teddy_form_header.dart';
import 'package:messenger/widgets/teddy/teddy_form_main_body.dart';
import 'package:messenger/widgets/teddy/teddy_form_mobile.dart';
import 'package:messenger/widgets/teddy/teddy_form_web.dart';

class TeddyFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final Widget child;
  final bool check;
  final bool handsUp;
  final bool success;
  final bool fail;
  final double look;
  final Function()? onClickTeddy;

  const TeddyFormWidget({
    required this.title,
    required this.description,
    required this.child,
    required this.check,
    required this.handsUp,
    required this.success,
    required this.fail,
    required this.look,
    this.onClickTeddy,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget mainBody = TeddyFormMainBody(
      check: check,
      handsUp: handsUp,
      success: success,
      fail: fail,
      look: look,
      child: child,
    );
    Widget header = TeddyFormHeader(
      description: description,
      title: title,
    );

    if (ScreenValues.isMobile(context)) {
      return TeddyFormMobile(
        mainBody: mainBody,
        header: Padding(
          padding: const EdgeInsets.only(top: kToolbarHeight),
          child: header,
        ),
      );
    } else {
      return TeddyFormWeb(mainBody: mainBody, header: header);
    }
  }
}
