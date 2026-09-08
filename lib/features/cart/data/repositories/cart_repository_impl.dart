import 'package:login_biometrics_app/features/cart/data/datasources/cart_local_data_source.dart';
import 'package:login_biometrics_app/features/cart/domain/entities/cart_entity.dart';
import 'package:login_biometrics_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:login_biometrics_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:login_biometrics_app/features/products/domain/entities/product_entity.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl({required this.localDataSource});

  @override
  Future<CartEntity> addToCart(ProductEntity product, int quantity) async {
    await localDataSource.addToCart(product, quantity);
    return _getCartEntity();
  }

  @override
  Future<CartEntity> clearCart() async {
    await localDataSource.clearCart();
    return _getCartEntity();
  }

  @override
  Future<CartEntity> getCart() async {
    return _getCartEntity();
  }

  @override
  Future<CartEntity> removeFromCart(int productId) async {
    await localDataSource.removeFromCart(productId);
    return _getCartEntity();
  }

  @override
  Future<CartEntity> updateQuantity(int productId, int newQuantity) async {
    await localDataSource.updateQuantity(productId, newQuantity);
    return _getCartEntity();
  }

  /// Helper: ambil seluruh cart state sebagai CartEntity
  Future<CartEntity> _getCartEntity() async {
    final items = await localDataSource.getCartItems();
    return CartEntity(
      items: items.cast<CartItemEntity>(),
    );
  }
}
