import 'package:dio/dio.dart';
import 'package:login_biometrics_app/core/errors/exceptions.dart';
import 'package:login_biometrics_app/core/network/dio_client.dart';

abstract class ApiClient {
  Future<T> post<T>(
    String endpoint, {
      Object? data,
      Map<String, dynamic>? queryParams,
      Options? options,
      required T Function(dynamic responseData) fromJson
    }
  );
  Future<T> get<T>(
    String endpoint, {
      Map<String, dynamic>? queryParams,
      Options? options,
      required T Function(dynamic responseData) fromJson
    }
  );
}

class ApiClientImpl implements ApiClient {
  final DioClient _dc;

  ApiClientImpl(this._dc);
  
  @override
  Future<T> get<T>(String endpoint, {Map<String, dynamic>? queryParams, Options? options, required T Function(dynamic responseData) fromJson}) async {
    try {
      final response = await _dc.dio.post(
        endpoint,
        queryParameters: queryParams,
        options: options
      );
      final responseData = response.data['data'] ?? response.data;

      return fromJson(responseData);
    } on DioException catch(e) {
      _throwException(e);
      throw const ServerException(message: "");
    } catch(e) {
      throw ServerException(message: 'Terjadi kesalaahan: $e');
    }
  }
  
  @override
  Future<T> post<T>(String endpoint, {Object? data, Map<String, dynamic>? queryParams, Options? options, required T Function(dynamic responseData) fromJson}) async {
    try {
      final response = await _dc.dio.post(
        endpoint,
        data: data,
        queryParameters: queryParams,
        options: options
      );
      final responseData = response.data['data'] ?? response.data;

      return fromJson(responseData);
    } on DioException catch(e) {
      _throwException(e);
      throw const ServerException(message: "");
    } catch(e) {
      throw ServerException(message: 'Terjadi kesalaahan: $e');
    }
  }

  void _throwException(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout || 
        error.type == DioExceptionType.receiveTimeout) {
      throw NetworkException('Koneksi terputus. Periksa internet Anda.');
    } else if (error.type == DioExceptionType.badResponse) {
      // Ambil pesan dari API Laravel Anda (jika formatnya JSON { message: "..." })
      throw ServerException(message: error.response?.data['message'] ?? 'Response tidak valid dari server');
    } else if (error.type == DioExceptionType.connectionError) {
      throw NetworkException('Tidak ada koneksi internet.');
    }

    // Kembalikan ServerException agar ditangkap seragam oleh Repository
    throw ServerException(message: 'Terjadi kesalahan sistem.');
  }
}