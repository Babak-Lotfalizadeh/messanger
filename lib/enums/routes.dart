import 'package:uuid/uuid.dart';

class Routes {
  Routes._();

  static getContacts(String userId) => "/contacts/$userId/";

  static getChats(String chatId) => "/chats/$chatId/";
  static setChats(String chatId) => "/chats/$chatId/${const Uuid().v1()}/";
}
