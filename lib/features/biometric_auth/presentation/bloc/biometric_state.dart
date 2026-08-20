part of 'biometric_bloc.dart';

sealed class BiometricState {}
class BiometricInitial extends BiometricState {}
class BiometricLoading extends BiometricState {}
class BiometricSuccess extends BiometricState {
  final String message;
  BiometricSuccess(this.message);
}
class BiometricError extends BiometricState {
  final String error;
  BiometricError(this.error);
}