import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:login_biometrics_app/core/errors/failures.dart';
import 'package:login_biometrics_app/core/usecases/usecase.dart';
import 'package:login_biometrics_app/features/cart/domain/entities/cart_entity.dart';
import 'package:login_biometrics_app/features/cart/domain/repositories/cart_repository.dart';

class RemoveFromCart implements UseCase<CartEntity, RemoveFromCartParams> {
  final CartRepository repository;

  RemoveFromCart(this.repository);

  @override
  Future<Either<Failure, CartEntity>> call(RemoveFromCartParams params) async {
    try {
      final result = await repository.removeFromCart(params.productId);
      return Right(result);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}

class RemoveFromCartParams extends Equatable {
  final int productId;

  const RemoveFromCartParams({required this.productId});

  @override
  List<Object?> get props => [productId];
}
