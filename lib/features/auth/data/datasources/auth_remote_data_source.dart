import 'package:login_biometrics_app/features/auth/data/models/auth_response_model.dart';
import 'package:login_biometrics_app/features/auth/data/models/requests/login_request.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login(LoginRequest request);
  Future<bool> logout();
}