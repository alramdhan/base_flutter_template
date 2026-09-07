import 'package:equatable/equatable.dart';
import 'package:login_biometrics_app/features/products/domain/entities/product_entity.dart';

/// Membungkus daftar produk beserta info pagination dari server,
/// supaya BLoC tahu apakah masih ada halaman berikutnya untuk infinite scroll.
class ProductPageEntity extends Equatable {
  final List<ProductEntity> products;
  final int currentPage;
  final int lastPage;
  final int total;

  const ProductPageEntity({
    required this.products,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });

  bool get hasReachedMax => currentPage >= lastPage;

  @override
  List<Object?> get props => [products, currentPage, lastPage, total];
}