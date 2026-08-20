import 'package:fast_rsa/fast_rsa.dart';
import 'package:login_biometrics_app/core/helpers/secure_storage_helper.dart';
import 'package:login_biometrics_app/core/helpers/secure_storage_keys.dart';

abstract class BiometricLocalDataSource {
  Future<String> generateAndStoreKeyPair();
}

class BiometricLocalDataSourceImpl implements BiometricLocalDataSource {
  final SecureStorageHelper secureStorage;

  BiometricLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<String> generateAndStoreKeyPair() async {
    final keyPair = await RSA.generate(2048);
    await secureStorage.setKey(SecureStorageKeys.biometricPrivateKey, keyPair.privateKey);

    return keyPair.publicKey;
  }
  
}