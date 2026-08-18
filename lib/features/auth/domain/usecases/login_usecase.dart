import 'package:dartz/dartz.dart';
import 'package:login_biometrics_app/core/errors/failures.dart';
import 'package:login_biometrics_app/features/auth/data/models/requests/login_request.dart';
import 'package:login_biometrics_app/features/auth/domain/entities/user.dart';
import 'package:login_biometrics_app/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  Future<Either<Failure, User>> call(LoginRequest request) async {
    return await repository.login(request.login, request.password);
  }
}