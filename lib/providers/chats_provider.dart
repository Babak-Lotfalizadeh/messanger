import 'package:flutter/material.dart';
import 'package:messenger/firebase/firebase_authentication_service.dart';
import 'package:messenger/firebase/firebase_fire_store_service.dart';
import 'package:messenger/firebase/firebase_function_service.dart';
import 'package:messenger/view_model/chat_view_model.dart';
import 'package:messenger/view_model/contact_view_model.dart';

class ChatsProvider extends ChangeNotifier {
  bool _mounted = false;
  ContactViewModel? _contactViewModel;

  List<ChatViewModel> get chats => _chats;
  List<ChatViewModel> _chats = [];

  ScrollController scrollController = ScrollController();
  var controller = TextEditingController();
  var focusNode = FocusNode();

  void init(ContactViewModel? contactViewModel) {
    _mounted = true;
    _contactViewModel = contactViewModel;
    scrollController.addListener(_scrollControllerListener);
    getChats();
  }

  void _scrollControllerListener() {
    notifyListeners();
  }

  @override
  void dispose() {
    _mounted = false;
    scrollController.removeListener(_scrollControllerListener);

    super.dispose();
  }

  void getChats() {
    FirebaseFireStoreService()
        .getChats(_contactViewModel?.chatId)
        ?.listen((newValue) {
      if (!_mounted) {
        return;
      }
      _chats = newValue ?? [];
      _markChatsAsSeen(newValue ?? []);
      notifyListeners();
      scrollToEnd();
    });
  }

  void _markChatsAsSeen(List<ChatViewModel> chats) async {
    for (var element in chats) {
      if (element.sendByMe == false && element.seen == false) {
        await _markAsSeen(element);
      }
    }
  }

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

  Future<void> _sendMessage(ChatViewModel model) async {
    FirebaseFunctionService().addMessage(model: model);
    controller.clear();
  }

  void _createMessageTemplate(ChatViewModel model) {
    _chats.add(ChatViewModel(
      message: model.message,
      chatId: model.chatId,
      receiver: model.receiver,
      id: model.id,
      sender: FirebaseAuthenticationService().currentUser?.uid,
      received: false,
      seen: false,
      send: false,
      dateTime: DateTime.now().toIso8601String(),
      sendByMe: true,
    ));
    notifyListeners();
    scrollToEnd();
  }

  Future<void> _markAsSeen(ChatViewModel chatViewModel) async {
    await FirebaseFireStoreService().updateMessage(
      id: chatViewModel.id ?? "",
      received: true,
      seen: true,
    );
  }

  Future<void> sendMessage({
    required BuildContext context,
    required ContactViewModel? contactViewModel,
  }) async {
    if (controller.text.isEmpty) {
      return;
    }
    var model = ChatViewModel(
      message: controller.text,
      chatId: contactViewModel?.chatId ?? "",
      receiver: contactViewModel?.contactId ?? "",
    );

    _createMessageTemplate(model);
    _sendMessage(model);
  }
}
