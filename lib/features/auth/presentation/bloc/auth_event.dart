part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class LoginRequested extends AuthEvent {
  final String login;
  final String password;
  final bool isRememberMe;

  const LoginRequested({
    required this.login,
    required this.password,
    required this.isRememberMe
  });

  @override
  List<Object?> get props => [login, password, isRememberMe];
}

final class LogoutRequested extends AuthEvent {}