// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:messenger/firebase/firebase_authentication_service.dart';

part 'chat_view_model.g.dart';

@JsonSerializable()
class ChatViewModel {
  final String id, message, sender, receiver, dateTime;
  final bool received, seen;
  @JsonKey(ignore: true)
  bool sendByMe;

  ChatViewModel({
    required this.id,
    required this.message,
    required this.sender,
    required this.receiver,
    required this.received,
    required this.seen,
    required this.dateTime,
    this.sendByMe = false,
  }) {
    sendByMe = (sender == FirebaseAuthenticationService().currentUser?.uid);
  }

  DateTime get getDateTime => DateTime.parse(dateTime);

  String date() {
    var chatDate = getDateTime;
    return "${chatDate.year}/${chatDate.month}/${chatDate.day}";
  }

  String time() {
    var chatDate = getDateTime;
    return "${chatDate.hour}:${chatDate.second}";
  }

  bool isToday() {
    var now = DateTime.now();
    var chatDate = getDateTime;
    return ((chatDate.year == now.year) &&
        (chatDate.month == now.month) &&
        (chatDate.day == now.day));
  }

  factory ChatViewModel.fromJson(Map<String, dynamic> json) =>
      _$ChatViewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatViewModelToJson(this);
}
