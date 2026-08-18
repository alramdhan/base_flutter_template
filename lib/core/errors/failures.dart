import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

// gagal karena server bermasalah atau response API mengembalikan error.
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

// gagal karena tidak ada koneksi internet
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Tidak ada koneksi internet.']);
}

// gagal saat menyimpan, menghapus, atau membaca data dari local storage
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

// Kegagalan khusus biometrik, berguna untuk fitur login aplikasi Anda.
class BiometricFailure extends Failure {
  const BiometricFailure(super.message);
}