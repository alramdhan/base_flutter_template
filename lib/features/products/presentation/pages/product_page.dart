import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_biometrics_app/core/components/minimalist_textfield.dart';
import 'package:login_biometrics_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:login_biometrics_app/features/products/presentation/pages/product_list_page.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Produk"),
        bottom: PreferredSize(
          preferredSize: const .fromHeight(56),
          child: Padding(
            padding: const .fromLTRB(16, 0, 16, 12),
            child: _SearchField(
              onChanged: (keyword) => {
                context.read<ProductBloc>().add(SearchProducts(keyword))
              },
            ),
          ),
        ),
      ),
      body: const SafeArea(
        child: Column(
          children: [
            Expanded(child: ProductListPage()),
          ],
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