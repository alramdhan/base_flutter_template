import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_biometrics_app/features/auth/domain/entities/user.dart';
import 'package:login_biometrics_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:login_biometrics_app/features/auth/domain/usecases/logout_usecase.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final LogoutUsecase logoutUsecase;

  AuthBloc({
    required this.loginUsecase,
    required this.logoutUsecase
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequest);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit
  ) async {
    emit(AuthLoading());

    final result = await loginUsecase(
      event.login,
      event.password,
      event.isRememberMe
    );

    result.fold(
      (failure) {
        emit(AuthFailure(failure.message));
      },
      (user) {
        emit(AuthSuccess(user: user));
      }
    );
  }

  Future<void> _onLogoutRequest(
    LogoutRequested event,
    Emitter<AuthState> emit
  ) async {
    emit(AuthLoading());
    final result = await logoutUsecase();

    result.fold(
      (failure)  {
        emit(AuthFailure(failure.message));
      },
      (success) {
        emit(Unauthenticated());
      }
    );
  }
}