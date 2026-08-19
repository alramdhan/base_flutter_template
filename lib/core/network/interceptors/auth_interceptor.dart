import 'package:dio/dio.dart';
import 'package:login_biometrics_app/core/helpers/secure_storage_helper.dart';
import 'package:login_biometrics_app/features/auth/presentation/bloc/app_auth/app_auth_bloc.dart';
import 'package:login_biometrics_app/service_locator.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageHelper secureStorage;

  AuthInterceptor({required this.secureStorage});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await secureStorage.getAuthToken();

    if(token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if(err.response?.statusCode == 401) {
      // aksi jika Unauthorized
      // example: bisa melempar custom exception yang ditangkap oleh Bloc untuk logout UI
      sl<AppAuthBloc>().add(AppAuthLogoutRequested());
    }
    
    super.onError(err, handler);
  }
}