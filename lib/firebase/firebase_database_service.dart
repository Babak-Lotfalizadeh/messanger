import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:messenger/enums/routes.dart';
import 'package:messenger/view_model/chat_view_model.dart';
import 'package:messenger/view_model/contact_view_model.dart';
import 'package:uuid/uuid.dart';

class FirebaseDatabaseService {
  static FirebaseDatabase? _database;
  static final FirebaseDatabaseService _instance =
      FirebaseDatabaseService._internal();

  factory FirebaseDatabaseService() {
    return _instance;
  }

  FirebaseDatabaseService._internal();

  Future<void> init() async {
    _database = FirebaseDatabase.instance;
    _database?.setLoggingEnabled(kDebugMode);
  }

  Stream<List<ContactViewModel>?>? getContacts(String? userId) {
    //todo separate delete, add and update
    DatabaseReference? ref = _database?.ref(
      Routes.getContacts(userId ?? ""),
    );

    return ref?.onValue.map((event) {
      return event.snapshot.children
          .map(
            (element) => ContactViewModel.fromJson(
              Map<String, dynamic>.from(element.value as Map<Object?, Object?>),
            ),
          )
          .toList();
    });
  }

  Stream<List<ChatViewModel>?>? getChats(String? chatId) {
    //todo separate delete, add and update
    DatabaseReference? ref = _database?.ref(
      Routes.getChats(chatId ?? ""),
    );

    return ref?.onValue.map((event) {
      return event.snapshot.children
          .map((element) => ChatViewModel.fromJson(
                Map<String, dynamic>.from(
                    element.value as Map<Object?, Object?>),
              ))
          .toList();
    });
  }

  Future<void> sendMessage({
    required String? userId,
    required String message,
    required ContactViewModel? contactViewModel,
  }) async {
    DatabaseReference? ref = _database?.ref(
      Routes.setChats(contactViewModel?.chatId ?? "1"),
    );

    var model = ChatViewModel(
      id: const Uuid().v1(),
      sender: userId ?? "1",
      message: message,
      received: false,
      seen: false,
      receiver: contactViewModel?.id ?? "",
      dateTime: DateTime.now().toIso8601String(),
    );
    await ref?.set(model.toJson());
  }
}
