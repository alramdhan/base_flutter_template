import 'package:dartz/dartz.dart';
import 'package:login_biometrics_app/core/errors/failures.dart';
import 'package:login_biometrics_app/core/usecases/usecase.dart';
import 'package:login_biometrics_app/features/products/domain/entities/category_entity.dart';
import 'package:login_biometrics_app/features/products/domain/repositories/category_repository.dart';

/// Tidak butuh parameter apapun -> pakai NoParams bawaan dari core/usecase.
class GetCategories implements UseCase<List<CategoryEntity>, NoParams> {
  final CategoryRepository repository;

  GetCategories(this.repository);

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(NoParams params) {
    return repository.getCategories();
  }
}