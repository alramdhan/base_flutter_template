import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:login_biometrics_app/core/errors/failures.dart';

abstract class DioClient {
  Future<Either<Failure, T>> post<T>(
    String endpoint, {
      Object? data,
      Map<String, dynamic>? queryParams,
      Options? options,
      required T Function(dynamic responseData) fromJson
    }
  );
  Future<Either<Failure, T>> get<T>(
    String endpoint, {
      Map<String, dynamic>? queryParams,
      Options? options,
      required T Function(dynamic responseData) fromJson
    }
  );
}

class DioClientImpl implements DioClient {
  final Dio _dio;

  DioClientImpl(this._dio);
  
  @override
  Future<Either<Failure, T>> get<T>(String endpoint, {Map<String, dynamic>? queryParams, Options? options, required T Function(dynamic responseData) fromJson}) async {
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, T>> post<T>(String endpoint, {Object? data, Map<String, dynamic>? queryParams, Options? options, required T Function(dynamic responseData) fromJson}) async {
    try {
      final response = await _dio.post(endpoint,
        data: data,
        queryParameters: queryParams,
        options: options
      );
      final responseData = response.data['data'];

      return Right(fromJson(responseData));
    } on DioException catch(e) {
      return Left(_handleError(e));
    } catch(e) {
      return Left(ServerFailure('Terjadi kesalaahan: $e'));
    }
  }

  Failure _handleError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout || 
        error.type == DioExceptionType.receiveTimeout) {
      NetworkFailure('Koneksi terputus. Periksa internet Anda.');
    } else if (error.type == DioExceptionType.badResponse) {
      // Ambil pesan dari API Laravel Anda (jika formatnya JSON { message: "..." })
      ServerFailure(error.response?.data['message'] ?? 'Response tidak valid dari server');
    } else if (error.type == DioExceptionType.connectionError) {
      NetworkFailure('Tidak ada koneksi internet.');
    }

    // Kembalikan ServerException agar ditangkap seragam oleh Repository
    return ServerFailure('Terjadi kesalahan sistem.');
  }
}