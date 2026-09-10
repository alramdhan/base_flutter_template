import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:login_biometrics_app/core/utils/app_logger.dart';
import 'package:login_biometrics_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:login_biometrics_app/features/kasir/presentation/widgets/product_card.dart';
import 'package:login_biometrics_app/features/kasir/presentation/widgets/skeleton_product_card.dart';
import 'package:login_biometrics_app/features/products/presentation/bloc/product_bloc.dart';

class ProductMasonryGridView extends StatefulWidget {
  const ProductMasonryGridView({super.key});

  @override
  State<ProductMasonryGridView> createState() => _ProductMasonryGridViewState();
}

class _ProductMasonryGridViewState extends State<ProductMasonryGridView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    // Trigger fetch halaman berikutnya saat mendekati 300px dari bawah
    // agar scroll terasa mulus, tidak menunggu benar-benar mentok.
    final threshold = _scrollController.position.maxScrollExtent - 300;
    if (_scrollController.position.pixels >= threshold) {
      context.read<ProductBloc>().add(const FetchNextProductPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading || state is ProductInitial) {
          return GridView.builder(
            padding: const .only(left: 16, top: 8, right: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: .68
            ),
            itemCount: 10,
            itemBuilder: (context, index) {
              return const SkeletonProductCard();
            }
          );
        }

        if (state is ProductError) {
          AppLogger.instance.error("loadste ${state.message}");
          return _ErrorView(
            message: state.message,
            onRetry: () =>
                context.read<ProductBloc>().add(const FetchProducts()),
          );
        }

        final loadedState = state as ProductLoaded;

        if (loadedState.products.isEmpty) {
          return const _EmptyView();
        }

        return RefreshIndicator(
          onRefresh: () async {
            context.read<ProductBloc>().add(const RefreshProducts());
            // Beri jeda kecil supaya animasi refresh indicator terasa natural.
            await Future<void>.delayed(const Duration(milliseconds: 500));
          },
          child: MasonryGridView.builder(
            controller: _scrollController,
            padding: const .only(left: 16, top: 8, right: 16),
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            itemCount: loadedState.products.length,
            itemBuilder: (context, index) {
              final product = loadedState.products[index];

              return ProductCard(
                product: product,
                onTap: () {
                  context.read<CartBloc>().add(AddProductToCart(product: product));
                  // onTap?.call();
                },
              );
            },
          ),
        );
      },
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const .all(24),
        child: Column(
          mainAxisSize: .min,
          children: [
            Icon(Icons.wifi_off_rounded, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: .center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: onRetry, child: const Text('Coba Lagi')),
          ],
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: .min,
        children: [
          Icon(Icons.inventory_2_outlined, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text(
            'Produk tidak ditemukan',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}