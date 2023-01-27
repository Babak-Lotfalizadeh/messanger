import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/view_model/chat_view_model.dart';

class IndicatorWidget extends StatelessWidget {
  final ChatViewModel? chatViewModel;

  const IndicatorWidget({
    required this.chatViewModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (chatViewModel?.sendByMe == false) return const SizedBox();
    Widget icon([Color color = Colors.white]) {
      return Icon(
        Icons.check_rounded,
        size: ScreenValues.receiveIndicatorSize,
        color: color,
      );
    }

    Widget child = const Padding(
      padding: EdgeInsets.all(ScreenValues.paddingSmall),
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 2,
      ),
    );

    if (chatViewModel?.seen == true) {
      child = Stack(
        alignment: Alignment.centerRight,
        children: [
          icon(Colors.blue),
          Align(
            alignment: Alignment.centerLeft,
            child: icon(Colors.blue),
          ),
        ],
      );
    } else if (chatViewModel?.received == true) {
      child = icon(Colors.blue);
    } else if (chatViewModel?.send == true) {
      child = icon();
    }

    return Container(
      width: ScreenValues.receiveIndicatorSize * 1.5,
      height: ScreenValues.receiveIndicatorSize,
      padding: const EdgeInsets.only(left: ScreenValues.paddingSmall),
      child: child,
    );
  }
}
