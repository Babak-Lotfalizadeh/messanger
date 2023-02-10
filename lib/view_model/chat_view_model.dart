// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:messenger/firebase/firebase_authentication_service.dart';

part 'chat_view_model.g.dart';

@JsonSerializable()
class ChatViewModel {
  final String message, chatId;
  final String? id, sender, dateTime;
  final bool send, received, seen;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool sendByMe;

  ChatViewModel({
    required this.message,
    required this.chatId,
    this.id,
    this.sender,
    this.send = false,
    this.received = false,
    this.seen = false,
    this.dateTime,
    this.sendByMe = false,
  }) {
    sendByMe = (sender == FirebaseAuthenticationService().currentUser?.uid);
  }

  DateTime get getDateTime => DateTime.parse(dateTime ?? "");

  String date() =>
      "${getDateTime.year}/${getDateTime.month}/${getDateTime.day}";

  String time() => "${getDateTime.hour}:${getDateTime.second}";

  bool isToday() {
    var now = DateTime.now();
    return ((getDateTime.year == now.year) &&
        (getDateTime.month == now.month) &&
        (getDateTime.day == now.day));
  }

  factory ChatViewModel.fromJson(Map<String, dynamic> json) =>
      _$ChatViewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatViewModelToJson(this);
}
