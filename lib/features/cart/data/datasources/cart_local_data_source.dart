import 'package:login_biometrics_app/features/cart/data/models/cart_item_model.dart';
import 'package:login_biometrics_app/features/products/domain/entities/product_entity.dart';

/// Local data source untuk keranjang - in-memory storage.
/// Artinya data hilang saat app ditutup (tidak ada persistence ke file/database).
/// Untuk production, integrate Hive/SQLite jika perlu persist antar session.
abstract class CartLocalDataSource {
  Future<List<CartItemModel>> getCartItems();
  Future<void> addToCart(ProductEntity product, int quantity);
  Future<void> removeFromCart(int productId);
  Future<void> updateQuantity(int productId, int newQuantity);
  Future<void> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  /// In-memory storage: list item keranjang
  final List<CartItemModel> _cartItems = [];

  @override
  Future<List<CartItemModel>> getCartItems() async {
    return Future.value(List.from(_cartItems));
  }

  @override
  Future<void> addToCart(ProductEntity product, int quantity) async {
    final index = _cartItems.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      // Produk sudah ada, tambah qty-nya
      final existing = _cartItems[index];
      _cartItems[index] = CartItemModel(
        product: existing.product,
        quantity: existing.quantity + quantity,
      );
    } else {
      // Produk baru
      _cartItems.add(CartItemModel(product: product, quantity: quantity));
    }
  }

  @override
  Future<void> removeFromCart(int productId) async {
    _cartItems.removeWhere((item) => item.product.id == productId);
  }

  @override
  Future<void> updateQuantity(int productId, int newQuantity) async {
    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (newQuantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        final item = _cartItems[index];
        _cartItems[index] = CartItemModel(
          product: item.product,
          quantity: newQuantity,
        );
      }
    }
  }

  @override
  Future<void> clearCart() async {
    _cartItems.clear();
  }
}
