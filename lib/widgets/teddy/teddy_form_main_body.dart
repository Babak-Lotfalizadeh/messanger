import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/providers/teddy_provider.dart';
import 'package:messenger/widgets/teddy/teddy_widget.dart';
import 'package:provider/provider.dart';

class TeddyFormMainBody extends StatelessWidget {
  final Widget child;

  const TeddyFormMainBody({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Consumer<TeddyProvider>(
          builder: (context, teddyProvider, child) => InkWell(
            onTap: teddyProvider.setIdle,
            child: TeddyWidget(
              check: teddyProvider.check,
              handsUp: teddyProvider.handsUp,
              success: teddyProvider.success,
              fail: teddyProvider.fail,
              look: teddyProvider.look,
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: ScreenValues.paddingXLarge,
          ),
          child: Padding(
            padding: const EdgeInsets.all(ScreenValues.paddingLarge),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 500),
              alignment: Alignment.topCenter,
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
