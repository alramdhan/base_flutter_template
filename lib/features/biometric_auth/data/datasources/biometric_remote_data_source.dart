import 'package:login_biometrics_app/core/constants/api_constants.dart';
import 'package:login_biometrics_app/core/network/api_client.dart';
import 'package:login_biometrics_app/features/auth/data/models/auth_response_model.dart';
import 'package:login_biometrics_app/features/biometric_auth/data/models/register_biometric_request.dart';

abstract class BiometricRemoteDataSource {
  Future<void> registerBiometric(RegisterBiometricRequest request);
  Future<AuthResponseModel> verifyBiometric();
}

class BiometricRemoteDataSourceImpl implements BiometricRemoteDataSource {
  final ApiClient apiClient;

  BiometricRemoteDataSourceImpl(this.apiClient);

  @override
  Future<void> registerBiometric(RegisterBiometricRequest request) {
    return apiClient.post<bool>(
      ApiConstants.endpoints.registerBiometric,
      data: request.toJson(),
      fromJson: (responseData) => true,
    );
  }

  @override
  Future<AuthResponseModel> verifyBiometric() async {
    return apiClient.post<AuthResponseModel>(
      ApiConstants.endpoints.verifyBiometric,
      data: {},
      fromJson: (responseData) => AuthResponseModel.fromJson(responseData)
    );
  }
  
}