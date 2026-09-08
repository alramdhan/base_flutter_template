part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

/// State awal sebelum LoadCart pertama kali dipanggil.
class CartInitial extends CartState {}

/// State normal — mencakup kasus keranjang kosong maupun berisi.
/// Sengaja digabung (bukan CartEmpty vs CartLoaded terpisah) supaya
/// UI cukup cek `cart.isEmpty`, tidak perlu banyak percabangan state.
class CartLoaded extends CartState {
  final CartEntity cart;

  /// productId yang sedang diproses (untuk nonaktifkan tombol +/- sementara
  /// agar user tidak tap berkali-kali sebelum request sebelumnya selesai).
  final int? processingProductId;

  const CartLoaded({
    required this.cart,
    this.processingProductId,
  });

  CartLoaded copyWith({
    CartEntity? cart,
    int? processingProductId,
    bool clearProcessing = false,
  }) {
    return CartLoaded(
      cart: cart ?? this.cart,
      processingProductId:
          clearProcessing ? null : (processingProductId ?? this.processingProductId),
    );
  }

  @override
  List<Object?> get props => [cart, processingProductId];
}

/// Gagal memuat/mengubah cart. UI sebaiknya tampilkan sebagai snackbar,
/// bukan mengganti seluruh layar, karena cart error tidak fatal.
class CartError extends CartState {
  final String message;
  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}
