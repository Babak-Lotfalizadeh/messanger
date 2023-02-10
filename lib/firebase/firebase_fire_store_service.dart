import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger/constants/routes.dart';
import 'package:messenger/view_model/chat_view_model.dart';
import 'package:messenger/view_model/user_view_model.dart';

class FirebaseFireStoreService {
  static FirebaseFirestore? _database;
  static final FirebaseFireStoreService _instance =
      FirebaseFireStoreService._internal();

  factory FirebaseFireStoreService() {
    return _instance;
  }

  FirebaseFireStoreService._internal();

  Future<void> init() async {
    _database = FirebaseFirestore.instance;
  }

  Stream<List<ChatViewModel>?>? getChats(String? chatId) {
    var ref = _database
        ?.collection(Routes.chats)
        .where(
          "chatId",
          isEqualTo: chatId,
        )
        .orderBy("dateTime");

    return ref?.snapshots().map((event) {
      return event.docs
          .map((element) => ChatViewModel.fromJson(element.data()))
          .toList();
    });
  }

  Future<void> setNewUser({
    required User? user,
    required String? fcmToken,
  }) async {
    var ref = _database?.collection(Routes.users).doc(user?.uid);

    var model = UserViewModel(
      email: user?.email ?? "",
      imageURL: user?.photoURL ?? "",
      name: user?.displayName ?? "",
      userId: user?.uid ?? "",
      fcmToken: fcmToken ?? "",
    );

    await ref?.set(model.toJson(), SetOptions(merge: true));
  }

  Future<void> updateMessage({
    required String id,
    required bool received,
    required bool seen,
  }) async {
    var ref = _database?.collection(Routes.chats).doc(id);
    await ref?.update({
      "received": received,
      "seen": seen,
    });
  }
}
