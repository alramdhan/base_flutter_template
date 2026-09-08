import 'package:flutter/material.dart';
import 'package:login_biometrics_app/features/products/domain/entities/product_entity.dart';

/// Card produk dirancang agar user bisa langsung paham 3 hal penting
/// tanpa perlu tap: (1) apa produknya, (2) berapa harganya,
/// (3) apakah stoknya aman/menipis/habis.
class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOutOfStock = product.stock <= 0;

    return Card(
      clipBehavior: .antiAlias,
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: .start,
          children: [
            // --- Gambar produk + badge stok menumpuk di pojok ---
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _ProductImage(imageUrl: product.imageUrl),
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
            Expanded(
              child: Padding(
                padding: const .fromLTRB(10, 8, 10, 10),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    if (product.category != null)
                      Text(
                        product.category!.name,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: .w600,
                        ),
                        maxLines: 1,
                        overflow: .ellipsis,
                      ),
                    const SizedBox(height: 2),
                    Text(
                      product.name,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: .w600,
                      ),
                      maxLines: 2,
                      overflow: .ellipsis,
                    ),
                    const Spacer(),
                    Text(
                      product.priceFormatted,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: .bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Stok: ${product.stock} ${product.unit}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isOutOfStock
                          ? theme.colorScheme.error
                          : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
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