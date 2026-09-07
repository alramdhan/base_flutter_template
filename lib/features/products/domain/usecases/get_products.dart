import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:login_biometrics_app/core/errors/failures.dart';
import 'package:login_biometrics_app/core/usecases/usecase.dart';
import 'package:login_biometrics_app/features/products/domain/entities/product_page_entity.dart';
import 'package:login_biometrics_app/features/products/domain/repositories/product_repository.dart';

/// Use case: mengambil daftar produk. Satu use case = satu aksi bisnis,
/// supaya BLoC tidak langsung bergantung ke repository secara mentah.
class GetProducts implements UseCase<ProductPageEntity, GetProductsParams> {
  final ProductRepository repository;

  GetProducts(this.repository);

  @override
  Future<Either<Failure, ProductPageEntity>> call(
    GetProductsParams params,
  ) {
    return repository.getProducts(
      page: params.page,
      perPage: params.perPage,
      search: params.search,
      categoryId: params.categoryId,
      lowStockOnly: params.lowStockOnly,
    );
  }
}

class GetProductsParams extends Equatable {
  final int page;
  final int perPage;
  final String? search;
  final int? categoryId;
  final bool lowStockOnly;

  const GetProductsParams({
    this.page = 1,
    this.perPage = 15,
    this.search,
    this.categoryId,
    this.lowStockOnly = false,
  });

  @override
  List<Object?> get props => [page, perPage, search, categoryId, lowStockOnly];
}