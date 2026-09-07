import 'package:dartz/dartz.dart';
import 'package:login_biometrics_app/core/errors/exceptions.dart';
import 'package:login_biometrics_app/core/errors/failures.dart';
import 'package:login_biometrics_app/features/products/data/datasources/product_remote_data_source.dart';
import 'package:login_biometrics_app/features/products/domain/entities/product_page_entity.dart';
import 'package:login_biometrics_app/features/products/domain/repositories/product_repository.dart';

/// Implementasi konkret dari kontrak ProductRepository.
/// Tugasnya hanya satu: memanggil data source, lalu menerjemahkan
/// Exception -> Failure supaya domain/presentation tidak pernah
/// bersentuhan langsung dengan detail Dio.
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ProductPageEntity>> getProducts({
    required int page,
    int perPage = 15,
    String? search,
    int? categoryId,
    bool lowStockOnly = false,
  }) async {
    try {
      final result = await remoteDataSource.getProducts(
        page: page,
        perPage: perPage,
        search: search,
        categoryId: categoryId,
        lowStockOnly: lowStockOnly,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}