import 'package:dartz/dartz.dart';
import 'package:login_biometrics_app/core/errors/exceptions.dart';
import 'package:login_biometrics_app/core/errors/failures.dart';
import 'package:login_biometrics_app/features/biometric_auth/data/datasources/biometric_local_data_source.dart';
import 'package:login_biometrics_app/features/biometric_auth/data/datasources/biometric_remote_data_source.dart';
import 'package:login_biometrics_app/features/biometric_auth/data/models/register_biometric_request.dart';
import 'package:login_biometrics_app/features/biometric_auth/domain/repositories/biometric_auth_repository.dart';

class BiometricAuthRepositoryImpl implements BiometricAuthRepository {
  final BiometricLocalDataSource localDatasource;
  final BiometricRemoteDataSource remoteDatasource;

  BiometricAuthRepositoryImpl({
    required this.localDatasource,
    required this.remoteDatasource
  });

  @override
  Future<Either<Failure, bool>> registerBiometric(String deviceId, String deviceModel, String pin) async {
    try {
      final publicKey = await localDatasource.generateAndStoreKeyPair();
      await remoteDatasource.registerBiometric(
        RegisterBiometricRequest(
          deviceId: deviceId, deviceModel: deviceModel, publicKey: publicKey, pin: pin
        )
      );

      return const Right(true);
    } on ServerException catch(e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch(e) {
      return Left(NetworkFailure(e.message));
    } catch(e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}