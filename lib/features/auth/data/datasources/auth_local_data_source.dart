import 'package:login_biometrics_app/core/services/secure_storage_service.dart';
import 'package:login_biometrics_app/core/constants/secure_storage_keys.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorageService secureStorage;

  AuthLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<void> deleteToken() async {
    await secureStorage.deleteAuthToken();
  }

  @override
  Future<String?> getToken() async {
    return await secureStorage.getAuthToken();
  }

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.setKey(SecureStorageKeys.authToken, token);
  }
  
}