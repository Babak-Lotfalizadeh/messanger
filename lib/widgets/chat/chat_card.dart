import 'package:flutter/material.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/view_model/chat_view_model.dart';
import 'package:messenger/widgets/chat/chat_bubble_paint.dart';
import 'package:messenger/widgets/chat/indicator_widget.dart';

class ChatCard extends StatelessWidget {
  final bool senderOfNextIsTheSame;
  final ChatViewModel? chatViewModel;

  const ChatCard({
    required this.chatViewModel,
    required this.senderOfNextIsTheSame,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isMine = chatViewModel?.sendByMe == true;
    TextStyle? textStyle = isMine
        ? DefaultTextStyle.of(context).style.copyWith(
              color: Colors.white,
            )
        : null;

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          right: isMine ? 0 : ScreenValues.paddingXLarge,
          left: isMine ? ScreenValues.paddingXLarge : 0,
        ),
        child: CustomPaint(
          painter: ChatBubblePainter(
            color: isMine
                ? Theme.of(context).primaryColor
                : Theme.of(context).cardColor,
            leftBubble: !isMine,
            senderOfNextIsTheSame: senderOfNextIsTheSame,
          ),
          child: Padding(
            padding: const EdgeInsets.all(ScreenValues.paddingNormal),
            child: Padding(
              padding: EdgeInsets.only(
                right: isMine ? ScreenValues.paddingLarge : 0,
                left: isMine ? 0 : ScreenValues.paddingLarge,
              ),
              child: Column(
                crossAxisAlignment:
                    isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    chatViewModel?.message ?? "",
                    style: textStyle,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Opacity(
                        opacity: 0.5,
                        child: Text(
                          chatViewModel?.time() ?? "",
                          style: textStyle,
                        ),
                      ),
                      IndicatorWidget(chatViewModel: chatViewModel),
                    ],
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
