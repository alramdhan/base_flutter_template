import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_biometrics_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:login_biometrics_app/features/products/presentation/widgets/product_grid_view.dart';
import 'package:login_biometrics_app/service_locator.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ProductBloc diambil dari service locator (get_it) yang sudah didaftarkan
    // di injection_container.dart, lalu langsung fetch data halaman pertama.
    return BlocProvider(
      create: (_) => sl<ProductBloc>()..add(const FetchProducts()),
      child: const _ProductListView(),
    );
  }
}

class _ProductListView extends StatelessWidget {
  const _ProductListView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading || state is ProductInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProductError) {
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
          child: ProductGridView(
            products: loadedState.products,
            isLoadingMore: loadedState.isLoadingMore,
            onProductTap: (product) {
              // TODO: navigasi ke halaman detail produk.
            },
          ),
        );
      }
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
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off_rounded, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
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
        mainAxisSize: MainAxisSize.min,
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