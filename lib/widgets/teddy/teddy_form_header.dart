import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';

class TeddyFormHeader extends StatelessWidget {
  final String title;
  final String description;

  const TeddyFormHeader({
    required this.title,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var headerStyle = Theme.of(context).textTheme.headline1?.copyWith(
          fontFamily: ScreenValues.fontFamilyRighteous,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: headerStyle,
        ),
        const SizedBox(height: ScreenValues.paddingNormal),
        AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              description,
              textStyle: headerStyle?.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: Theme.of(context).textTheme.bodyText1?.fontSize,
              ),
              speed: const Duration(milliseconds: 100),
            ),
          ],
          totalRepeatCount: 1,
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
        ),
      ],
    );
  }
}
