import 'package:equatable/equatable.dart';
import 'package:login_biometrics_app/features/products/domain/entities/category_entity.dart';

/// Entity murni Product. Field mengikuti struktur bisnis, bukan struktur
/// response API — pemetaan JSON dilakukan di ProductModel (data layer).
class ProductEntity extends Equatable {
  final int id;
  final String name;
  final String sku;
  final String? description;
  final int price;
  final String priceFormatted;
  final int stock;
  final String unit;
  final int minStock;
  final bool isLowStock;
  final String? imageUrl;
  final bool isActive;
  final CategoryEntity? category;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.sku,
    this.description,
    required this.price,
    required this.priceFormatted,
    required this.stock,
    required this.unit,
    required this.minStock,
    required this.isLowStock,
    this.imageUrl,
    required this.isActive,
    this.category,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        sku,
        description,
        price,
        stock,
        unit,
        minStock,
        isLowStock,
        imageUrl,
        isActive,
        category,
      ];
}