import 'package:dio/dio.dart';

class SecurityInterceptor extends Interceptor {
  final String apiSecretKey;

  SecurityInterceptor({required this.apiSecretKey});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
  }
}