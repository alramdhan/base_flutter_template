import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:login_biometrics_app/core/helpers/secure_storage_helper.dart';
import 'package:login_biometrics_app/core/network/auth_interceptor.dart';
import 'package:login_biometrics_app/core/network/dio_client.dart';
import 'package:login_biometrics_app/core/network/network_info.dart';
import 'package:login_biometrics_app/core/network/network_info_impl.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // local storage service
  sl.registerLazySingleton<FlutterSecureStorage>(() {
    const aOptions = AndroidOptions();
    const iosOptions = IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device);
    return const FlutterSecureStorage(
      aOptions: aOptions,
      iOptions: iosOptions
    );
  });
  sl.registerLazySingleton<SecureStorageHelper>(() => SecureStorageHelperImpl(sl()));

  // network service
  sl.registerLazySingleton(() => InternetConnection());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => AuthInterceptor(secureStorage: sl()));
  sl.registerLazySingleton<DioClient>(() => DioClientImpl(sl()));
  // sl.registerLazySingleton<Dio>(() {
  //   final baseOptions = BaseOptions(
  //     baseUrl: ApiConstants.baseUrl,
  //     connectTimeout: const Duration(milliseconds: ApiConstants.connectTimeout),
  //     receiveTimeout: const Duration(milliseconds: ApiConstants.receiveTimeout),
  //     contentType: 'application/json',
  //     responseType: ResponseType.json
  //   );
  //   final dio = Dio(baseOptions);

  //   dio.interceptors.add(AuthInterceptor(secureStorage: sl()));
  //   dio.interceptors.add(
  //     LogInterceptor(
  //       request: ApiConstants.isDev,
  //       requestHeader: ApiConstants.isDev,
  //       requestBody: ApiConstants.isDev,
  //       responseHeader: ApiConstants.isDev,
  //       responseBody: ApiConstants.isDev,
  //       error: ApiConstants.isDev
  //     )
  //   );

  //   return dio;
  // });
}