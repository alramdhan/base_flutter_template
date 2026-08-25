import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_biometrics_app/features/biometric_auth/domain/usecases/register_biometric_usecase.dart';

part 'biometric_event.dart';
part 'biometric_state.dart';

class BiometricBloc extends Bloc<BiometricEvent, BiometricState> {
  final RegisterBiometricUsecase registerBiometricUseCase;

  BiometricBloc({required this.registerBiometricUseCase}) : super(BiometricInitial()) {
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