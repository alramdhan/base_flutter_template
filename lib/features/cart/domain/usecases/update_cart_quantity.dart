import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:login_biometrics_app/core/errors/failures.dart';
import 'package:login_biometrics_app/core/usecases/usecase.dart';
import 'package:login_biometrics_app/features/cart/domain/entities/cart_entity.dart';
import 'package:login_biometrics_app/features/cart/domain/repositories/cart_repository.dart';

/// Update quantity item secara langsung (bukan remove+add terpisah).
/// Ini yang membuat operasi atomik — satu kali panggil repository,
/// satu kali emit state, tidak ada state antara yang tidak konsisten.
class UpdateCartQuantity implements UseCase<CartEntity, UpdateCartQuantityParams> {
  final CartRepository repository;

  UpdateCartQuantity(this.repository);

  @override
  Future<Either<Failure, CartEntity>> call(UpdateCartQuantityParams params) async {
    try {
      final result = await repository.updateQuantity(params.productId, params.newQuantity);
      return Right(result);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}

class UpdateCartQuantityParams extends Equatable {
  final int productId;
  final int newQuantity;

  const UpdateCartQuantityParams({
    required this.productId,
    required this.newQuantity,
  });

  @override
  List<Object?> get props => [productId, newQuantity];
}
