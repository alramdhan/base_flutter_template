part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

/// Dipanggil saat halaman kasir pertama kali dibuka, untuk load cart
/// yang mungkin masih tersisa dari sesi sebelumnya (jika sudah ada persistence).
class LoadCart extends CartEvent {
  const LoadCart();
}

/// Tambah produk ke keranjang. Jika produk sudah ada, qty otomatis
/// ditambah (bukan duplikat item baru) — logic ini ada di data source.
class AddProductToCart extends CartEvent {
  final ProductEntity product;
  final int quantity;

  const AddProductToCart({required this.product, this.quantity = 1});

  @override
  List<Object?> get props => [product, quantity];
}

/// Hapus satu produk dari keranjang sepenuhnya (berapapun qty-nya).
class RemoveProductFromCart extends CartEvent {
  final int productId;

  const RemoveProductFromCart({required this.productId});

  @override
  List<Object?> get props => [productId];
}

/// Update quantity produk tertentu secara langsung (dari tombol +/- di UI).
/// Jika newQuantity <= 0, item otomatis dihapus (ditangani di repository).
class UpdateCartItemQuantity extends CartEvent {
  final int productId;
  final int newQuantity;

  const UpdateCartItemQuantity({
    required this.productId,
    required this.newQuantity,
  });

  @override
  List<Object?> get props => [productId, newQuantity];
}

/// Kosongkan seluruh keranjang (dipanggil setelah checkout berhasil,
/// atau saat kasir membatalkan transaksi).
class ClearCartItems extends CartEvent {
  const ClearCartItems();
}
