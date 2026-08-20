import 'package:login_biometrics_app/core/constants/api_constants.dart';
import 'package:login_biometrics_app/core/network/api_client.dart';
import 'package:login_biometrics_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:login_biometrics_app/features/auth/data/models/auth_response_model.dart';
import 'package:login_biometrics_app/features/auth/data/models/requests/login_request.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<AuthResponseModel> login(LoginRequest request) async {
    return apiClient.post<AuthResponseModel>(
      ApiConstants.endpoints.login,
      data: request.toJson(),
      fromJson: (responseData) => AuthResponseModel.fromJson(responseData),
    );
  }
  
  @override
  Future<bool> logout() {
    return apiClient.post<bool>(
      ApiConstants.endpoints.login,
      // data: request.toJson(),
      fromJson: (responseData) => true,
    );
  }
}