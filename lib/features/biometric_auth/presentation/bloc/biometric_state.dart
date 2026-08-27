part of 'biometric_bloc.dart';

sealed class BiometricState extends Equatable {
  const BiometricState();

  @override
  List<Object?> get props => [];
}
class BiometricInitial extends BiometricState {}
class BiometricLoading extends BiometricState {}
class BiometricSuccess extends BiometricState {
  final String message;
  const BiometricSuccess(this.message);
}
class BiometricError extends BiometricState {
  final String error;
  const BiometricError(this.error);
}
class BiometricStatusLoaded extends BiometricState {
  final bool isBiometricEnabled;

  const BiometricStatusLoaded(this.isBiometricEnabled);

  @override
  List<Object?> get props => [isBiometricEnabled];

}