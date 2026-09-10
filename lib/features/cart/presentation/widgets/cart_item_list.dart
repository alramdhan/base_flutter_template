import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_biometrics_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:login_biometrics_app/features/cart/presentation/bloc/cart_bloc.dart';

/// List item keranjang dengan qty control +/- dan tombol hapus.
/// Biasanya dipakai di dalam bottom sheet detail keranjang.
class CartItemList extends StatelessWidget {
  const CartItemList(this.items, {super.key});

  final List<CartItemEntity> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, _) => Divider(color: theme.dividerColor),
      itemBuilder: (context, index) {
        final item = items[index];
        // Nonaktifkan tombol +/- pada item ini SAJA saat sedang diproses,
        // item lain tetap bisa diinteraksi normal.
        // final isProcessing = state.processingProductId == item.product.id;
    
        return _CartItemTile(item: item, isProcessing: false);
      },
    );
  }
}

class _CartItemTile extends StatelessWidget {
  final CartItemEntity item;
  final bool isProcessing;

  const _CartItemTile({required this.item, required this.isProcessing});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: item.product.imageUrl != null
                ? Image.network(item.product.imageUrl!, width: 60, height: 60, fit: BoxFit.cover)
                : Container(
                    width: 60,
                    height: 60,
                    color: theme.colorScheme.surfaceContainerHighest,
                    alignment: Alignment.center,
                    child: Icon(Icons.inventory_2_outlined,
                        size: 28, color: theme.colorScheme.outline),
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  item.product.priceFormatted,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _QtyButton(
                      icon: Icons.remove,
                      // Nonaktifkan saat processing agar tidak double-dispatch
                      // event sebelum request sebelumnya selesai diproses BLoC.
                      onPress: isProcessing
                        ? null
                        : () => context.read<CartBloc>().add(
                          UpdateCartItemQuantity(
                            productId: item.product.id,
                            newQuantity: item.quantity - 1,
                          ),
                        ),
                    ),
                    SizedBox(
                      width: 36,
                      child: Center(
                        child: isProcessing
                            ? const SizedBox(
                                width: 12,
                                height: 12,
                                child: CircularProgressIndicator(strokeWidth: 1.5),
                              )
                            : Text(
                                '${item.quantity}',
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                      ),
                    ),
                    _QtyButton(
                      icon: Icons.add,
                      onPress: isProcessing
                          ? null
                          : () => context.read<CartBloc>().add(
                                UpdateCartItemQuantity(
                                  productId: item.product.id,
                                  newQuantity: item.quantity + 1,
                                ),
                              ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatRupiah(item.subtotal),
                style: theme.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.primary),
              ),
              const SizedBox(height: 8),
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 18),
                onPressed: isProcessing
                    ? null
                    : () => context
                        .read<CartBloc>()
                        .add(RemoveProductFromCart(productId: item.product.id)),
                iconSize: 20,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                color: theme.colorScheme.error,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPress;

  const _QtyButton({required this.icon, required this.onPress});

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPress == null;
    return InkWell(
      onTap: onPress,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(isDisabled ? 0.3 : 1),
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          size: 14,
          color: Theme.of(context)
              .colorScheme
              .onSurfaceVariant
              .withOpacity(isDisabled ? 0.3 : 1),
        ),
      ),
    );
  }
}

String _formatRupiah(int value) {
  return 'Rp${value.toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]}.',
      )}';
}
