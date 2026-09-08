import 'package:equatable/equatable.dart';
import 'package:login_biometrics_app/features/cart/domain/entities/cart_item_entity.dart';

/// Entity untuk seluruh state keranjang belanja.
class CartEntity extends Equatable {
  final List<CartItemEntity> items;

  const CartEntity({required this.items});

  /// Total jumlah item (sum dari quantity semua item)
  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  /// Total harga (sum dari subtotal semua item)
  int get totalPrice => items.fold(0, (sum, item) => sum + item.subtotal);

  /// Check apakah keranjang kosong
  bool get isEmpty => items.isEmpty;

  @override
  List<Object?> get props => [items];
}
