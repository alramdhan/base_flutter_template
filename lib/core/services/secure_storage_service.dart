import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_biometrics_app/core/constants/secure_storage_keys.dart';
import 'package:login_biometrics_app/core/utils/app_logger.dart';

abstract class SecureStorageService {
  Future<void> saveAuthToken(String token);
  Future<String?> getAuthToken();
  Future<void> deleteAuthToken();
  Future<void> setKey(String key, String value);
  Future<String?> getKey(String key);
  Future<void> setBiometricStatus(bool isEnabled);
  Future<bool> getBiometricState();
  Future<void> clearAllData();
}

class SecureStorageServiceImpl implements SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageServiceImpl(this._storage);
  
  @override
  Future<void> clearAllData() async {
    await _storage.deleteAll();
  }
  
  @override
  Future<void> deleteAuthToken() async {
    AppLogger.instance.info("access token deleted.");
    await _storage.delete(key: SecureStorageKeys.authToken);
  }
  
  @override
  Future<String?> getAuthToken() async {
    return await _storage.read(key: SecureStorageKeys.authToken);
  }
  
  @override
  Future<bool> getBiometricState() async {
    final status = await _storage.read(key: SecureStorageKeys.hasBiometricEnabled);
    final hasAuthToken = await getKey(SecureStorageKeys.biometricPrivateKey);
    return status == 'true' && (hasAuthToken != null && hasAuthToken.isNotEmpty);
  }
  
  @override
  Future<String?> getKey(String key) async {
    return await _storage.read(key: key);
  }
  
  @override
  Future<void> setBiometricStatus(bool isEnabled) async {
    await _storage.write(key: SecureStorageKeys.hasBiometricEnabled, value: isEnabled.toString());
  }
  
  @override
  Future<void> saveAuthToken(String token) async {
    await _storage.write(key: SecureStorageKeys.authToken, value: token);
  }
  
  @override
  Future<void> setKey(String key, String value) async {
    await _storage.write(key: key, value: value);
  }
}