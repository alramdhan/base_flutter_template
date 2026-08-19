import 'package:login_biometrics_app/core/helpers/secure_storage_helper.dart';
import 'package:login_biometrics_app/core/helpers/secure_storage_keys.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorageHelper secureStorage;

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