part of 'biometric_bloc.dart';

sealed class BiometricEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterBiometricEvent extends BiometricEvent {
  final String deviceId;
  final String deviceModel;
  final String pin;

  RegisterBiometricEvent(
    this.deviceId,
    this.deviceModel,
    this.pin
  );

  @override
  List<Object?> get props => [deviceId, deviceModel, pin];
}