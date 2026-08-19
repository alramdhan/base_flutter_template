import 'package:go_router/go_router.dart';
import 'package:login_biometrics_app/core/router/grouter_refresh_stream.dart';
import 'package:login_biometrics_app/features/auth/presentation/bloc/app_auth/app_auth_bloc.dart';
import 'package:login_biometrics_app/features/auth/presentation/pages/login_page.dart';
import 'package:login_biometrics_app/features/home/presentation/home_page.dart';

class AppRouter {
  final AppAuthBloc appAuthBloc;

  AppRouter(this.appAuthBloc);

  late final GoRouter router = GoRouter(
    initialLocation: "/login",
    refreshListenable: GrouterRefreshStream(appAuthBloc.stream),
    redirect: (context, state) {
      final authState = appAuthBloc.state.status;
      final isGoingToLogin = state.matchedLocation == '/login';

      if(authState == AuthStatus.unknown) return null;

      if(authState == AuthStatus.unauthenticated && !isGoingToLogin) {
        return '/login';
      }

      if(authState == AuthStatus.authenticted && isGoingToLogin) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage()
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const MyHomePage(title: "Home")
      ),
    ]
  );
}