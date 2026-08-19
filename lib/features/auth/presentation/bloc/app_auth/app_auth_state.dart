part of 'app_auth_bloc.dart';

enum AuthStatus {
  unknown,
  authenticted,
  unauthenticated
}

final class AppAuthState extends Equatable {
  final AuthStatus status;

  const AppAuthState._({this.status = AuthStatus.unknown});

  const AppAuthState.unknown() : this._();
  const AppAuthState.authenticated() : this._(status: AuthStatus.authenticted);
  const AppAuthState.unauthenticated() : this._(status: AuthStatus.unauthenticated);

  @override
  List<Object?> get props => [status];
}