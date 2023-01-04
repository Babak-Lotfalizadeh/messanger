import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:messenger/constants/screen_values.dart';
import 'package:messenger/providers/chats_provider.dart';
import 'package:messenger/widgets/chat/chat_card.dart';
import 'package:provider/provider.dart';

class ChatContent extends StatelessWidget {
  const ChatContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatsProvider>(
      builder: (context, chatsProvider, child) => KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          if (isKeyboardVisible) {
            chatsProvider.scrollToEnd();
          }

          return ListView.separated(
            controller: chatsProvider.scrollController,
            itemCount: chatsProvider.chats.length,
            padding: const EdgeInsets.all(ScreenValues.paddingNormal),
            itemBuilder: (context, index) => ChatCard(
              senderOfNextIsTheSame: chatsProvider.senderOfNextIsTheSame(index),
              chatViewModel: chatsProvider.chats[index],
            ),
            separatorBuilder: (context, index) => SizedBox(
              height: chatsProvider.senderOfNextIsTheSame(index)
                  ? ScreenValues.paddingSmall
                  : ScreenValues.paddingLarge,
            ),
          );
        },
        controller: KeyboardVisibilityController(),
      ),
    );
  }
}
