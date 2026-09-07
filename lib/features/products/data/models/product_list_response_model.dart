import 'package:login_biometrics_app/features/products/data/models/product_model.dart';
import 'package:login_biometrics_app/features/products/domain/entities/product_page_entity.dart';

/// Mapping ke response index() di ProductController Laravel:
/// { success, message, data: [...], meta: { current_page, last_page, per_page, total } }
class ProductListResponseModel extends ProductPageEntity {
  const ProductListResponseModel({
    required super.products,
    required super.currentPage,
    required super.lastPage,
    required super.total,
  });

  factory ProductListResponseModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> data = json['data'] as List<dynamic>? ?? [];
    final Map<String, dynamic> meta =
        json['meta'] as Map<String, dynamic>? ?? {};

    return ProductListResponseModel(
      products: data
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      currentPage: meta['current_page'] as int? ?? 1,
      lastPage: meta['last_page'] as int? ?? 1,
      total: meta['total'] as int? ?? 0,
    );
  }
}