import 'package:dartz/dartz.dart';
import 'package:login_biometrics_app/core/errors/exceptions.dart';
import 'package:login_biometrics_app/core/errors/failures.dart';
import 'package:login_biometrics_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:login_biometrics_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:login_biometrics_app/features/auth/data/models/requests/login_request.dart';
import 'package:login_biometrics_app/features/auth/domain/entities/user.dart';
import 'package:login_biometrics_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDatasource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDatasource
  });

  @override
  Future<Either<Failure, User>> login(String login, String password, bool rememberMe) async {
    try {
      final responseModel = await remoteDataSource.login(
        LoginRequest(
          login: login,
          password: password,
          isRememberMe: rememberMe
        )
      );
      await localDatasource.saveToken(responseModel.accessToken);

      return Right(responseModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      await remoteDataSource.logout();
      await localDatasource.deleteToken();

      return const Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}