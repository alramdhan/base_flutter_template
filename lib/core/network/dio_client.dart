import 'package:dio/dio.dart';
import 'package:login_biometrics_app/core/constants/api_constants.dart';
import 'package:login_biometrics_app/core/network/auth_interceptor.dart';

class DioClient {
  late Dio dio;
  final AuthInterceptor authInterceptor;
  final LogInterceptor logInterceptor;

  DioClient({required this.authInterceptor, required this.logInterceptor}) {
    final baseOptions = BaseOptions(
      baseUrl: "${ApiConstants.baseUrl}/api/v1",
      connectTimeout: const Duration(milliseconds: ApiConstants.connectTimeout),
      receiveTimeout: const Duration(milliseconds: ApiConstants.receiveTimeout),
      contentType: 'application/json',
      responseType: ResponseType.json
    );
    final dio = Dio(baseOptions);

    dio.interceptors.add(authInterceptor);
    dio.interceptors.add(logInterceptor
      // LogInterceptor(
      //   request: ApiConstants.isDev,
      //   requestHeader: ApiConstants.isDev,
      //   requestBody: ApiConstants.isDev,
      //   responseHeader: ApiConstants.isDev,
      //   responseBody: ApiConstants.isDev,
      //   error: ApiConstants.isDev
      // )
    );
  }
}