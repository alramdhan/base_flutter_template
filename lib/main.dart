import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_biometrics_app/core/router/app_router.dart';
import 'package:login_biometrics_app/core/utils/app_themes.dart';
import 'package:login_biometrics_app/features/auth/presentation/bloc/app_auth/app_auth_bloc.dart';
import 'package:login_biometrics_app/service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppAuthBloc>(
          create: (_) => di.sl<AppAuthBloc>()..add(AppAuthCheckRequested()),
        ),
      ],
      child: Builder(
        builder: (context) {
          final appRouter = di.sl<AppRouter>().router;

          return MaterialApp.router(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: kDebugMode,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: .system,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
