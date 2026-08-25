import 'package:fast_rsa/fast_rsa.dart';
import 'package:login_biometrics_app/core/services/secure_storage_service.dart';
import 'package:login_biometrics_app/core/constants/secure_storage_keys.dart';

abstract class BiometricLocalDataSource {
  Future<String> generateAndStoreKeyPair();
  Future<void> setBiometricEnable();
}

class BiometricLocalDataSourceImpl implements BiometricLocalDataSource {
  final SecureStorageService secureStorage;

  BiometricLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<String> generateAndStoreKeyPair() async {
    final keyPair = await RSA.generate(2048);
    await secureStorage.setKey(SecureStorageKeys.biometricPrivateKey, keyPair.privateKey);

    return keyPair.publicKey;
  }
  
  @override
  Future<void> setBiometricEnable() async {
    await secureStorage.setBiometricStatus(true);
  }
}