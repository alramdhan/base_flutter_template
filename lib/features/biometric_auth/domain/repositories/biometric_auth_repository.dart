import 'package:dartz/dartz.dart';
import 'package:login_biometrics_app/core/errors/failures.dart';

abstract class BiometricAuthRepository {
  Future<Either<Failure, bool>> registerBiometric(
    String deviceId,
    String deviceModel,
    String pin
  );
}