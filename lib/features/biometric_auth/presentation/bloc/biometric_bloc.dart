import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_biometrics_app/core/services/secure_storage_service.dart';
import 'package:login_biometrics_app/features/biometric_auth/domain/usecases/register_biometric_usecase.dart';
import 'package:login_biometrics_app/service_locator.dart';

part 'biometric_event.dart';
part 'biometric_state.dart';

class BiometricBloc extends Bloc<BiometricEvent, BiometricState> {
  final RegisterBiometricUsecase registerBiometricUseCase;

  BiometricBloc({required this.registerBiometricUseCase}) : super(BiometricInitial()) {
    on<BiometricStatusEvent>((event, emit) async {
      try {
        final isEnabled = await sl<SecureStorageService>().getBiometricState();

        emit(BiometricStatusLoaded(isEnabled));
      } catch (e) {
        emit(BiometricStatusLoaded(false));
      }
    });
    on<RegisterBiometricEvent>(_onRegisBiometric);
    on<VerifyBiometricEvent>(_onVerifyBiometric);
  }

  void _onRegisBiometric(
    RegisterBiometricEvent event,
    Emitter<BiometricState> emit
  ) async {
    emit(BiometricLoading());
    final result = await registerBiometricUseCase(event.deviceId, event.deviceModel, event.pin);

    result.fold(
      (failure) => emit(BiometricError(failure.message)),
      (result) => emit(BiometricSuccess("Berhasil biometrik!"))
    );
  }

  void _onVerifyBiometric(
    VerifyBiometricEvent event,
    Emitter<BiometricState> emit
  ) {
    emit(BiometricLoading());

    
  }
}