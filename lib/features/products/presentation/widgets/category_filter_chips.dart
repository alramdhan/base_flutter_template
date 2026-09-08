import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_biometrics_app/features/products/presentation/bloc/category_cubit.dart';
import 'package:login_biometrics_app/features/products/presentation/bloc/category_state.dart';

/// Baris chip kategori horizontal, scroll ke samping. Tap chip akan:
/// 1. Update kategori aktif di CategoryCubit (untuk state visual chip terpilih)
/// 2. Trigger ProductBloc untuk fetch ulang produk dengan filter kategori baru
class CategoryFilterChips extends StatelessWidget {
  const CategoryFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading || state is CategoryInitial) {
          return const SizedBox(
            height: 40,
            child: Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }

        if (state is CategoryError) {
          return const SizedBox.shrink();
        }

        final loaded = state as CategoryLoaded;

        return SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: .horizontal,
            padding: const .symmetric(horizontal: 16),
            itemCount: loaded.categories.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final isAllChip = index == 0;
              final categoryId = isAllChip ? null : loaded.categories[index - 1].id;
              final label = isAllChip ? 'Semua' : loaded.categories[index - 1].name;
              final isSelected = loaded.selectedCategoryId == categoryId;

              return ChoiceChip(
                label: Text(label),
                selected: isSelected,
                onSelected: (_) {
                  context.read<CategoryCubit>().selectCategory(categoryId);
                  // context
                  //   .read<ProductBloc>()
                  //   .add(FilterProductsByCategory(categoryId));
                },
              );
            },
          ),
        );
      },
    );
  }
}