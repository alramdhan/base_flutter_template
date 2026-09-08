import 'package:equatable/equatable.dart';
import 'package:login_biometrics_app/features/products/domain/entities/product_entity.dart';

/// Representasi satu item di keranjang belanja.
/// Bedanya dengan ProductEntity: CartItem punya `quantity` (jumlah diambil pembeli).
class CartItemEntity extends Equatable {
  final ProductEntity product;
  final int quantity;

  const CartItemEntity({
    required this.product,
    required this.quantity,
  });

  /// Total harga item ini (price * quantity)
  int get subtotal => product.price * quantity;

  @override
  List<Object?> get props => [product, quantity];
}