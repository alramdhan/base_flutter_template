import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_biometrics_app/core/usecases/usecase.dart';
import 'package:login_biometrics_app/features/cart/domain/entities/cart_entity.dart';
import 'package:login_biometrics_app/features/cart/domain/usecases/add_to_cart.dart';
import 'package:login_biometrics_app/features/cart/domain/usecases/clear_cart.dart';
import 'package:login_biometrics_app/features/cart/domain/usecases/get_cart.dart';
import 'package:login_biometrics_app/features/cart/domain/usecases/remove_from_cart.dart';
import 'package:login_biometrics_app/features/cart/domain/usecases/update_cart_quantity.dart';
import 'package:login_biometrics_app/features/products/domain/entities/product_entity.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCart getCart;
  final AddToCart addToCart;
  final RemoveFromCart removeFromCart;
  final UpdateCartQuantity updateCartQuantity;
  final ClearCart clearCart;

  CartBloc({
    required this.getCart,
    required this.addToCart,
    required this.removeFromCart,
    required this.updateCartQuantity,
    required this.clearCart,
  }) : super(CartInitial()) {
    // --- Kunci best practice: transformer `sequential()` ---
    // Semua event cart diproses SATU PER SATU sesuai urutan masuk,
    // bukan paralel. Ini krusial untuk cart karena:
    // 1. Kalau user tap "+" 3 kali cepat pada item yang sama, tiap tap
    //    harus diproses berurutan berdasarkan hasil tap sebelumnya —
    //    kalau paralel (concurrent), hasil akhirnya bisa salah karena
    //    3 request "baca qty lama -> +1" jalan bersamaan dari qty yang sama.
    // 2. Add + Remove + Update pada waktu berdekatan juga harus konsisten
    //    urutannya, tidak boleh event yang datang belakangan selesai duluan.
    on<LoadCart>(_onLoadCart, transformer: sequential());
    on<AddProductToCart>(_onAddProduct, transformer: sequential());
    on<RemoveProductFromCart>(_onRemoveProduct, transformer: sequential());
    on<UpdateCartItemQuantity>(_onUpdateQuantity, transformer: sequential());
    on<ClearCartItems>(_onClearCart, transformer: sequential());
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    final result = await getCart(const NoParams());
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cart) => emit(CartLoaded(cart: cart)),
    );
  }

  Future<void> _onAddProduct(
    AddProductToCart event,
    Emitter<CartState> emit,
  ) async {
    // Tandai produk ini sedang diproses (opsional dipakai UI untuk
    // menonaktifkan tap ganda pada card yang sama).
    _emitProcessing(emit, event.product.id);

    final result = await addToCart(
      AddToCartParams(product: event.product, quantity: event.quantity),
    );

    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cart) => emit(CartLoaded(cart: cart)),
    );
  }

  Future<void> _onRemoveProduct(
    RemoveProductFromCart event,
    Emitter<CartState> emit,
  ) async {
    _emitProcessing(emit, event.productId);

    final result = await removeFromCart(
      RemoveFromCartParams(productId: event.productId),
    );

    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cart) => emit(CartLoaded(cart: cart)),
    );
  }

  Future<void> _onUpdateQuantity(
    UpdateCartItemQuantity event,
    Emitter<CartState> emit,
  ) async {
    _emitProcessing(emit, event.productId);

    // Update qty dilakukan LANGSUNG lewat satu use case atomik —
    // bukan remove() lalu add() terpisah seperti implementasi lama.
    // Ini mencegah item "pindah posisi" di list dan mencegah state
    // antara yang tidak konsisten kalau ada error di tengah proses.
    final result = await updateCartQuantity(
      UpdateCartQuantityParams(
        productId: event.productId,
        newQuantity: event.newQuantity,
      ),
    );

    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cart) => emit(CartLoaded(cart: cart)),
    );
  }

  Future<void> _onClearCart(
    ClearCartItems event,
    Emitter<CartState> emit,
  ) async {
    final result = await clearCart(const NoParams());
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cart) => emit(CartLoaded(cart: cart)),
    );
  }

  /// Helper kecil: emit state saat ini dengan flag processingProductId,
  /// supaya UI bisa kasih feedback visual (misal disable tombol sebentar)
  /// tanpa harus menunggu network/database selesai.
  void _emitProcessing(Emitter<CartState> emit, int productId) {
    final current = state;
    if (current is CartLoaded) {
      emit(current.copyWith(processingProductId: productId));
    }
  }
}
