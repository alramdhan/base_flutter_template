import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_biometrics_app/features/biometric_auth/domain/repositories/biometric_auth_repository.dart';

part 'biometric_event.dart';
part 'biometric_state.dart';

class BiometricBloc extends Bloc<BiometricEvent, BiometricState> {
  final BiometricAuthRepository repository;

  BiometricBloc({required this.repository}) : super(BiometricInitial()) {
    on<RegisterBiometricEvent>(_onRegisBiometric);
  }

  void _onRegisBiometric(
    RegisterBiometricEvent event,
    Emitter<BiometricState> emit
  ) async {
    emit(BiometricLoading());
    try {
      await repository.registerBiometric(event.deviceId, event.deviceModel, event.pin);
      emit(BiometricSuccess("Berhasil biometrik!"));
    } catch(e) {
      emit(BiometricError(e.toString()));
    }
  }
}