import 'package:dartz/dartz.dart';
import 'package:login_biometrics_app/core/errors/failures.dart';
import 'package:login_biometrics_app/features/biometric_auth/domain/repositories/biometric_auth_repository.dart';

class RegisterBiometricUsecase {
  final BiometricAuthRepository repository;

  RegisterBiometricUsecase(this.repository);

  Future<Either<Failure, bool>> call(String deviceId, String deviceModel, String pin) async {
    return await repository.registerBiometric(deviceId, deviceModel, pin);
  }
}