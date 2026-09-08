import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_biometrics_app/core/components/minimalist_textfield.dart';
import 'package:login_biometrics_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:login_biometrics_app/features/cart/presentation/widgets/cart_bar.dart';
import 'package:login_biometrics_app/features/cart/presentation/widgets/cart_item_list.dart';
import 'package:login_biometrics_app/features/kasir/presentation/widgets/product_masonry_grid_view.dart';
import 'package:login_biometrics_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:login_biometrics_app/features/products/presentation/widgets/category_filter_chips.dart';

class KasirPage extends StatelessWidget {
  const KasirPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: theme.colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Kasir"),
        actions: [
          Text("Profile")
        ],
        bottom: PreferredSize(
          preferredSize: const .fromHeight(104),
          child: Column(
            children: [
              Padding(
                padding: const .fromLTRB(16, 0, 8, 12),
                child: Row(
                  spacing: 8,
                  mainAxisSize: .max,
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Expanded(
                      child: _SearchField(
                        onChanged: (keyword) => {
                          context.read<ProductBloc>().add(SearchProducts(keyword))
                        },
                      ),
                    ),
                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary.withAlpha(70),
                      ),
                      onPressed: () {},
                      iconSize: 30,
                      icon: const Icon(Icons.qr_code_scanner),
                    )
                  ],
                ),
              ),
              const CategoryFilterChips()
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          const ProductMasonryGridView(),
          Align(
            alignment: Alignment.bottomCenter,
            child: CartBar(
              onCheckoutTap: () => _showCartDetailSheet(context),
            ),
          ),
        ],
      ),
    );
  }

  void _showCartDetailSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const .vertical(
              top: .circular(20),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const .all(16),
                child: Text(
                  'Detail Keranjang',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Divider(height: 0, color: Theme.of(context).dividerColor),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const .all(16),
                    child: Column(
                      children: [
                        const CartItemList(),
                        const SizedBox(height: 24),
                        BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) {
                            if (state is! CartLoaded || state.cart.isEmpty) return const SizedBox();

                            final cart = state.cart;
                            final theme = Theme.of(context);

                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: .spaceBetween,
                                  children: [
                                    Text(
                                      'Total',
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    Text(
                                      cart.totalPrice.toString(),
                                      // 'Rp\${cart.totalPrice.toString().replaceAllMapped(
                                      //   RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
                                      //   (Match m) => '\${m[1]}.',
                                      // )}',
                                      style: theme.textTheme.headlineSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: double.infinity,
                                  height: 48,
                                  child: FilledButton(
                                    onPressed: () {
                                      // TODO: navigasi ke halaman checkout/pembayaran
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Lanjut ke pembayaran...'),
                                        ),
                                      );
                                    },
                                    child: const Text('Lanjut Pembayaran'),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const _SearchField({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return MinimalistTextfield(
      onChanged: onChanged,
      hintText: 'Cari produk...',
      prefixIcon: Icons.search,
    );
  }
}