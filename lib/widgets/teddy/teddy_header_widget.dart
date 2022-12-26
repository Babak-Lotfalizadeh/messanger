import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';

class TeddyHeaderWidget extends StatefulWidget {
  final String title;

  const TeddyHeaderWidget({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  State<TeddyHeaderWidget> createState() => _TeddyHeaderWidgetState();
}

class _TeddyHeaderWidgetState extends State<TeddyHeaderWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: ScreenValues.normalAnimation,
    vsync: this,
  )..forward();
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, -2.5),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kToolbarHeight),
      child: SlideTransition(
        position: _offsetAnimation,
        child: Container(
          height: ScreenValues.loginHeaderHeight,
          padding: const EdgeInsets.symmetric(
            horizontal: ScreenValues.paddingXLarge,
          ),
          child: AutoSizeText(
            widget.title,
            maxLines: 1,
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  fontFamily: ScreenValues.fontFamilyRighteous,
                  color: Colors.black45,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
