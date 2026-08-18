import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_biometrics_app/core/utils/secure_storage_keys.dart';

abstract class SecureStorageHelper {
  Future<void> saveAuthToken(String token);
  Future<String?> getAuthToken();
  Future<void> deleteAuthToken();
  Future<void> setKey(String key, String value);
  Future<String?> getKey(String key);
  Future<void> safeBiometricStatus(bool isEnabled);
  Future<bool> getBiometricStatus();
  Future<void> clearAllData();
}

class SecureStorageHelperImpl implements SecureStorageHelper {
  final FlutterSecureStorage _storage;

  SecureStorageHelperImpl(this._storage);
  
  @override
  Future<void> clearAllData() async {
    await _storage.deleteAll();
  }
  
  @override
  Future<void> deleteAuthToken() async {
    await _storage.delete(key: SecureStorageKeys.authToken);
  }
  
  @override
  Future<String?> getAuthToken() async {
    return await _storage.read(key: SecureStorageKeys.authToken);
  }
  
  @override
  Future<bool> getBiometricStatus() async {
    final status = await _storage.read(key: SecureStorageKeys.hasBiometricEnabled);
    return status == 'true';
  }
  
  @override
  Future<String?> getKey(String key) async {
    return await _storage.read(key: key);
  }
  
  @override
  Future<void> safeBiometricStatus(bool isEnabled) async {
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