part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class LoginRequested extends AuthEvent {
  final String login;
  final String password;

  const LoginRequested({
    required this.login,
    required this.password
  });

  @override
  List<Object?> get props => [login, password];
}