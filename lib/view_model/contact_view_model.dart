// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'contact_view_model.g.dart';

@JsonSerializable()
class ContactViewModel {
  final String id, chatId, title;
  final String? imageAddress;

  const ContactViewModel({
    required this.id,
    required this.title,
    required this.chatId,
    required this.imageAddress,
  });

  factory ContactViewModel.fromJson(Map<String, dynamic> json) =>
      _$ContactViewModelFromJson(json);
  Map<String, dynamic> toJson() => _$ContactViewModelToJson(this);
}
