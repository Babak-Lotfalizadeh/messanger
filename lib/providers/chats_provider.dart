import 'package:flutter/material.dart';
import 'package:messenger/firebase/firebase_database_service.dart';
import 'package:messenger/view_model/chat_view_model.dart';
import 'package:messenger/view_model/contact_view_model.dart';

class ChatsProvider extends ChangeNotifier {
  ContactViewModel? _contactViewModel;

  List<ChatViewModel> get chats => _chats;
  List<ChatViewModel> _chats = [];

  ScrollController scrollController = ScrollController();

  void init(ContactViewModel? contactViewModel) {
    _contactViewModel = contactViewModel;
    scrollController.addListener(_scrollControllerListener);
    getChats();
  }

  void _scrollControllerListener() {
    notifyListeners();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollControllerListener);

    super.dispose();
  }

  void getChats() {
    FirebaseDatabaseService()
        .getChats(_contactViewModel?.chatId)
        ?.listen((newValue) {
      _chats = newValue ?? [];
      _sort();
      notifyListeners();
      scrollToEnd();
    });
  }

  void _sort() => _chats.sort((a, b) => a.getDateTime.compareTo(b.getDateTime));

  bool senderOfNextIsTheSame(int index) {
    var currentOneId = _chats[index].sender;
    if (index < (_chats.length - 1)) {
      return currentOneId == _chats[++index].sender;
    }
    return false;
  }

  void scrollToEnd() {
    Future.delayed(const Duration(milliseconds: 300), () {
      scrollController.jumpTo(
        scrollController.position.maxScrollExtent,
      );
    });
  }
}
