import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_biometrics_app/features/home/presentation/home_page.dart';
import 'package:login_biometrics_app/features/main_navigation/cubit/navigation_cubit.dart';
import 'package:login_biometrics_app/features/setting/presentation/pages/setting_page.dart';

class MainNavPage extends StatelessWidget {
  const MainNavPage({super.key});

  final List<Widget> _pages = const [
    MyHomePage(title: "Home Page"),
    SettingPage()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.currentIndex,
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.currentIndex,
            onTap: context.read<NavigationCubit>().updateIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Beranda'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Pengaturan'
              )
            ],
          ),
        );
      },
    );
  }
}