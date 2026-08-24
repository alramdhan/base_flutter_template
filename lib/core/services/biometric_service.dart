import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import 'package:login_biometrics_app/core/utils/app_logger.dart';

class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> isBiometricReady() async {
    try {
      final canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final canAuthenticate = canAuthenticateWithBiometrics || await _auth.isDeviceSupported();

      return canAuthenticate;
    } catch (e, stackTrace) {
      AppLogger.instance.error("Gagal mengecek status biometrik", e, stackTrace);
      return false;
    }
  }

  Future<bool> authenticate({String reason = "Silangkan autentikasi untuk melanjutkan"}) async {
    try {
      if(!await isBiometricReady()) return false;

      return await _auth.authenticate(
        localizedReason: reason,
        authMessages: const [
          AndroidAuthMessages(
            signInTitle: "Autentikasi diperlukan",
            cancelButton: "Batal"
          ),
          IOSAuthMessages(
            cancelButton: "Batal"
          )
        ]
      );
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code, message: e.message ?? "Platform exception");
    } catch (e) {
      throw Exception(e);
    }
  }
}