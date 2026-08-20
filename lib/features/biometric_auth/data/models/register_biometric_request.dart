class RegisterBiometricRequest {
  final String deviceId;
  final String deviceModel;
  final String publicKey;
  final String pin;

  RegisterBiometricRequest({
    required this.deviceId,
    required this.deviceModel,
    required this.publicKey,
    required this.pin
  });

  Map<String, dynamic> toJson() => {
    'device_id': deviceId,
    'device_model': deviceModel,
    'public_key': publicKey,
    'user_pin': pin
  };
}