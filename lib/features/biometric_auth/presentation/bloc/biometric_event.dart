part of 'biometric_bloc.dart';

sealed class BiometricEvent extends Equatable {
  const BiometricEvent();
  @override
  List<Object?> get props => [];
}

class VerifyBiometricEvent extends BiometricEvent {}

class RegisterBiometricEvent extends BiometricEvent {
  final String deviceId;
  final String deviceModel;
  final String pin;

  const RegisterBiometricEvent(
    this.deviceId,
    this.deviceModel,
    this.pin
  );

  @override
  List<Object?> get props => [deviceId, deviceModel, pin];
}

final class BiometricStatusEvent extends BiometricEvent {}