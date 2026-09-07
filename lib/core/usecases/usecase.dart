import 'package:dartz/dartz.dart';
import 'package:login_biometrics_app/core/errors/failures.dart';

/// Kontrak dasar semua use case: menerima [Params], mengembalikan
/// Either<Failure, Type> — Left jika gagal, Right jika berhasil.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Dipakai untuk use case yang tidak butuh parameter apapun.
class NoParams {
  const NoParams();
}