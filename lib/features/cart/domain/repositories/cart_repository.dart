import 'package:login_biometrics_app/features/cart/domain/entities/cart_entity.dart';
import 'package:login_biometrics_app/features/products/domain/entities/product_entity.dart';

/// Kontrak repository untuk operasi keranjang.
abstract class CartRepository {
  /// Ambil isi keranjang terkini
  Future<CartEntity> getCart();

  /// Tambah produk ke keranjang
  /// Jika produk sudah ada, qty ditambah, bukan item baru
  Future<CartEntity> addToCart(ProductEntity product, int quantity);

  /// Kurangi qty item, atau hapus jika qty jadi 0
  Future<CartEntity> removeFromCart(int productId);

  /// Update quantity item tertentu
  Future<CartEntity> updateQuantity(int productId, int newQuantity);

  /// Kosongkan keranjang
  Future<CartEntity> clearCart();
}
