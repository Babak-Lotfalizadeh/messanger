// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'create_contact_view_model.g.dart';

@JsonSerializable()
class CreateContactViewModel {
  final String user;

  const CreateContactViewModel({
    required this.user,
  });

  factory CreateContactViewModel.fromJson(Map<String, dynamic> json) =>
      _$CreateContactViewModelFromJson(json);
  Map<String, dynamic> toJson() => _$CreateContactViewModelToJson(this);
}
