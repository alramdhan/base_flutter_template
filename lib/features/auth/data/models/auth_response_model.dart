import 'package:json_annotation/json_annotation.dart';
import 'package:login_biometrics_app/features/auth/data/models/user_model.dart';
import 'package:login_biometrics_app/features/auth/domain/entities/user.dart';

part 'auth_response_model.g.dart';

@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class AuthResponseModel {
  final UserModel user;
  final String accessToken;
  final String tokenType;

  const AuthResponseModel({
    required this.user,
    required this.accessToken,
    required this.tokenType
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) => _$AuthResponseModelFromJson(json);

  User toEntity() {
    return User(
      id: user.id,
      name: user.name,
      email: user.email,
      username: user.username,
      accessToken: accessToken
    );
  }
}