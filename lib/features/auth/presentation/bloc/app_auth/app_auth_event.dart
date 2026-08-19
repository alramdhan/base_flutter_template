part of 'app_auth_bloc.dart';

sealed class AppAuthEvent extends Equatable {
  const AppAuthEvent();

  @override
  List<Object?> get props => [];
}

final class AppAuthCheckRequested extends AppAuthEvent {}
final class AppAuthLoggedIn extends AppAuthEvent {}
final class AppAuthLogoutRequested extends AppAuthEvent {}