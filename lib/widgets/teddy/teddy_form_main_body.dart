import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/widgets/teddy/teddy_widget.dart';

class TeddyFormMainBody extends StatelessWidget {
  final Widget child;
  final bool check;
  final bool handsUp;
  final bool success;
  final bool fail;
  final double look;
  final Function()? onClickTeddy;

  const TeddyFormMainBody({
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onClickTeddy,
          child: TeddyWidget(
            check: check,
            handsUp: handsUp,
            success: success,
            fail: fail,
            look: look,
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: ScreenValues.paddingXLarge,
          ),
          child: Padding(
            padding: const EdgeInsets.all(ScreenValues.paddingLarge),
            child: child,
          ),
        ),
      ],
    );
  }
}
