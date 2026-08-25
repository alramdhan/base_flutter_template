import 'package:dartz/dartz.dart';
import 'package:login_biometrics_app/core/errors/failures.dart';
import 'package:login_biometrics_app/features/auth/domain/entities/user.dart';

abstract class BiometricAuthRepository {
  Future<Either<Failure, bool>> registerBiometric(
    String deviceId,
    String deviceModel,
    String pin
  );

  Future<Either<Failure, User>> verifyBiometric(String pubKey);
}