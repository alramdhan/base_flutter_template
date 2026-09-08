import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_biometrics_app/features/cart/presentation/bloc/cart_bloc.dart';

/// Bar keranjang sticky di bawah. Menampilkan icon cart + badge jumlah
/// item + total harga + tombol checkout.
class CartBar extends StatelessWidget {
  final VoidCallback? onCheckoutTap;

  const CartBar({super.key, this.onCheckoutTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is! CartLoaded || state.cart.isEmpty) {
          return const SizedBox.shrink();
        }

        final cart = state.cart;
        final theme = Theme.of(context);

        return Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: theme.dividerColor, width: 0.5)),
            color: theme.colorScheme.surface,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.shopping_cart,
                          color: theme.colorScheme.onPrimary, size: 20),
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.error,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${cart.totalItems}',
                        style: TextStyle(
                          color: theme.colorScheme.onError,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${cart.totalItems} item',
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: theme.colorScheme.outline)),
                      Text(
                        _formatRupiah(cart.totalPrice),
                        style: theme.textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton(onPressed: onCheckoutTap, child: const Text('Bayar')),
              ],
            ),
          ),
        );
      },
    );
  }
}

String _formatRupiah(int value) {
  return 'Rp${value.toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]}.',
      )}';
}
