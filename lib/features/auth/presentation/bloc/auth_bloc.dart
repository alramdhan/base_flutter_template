import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_biometrics_app/features/auth/data/models/requests/login_request.dart';
import 'package:login_biometrics_app/features/auth/domain/entities/user.dart';
import 'package:login_biometrics_app/features/auth/domain/usecases/login_usecase.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;

  AuthBloc({required this.loginUsecase}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit
  ) async {
    emit(AuthLoading());

    final result = await loginUsecase(
      LoginRequest(
        login: event.login,
        password: event.password
      )
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
}