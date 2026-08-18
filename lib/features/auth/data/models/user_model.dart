import 'package:json_annotation/json_annotation.dart';
import 'package:login_biometrics_app/features/auth/domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.name,
    required super.accessToken,
  });
  
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}