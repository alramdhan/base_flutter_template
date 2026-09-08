

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_biometrics_app/core/components/minimalist_textfield.dart';
import 'package:login_biometrics_app/features/products/presentation/bloc/category_cubit.dart';
import 'package:login_biometrics_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:login_biometrics_app/features/products/presentation/pages/product_list_page.dart';
import 'package:login_biometrics_app/features/products/presentation/widgets/category_filter_chips.dart';
import 'package:login_biometrics_app/service_locator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<ProductBloc>()..add(const FetchProducts()),
        ),
        BlocProvider(
          create: (_) => sl<CategoryCubit>()..fetchCategories(),
        )
      ],
      child: const _HomePageView(),
    );
  }
}

class _HomePageView extends StatelessWidget {
  const _HomePageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Beranda"),
        bottom: PreferredSize(
          preferredSize: const .fromHeight(56),
          child: Column(
            children: [
              Padding(
                padding: const .fromLTRB(16, 0, 16, 12),
                child: _SearchField(
                  onChanged: (keyword) => {
                    context.read<ProductBloc>().add(SearchProducts(keyword))
                  },
                ),
              ),
              const CategoryFilterChips()
            ],
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