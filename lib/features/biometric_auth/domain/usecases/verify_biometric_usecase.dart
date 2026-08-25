import 'package:dartz/dartz.dart';
import 'package:login_biometrics_app/core/errors/failures.dart';
import 'package:login_biometrics_app/features/auth/domain/entities/user.dart';
import 'package:login_biometrics_app/features/biometric_auth/domain/repositories/biometric_auth_repository.dart';

class VerifyBiometricUsecase {
  final BiometricAuthRepository repository;

  VerifyBiometricUsecase(this.repository);

  Future<Either<Failure, User>> call(String pubKey) async {
    return await repository.verifyBiometric(pubKey);
  }
}