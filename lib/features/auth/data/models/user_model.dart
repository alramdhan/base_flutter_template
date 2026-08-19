import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class UserModel {
  final int id;
  final String username;
  final String email;
  final String name;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
  });
  
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}