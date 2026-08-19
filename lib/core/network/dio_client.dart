import 'package:dio/dio.dart';
import 'package:login_biometrics_app/core/constants/api_constants.dart';
import 'package:login_biometrics_app/core/network/interceptors/auth_interceptor.dart';

class DioClient {
  final Dio _dio;
  final AuthInterceptor authInterceptor;
  final LogInterceptor logInterceptor;

  DioClient(this._dio, {required this.authInterceptor, required this.logInterceptor}) {
    _dio.options
      ..baseUrl = ApiConstants.baseUrl
      ..connectTimeout = const Duration(milliseconds: ApiConstants.connectTimeout)
      ..receiveTimeout = const Duration(milliseconds: ApiConstants.receiveTimeout)
      ..contentType = 'application/json'
      ..responseType = ResponseType.json;
      

    _dio.interceptors.add(authInterceptor);
    _dio.interceptors.add(logInterceptor);
  }

  Dio get dio => _dio;
}