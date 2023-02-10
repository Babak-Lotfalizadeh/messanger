// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'create_group_view_model.g.dart';

@JsonSerializable()
class CreateGroupViewModel {
  final List<String> users;
  final String? imageAddress, title;

  const CreateGroupViewModel({
    required this.users,
    required this.imageAddress,
    required this.title,
  });

  factory CreateGroupViewModel.fromJson(Map<String, dynamic> json) =>
      _$CreateGroupViewModelFromJson(json);
  Map<String, dynamic> toJson() => _$CreateGroupViewModelToJson(this);
}
