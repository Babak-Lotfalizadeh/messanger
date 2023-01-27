import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger/enums/routes.dart';
import 'package:messenger/view_model/chat_view_model.dart';
import 'package:messenger/view_model/contact_view_model.dart';
import 'package:messenger/view_model/user_view_model.dart';
import 'package:uuid/uuid.dart';

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

  Stream<List<ContactViewModel>?>? getContacts(String? userId) {
    var ref = _database?.collection(Routes.contacts);

    return ref?.snapshots().map((event) {
      var result = event.docs
          .map((element) => ContactViewModel.fromJson(element.data()))
          .toList();
      result.removeWhere(
        (element) => element.userId != userId && element.contactId != userId,
      );

      return result;
    });
  }

  Stream<List<UserViewModel>?>? getUsers() {
    var ref = _database?.collection(Routes.users);

    return ref?.snapshots().map((event) {
      return event.docs
          .map((element) => UserViewModel.fromJson(element.data()))
          .toList();
    });
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

  Future<ContactViewModel?> createContact({
    required String? userId,
    required UserViewModel? userViewModel,
  }) async {
    var ref = _database?.collection(Routes.contacts);

    var title = userViewModel?.name.isNotEmpty == true
        ? userViewModel?.name
        : userViewModel?.email;

    var model = ContactViewModel(
      title: title ?? "",
      chatId: const Uuid().v1(),
      contactId: userViewModel?.userId ?? "",
      imageAddress: userViewModel?.imageURL,
      userId: userId ?? "",
    );
    var result = await ref?.add(model.toJson());
    var data = (await result?.snapshots().first)?.data();
    if (data != null) {
      return ContactViewModel.fromJson(data);
    }
    return null;
  }

  Future<void> updateMessage({
    required ChatViewModel model,
    required bool received,
    required bool seen,
  }) async {
    var ref = _database?.collection(Routes.chats).doc(model.id);
    await ref?.update({
      "received": received,
      "seen": seen,
    });
  }
}
