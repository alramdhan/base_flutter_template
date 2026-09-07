import 'package:login_biometrics_app/features/products/data/models/category_model.dart';
import 'package:login_biometrics_app/features/products/domain/entities/product_entity.dart';

/// Mapping 1:1 dengan struktur JSON dari ProductResource di Laravel:
/// { id, name, sku, description, price, price_formatted, stock, unit,
///   min_stock, is_low_stock, image_url, is_active, category, ... }
class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.sku,
    super.description,
    required super.price,
    required super.priceFormatted,
    required super.stock,
    required super.unit,
    required super.minStock,
    required super.isLowStock,
    super.imageUrl,
    required super.isActive,
    super.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      sku: json['sku'] as String,
      description: json['description'] as String?,
      price: json['price'] as int,
      priceFormatted: json['price_formatted'] as String? ?? '',
      stock: json['stock'] as int? ?? 0,
      unit: json['unit'] as String? ?? '',
      minStock: json['min_stock'] as int? ?? 0,
      isLowStock: json['is_low_stock'] as bool? ?? false,
      imageUrl: json['image_url'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'] as Map<String, dynamic>)
          : null,
    );
  }
}