import 'package:flutter/material.dart';
import 'package:messenger/providers/chats_provider.dart';
import 'package:messenger/view_model/contact_view_model.dart';
import 'package:messenger/widgets/app_bar_widget.dart';
import 'package:messenger/widgets/chat/chat_content.dart';
import 'package:messenger/widgets/chat/send_section.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  final ContactViewModel? contactViewModel;

  const ChatPage({required this.contactViewModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatsProvider()..init(contactViewModel),
      child: Scaffold(
        appBar: AppBarWidget(
          title: contactViewModel?.title,
        ),
        body: SafeArea(
          child: Column(
            children: [
              const Expanded(
                child: ChatContent(),
              ),
              SendSection(contactViewModel: contactViewModel),
            ],
          ),
        ),
      ),
    );
  }
}
