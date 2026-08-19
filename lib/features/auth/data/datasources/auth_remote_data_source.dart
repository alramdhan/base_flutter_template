import 'package:login_biometrics_app/features/auth/data/models/auth_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login(String login, String password);
}