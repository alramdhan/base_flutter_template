import 'package:dartz/dartz.dart';
import 'package:login_biometrics_app/core/errors/failures.dart';
import 'package:login_biometrics_app/features/products/domain/entities/product_page_entity.dart';

/// Kontrak repository di domain layer. Implementasinya ada di data layer
/// (ProductRepositoryImpl), sehingga domain & presentation tidak perlu
/// tahu detail Dio/HTTP sama sekali — memudahkan unit test (bisa di-mock).
abstract class ProductRepository {
  Future<Either<Failure, ProductPageEntity>> getProducts({
    required int page,
    int perPage = 15,
    String? search,
    int? categoryId,
    bool lowStockOnly = false,
  });
}