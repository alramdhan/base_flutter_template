import 'package:dartz/dartz.dart';
import 'package:login_biometrics_app/core/errors/failures.dart';
import 'package:login_biometrics_app/core/usecases/usecase.dart';
import 'package:login_biometrics_app/features/cart/domain/entities/cart_entity.dart';
import 'package:login_biometrics_app/features/cart/domain/repositories/cart_repository.dart';

class GetCart implements UseCase<CartEntity, NoParams> {
  final CartRepository repository;

  GetCart(this.repository);

  @override
  Future<Either<Failure, CartEntity>> call(NoParams params) async {
    try {
      final result = await repository.getCart();
      return Right(result);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
