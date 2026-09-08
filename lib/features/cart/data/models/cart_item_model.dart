import 'package:login_biometrics_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:login_biometrics_app/features/products/data/models/product_model.dart';

/// Model untuk CartItem, dipakai saat perlu persistence (Hive/SQLite)
/// atau dikirim sebagai payload checkout ke API Laravel.
class CartItemModel extends CartItemEntity {
  const CartItemModel({
    required super.product,
    required super.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
    );
  }

  /// Payload ringkas untuk dikirim ke API saat checkout —
  /// backend cukup butuh product_id & quantity, harga dihitung ulang
  /// di server demi keamanan (jangan percaya harga dari client).
  Map<String, dynamic> toJson() => {
    'product_id': product.id,
    'quantity': quantity,
  };
}
