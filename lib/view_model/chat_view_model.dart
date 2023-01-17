// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger/firebase/firebase_authentication_service.dart';
import 'package:messenger/view_model/timestamp_converter.dart';

part 'chat_view_model.g.dart';

@JsonSerializable()
class ChatViewModel {
  final String id, message, sender, receiver, chatId;
  final bool received, seen;
  @TimestampConverter()
  final DateTime dateTime;
  @JsonKey(ignore: true)
  bool sendByMe;

  ChatViewModel({
    required this.id,
    required this.message,
    required this.chatId,
    required this.sender,
    required this.receiver,
    required this.received,
    required this.seen,
    required this.dateTime,
    this.sendByMe = false,
  }) {
    sendByMe = (sender == FirebaseAuthenticationService().currentUser?.uid);
  }

  String date() => "${dateTime.year}/${dateTime.month}/${dateTime.day}";

  String time() => "${dateTime.hour}:${dateTime.second}";

  bool isToday() {
    var now = DateTime.now();
    return ((dateTime.year == now.year) &&
        (dateTime.month == now.month) &&
        (dateTime.day == now.day));
  }

  factory ChatViewModel.fromJson(Map<String, dynamic> json) =>
      _$ChatViewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatViewModelToJson(this);
}
