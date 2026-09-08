import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_biometrics_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:login_biometrics_app/features/kasir/presentation/pages/kasir_page.dart';
import 'package:login_biometrics_app/features/main_navigation/cubit/navigation_cubit.dart';
import 'package:login_biometrics_app/features/products/presentation/bloc/category_cubit.dart';
import 'package:login_biometrics_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:login_biometrics_app/features/products/presentation/pages/product_page.dart';
import 'package:login_biometrics_app/features/setting/presentation/pages/setting_page.dart';
import 'package:login_biometrics_app/service_locator.dart';

class MainNavPage extends StatelessWidget {
  const MainNavPage({super.key});

  final List<Widget> _pages = const [
    KasirPage(),
    ProductPage(),
    SettingPage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<ProductBloc>()..add(const FetchProducts()),
        ),
        BlocProvider(
          create: (_) => sl<CategoryCubit>()..fetchCategories(),
        ),
        BlocProvider(
          create: (_) => sl<CartBloc>()..add(const LoadCart()),
        )
      ],
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state.currentIndex,
              children: _pages,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.currentIndex,
              type: .fixed,
              onTap: context.read<NavigationCubit>().updateIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.cashRegister),
                  tooltip: 'Kasir',
                  label: 'Kasir'
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.boxesStacked),
                  tooltip: 'Produk',
                  label: 'Produk'
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.clockRotateLeft),
                  tooltip: 'Transaksi',
                  label: 'Transaksi'
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.chartLine),
                  tooltip: 'Laporan',
                  label: 'Laporan'
                )
              ],
            ),
          );
        },
      ),
    );
  }
}