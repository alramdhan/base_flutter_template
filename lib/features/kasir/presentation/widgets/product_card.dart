import 'package:flutter/material.dart';
import 'package:login_biometrics_app/features/products/domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.onTap
  });

  final ProductEntity product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOutOfStock = product.stock <= 0;

    return Card(
      elevation: 1.5,
      clipBehavior: .antiAlias,
      shape: RoundedRectangleBorder(borderRadius: .circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            // --- Gambar produk + badge stok menumpuk di pojok ---
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _ProductImage(imageUrl: product.imageUrl),
                  Positioned(
                    bottom: 6,
                    right: 8,
                    child: Text(
                      'Stok: ${product.stock} ${product.unit}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isOutOfStock
                          ? theme.colorScheme.error
                          : Colors.grey.shade600,
                      ),
                    ),
                  ),
                  if (isOutOfStock)
                    Container(
                      color: Colors.black.withOpacity(0.45),
                      alignment: Alignment.center,
                      child: const Text(
                        'STOK HABIS',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 0.5,
                        ),
                      ),
                    )
                  else if (product.isLowStock)
                    Positioned(
                      top: 6,
                      left: 6,
                      child: _Badge(
                        label: 'Stok Menipis',
                        color: Colors.orange.shade700,
                      ),
                    ),
                ],
              ),
            ),
            // --- Info produk ---
            Padding(
              padding: const .fromLTRB(10, 8, 10, 10),
              child: Column(
                spacing: 2,
                crossAxisAlignment: .start,
                children: [
                  Text(
                    product.name,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: .w600,
                      fontSize: 12
                    ),
                    maxLines: 2,
                    overflow: .ellipsis,
                  ),
                  Text(
                    product.priceFormatted,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: .bold,
                      fontSize: 15,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final String? imageUrl;
  const _ProductImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _placeholder();
    }

    return Image.network(
      imageUrl!,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          color: Colors.grey.shade200,
          alignment: .center,
          child: const CircularProgressIndicator(strokeWidth: 2),
        );
      },
      errorBuilder: (context, error, stackTrace) => _placeholder(),
    );
  }

  Widget _placeholder() {
    return Container(
      color: Colors.grey.shade200,
      alignment: .center,
      child: Icon(Icons.inventory_2_outlined, size: 36, color: Colors.grey.shade400),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  const _Badge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: .circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: .bold,
        ),
      ),
    );
  }
}