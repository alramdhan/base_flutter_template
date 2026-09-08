import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:login_biometrics_app/core/errors/failures.dart';
import 'package:login_biometrics_app/core/usecases/usecase.dart';
import 'package:login_biometrics_app/features/cart/domain/entities/cart_entity.dart';
import 'package:login_biometrics_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:login_biometrics_app/features/products/domain/entities/product_entity.dart';

class AddToCart implements UseCase<CartEntity, AddToCartParams> {
  final CartRepository repository;

  AddToCart(this.repository);

  @override
  Future<Either<Failure, CartEntity>> call(AddToCartParams params) async {
    try {
      final result = await repository.addToCart(params.product, params.quantity);
      return Right(result);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}

class AddToCartParams extends Equatable {
  final ProductEntity product;
  final int quantity;

  const AddToCartParams({required this.product, required this.quantity});

  @override
  List<Object?> get props => [product, quantity];
}
