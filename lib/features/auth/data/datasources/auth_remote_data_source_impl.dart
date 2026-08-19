import 'package:login_biometrics_app/core/constants/api_constants.dart';
import 'package:login_biometrics_app/core/network/api_client.dart';
import 'package:login_biometrics_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:login_biometrics_app/features/auth/data/models/user_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<UserModel> login(String login, String password) async {
    return apiClient.post<UserModel>(
      ApiConstants.endpoints.login,
      data: {
        'login': login,
        'password': password,
      },
      fromJson: (responseData) => UserModel.fromJson(responseData),
    );
  }
}