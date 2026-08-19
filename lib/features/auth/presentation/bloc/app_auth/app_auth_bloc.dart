import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_biometrics_app/features/auth/data/datasources/auth_local_data_source.dart';

part 'app_auth_state.dart';
part 'app_auth_event.dart';

class AppAuthBloc extends Bloc<AppAuthEvent, AppAuthState> {
  final AuthLocalDataSource localDatasource;
  AppAuthBloc({required this.localDatasource}) : super(const AppAuthState.unknown()) {
    on<AppAuthCheckRequested>(_onAuthCheckRequested);
    on<AppAuthLoggedIn>(_onLoggedIn);
    on<AppAuthLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onAuthCheckRequested(
    AppAuthCheckRequested event,
    Emitter<AppAuthState> emit
  ) async {
    final token = await localDatasource.getToken();

    if(token != null && token.isNotEmpty) {
      emit(const AppAuthState.authenticated());
    } else {
      emit(const AppAuthState.unauthenticated());
    }
  }

  void _onLoggedIn(
    AppAuthLoggedIn event,
    Emitter<AppAuthState> emit
  ) {
    emit(const AppAuthState.authenticated());
  }

  Future<void> _onLogoutRequested(
    AppAuthLogoutRequested event,
    Emitter<AppAuthState> emit
  ) async {
    await localDatasource.deleteToken();
    emit(const AppAuthState.unauthenticated());
  }
}