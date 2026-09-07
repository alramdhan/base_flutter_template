import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_biometrics_app/features/products/domain/entities/product_entity.dart';
import 'package:login_biometrics_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:login_biometrics_app/features/products/presentation/widgets/product_card.dart';

class ProductGridView extends StatefulWidget {
  final List<ProductEntity> products;
  final bool isLoadingMore;
  final void Function(ProductEntity product)? onProductTap;

  const ProductGridView({
    super.key,
    required this.products,
    this.isLoadingMore = false,
    this.onProductTap,
  });

  @override
  State<ProductGridView> createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {
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
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(12),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.62,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final product = widget.products[index];
                return ProductCard(
                  product: product,
                  onTap: () => widget.onProductTap?.call(product),
                );
              },
              childCount: widget.products.length,
            ),
          ),
        ),

        // Spinner "load more" full width, terpisah dari grid cell.
        if (widget.isLoadingMore)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),

        const SliverToBoxAdapter(child: SizedBox(height: 12)),
      ],
    );
  }
}