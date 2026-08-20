import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:login_biometrics_app/core/constants/api_constants.dart';
import 'package:login_biometrics_app/core/helpers/secure_storage_helper.dart';
import 'package:login_biometrics_app/core/network/interceptors/auth_interceptor.dart';
import 'package:login_biometrics_app/core/network/api_client.dart';
import 'package:login_biometrics_app/core/network/dio_client.dart';
import 'package:login_biometrics_app/core/network/network_info.dart';
import 'package:login_biometrics_app/core/network/network_info_impl.dart';
import 'package:login_biometrics_app/core/router/app_router.dart';
import 'package:login_biometrics_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:login_biometrics_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:login_biometrics_app/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:login_biometrics_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:login_biometrics_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:login_biometrics_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:login_biometrics_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:login_biometrics_app/features/auth/presentation/bloc/app_auth/app_auth_bloc.dart';
import 'package:login_biometrics_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:login_biometrics_app/features/biometric_auth/data/datasources/biometric_local_data_source.dart';
import 'package:login_biometrics_app/features/biometric_auth/data/datasources/biometric_remote_data_source.dart';
import 'package:login_biometrics_app/features/biometric_auth/data/respositories/biometric_auth_repository_impl.dart';
import 'package:login_biometrics_app/features/biometric_auth/domain/repositories/biometric_auth_repository.dart';
import 'package:login_biometrics_app/features/biometric_auth/domain/usecases/register_biometric_usecase.dart';
import 'package:login_biometrics_app/features/biometric_auth/presentation/bloc/biometric_bloc.dart';
import 'package:login_biometrics_app/features/main_navigation/cubit/navigation_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // =========================================================================
  // LOCAL STORAGE SERVICE
  // =========================================================================
  sl.registerLazySingleton<FlutterSecureStorage>(() {
    const aOptions = AndroidOptions();
    const iosOptions = IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device);
    return const FlutterSecureStorage(
      aOptions: aOptions,
      iOptions: iosOptions
    );
  });
  sl.registerLazySingleton<SecureStorageHelper>(() => SecureStorageHelperImpl(sl()));

  // =========================================================================
  // BLoC dan Cubit LAYER
  // =========================================================================
  sl.registerFactory(() => NavigationCubit());
  sl.registerLazySingleton(() => AppAuthBloc(localDatasource: sl()));
  sl.registerFactory(() => AuthBloc(
    loginUsecase: sl(),
    logoutUsecase: sl()
  ));
  sl.registerLazySingleton(() => BiometricBloc(repository: sl()));

  // =========================================================================
  // DOMAIN LAYER (use cases)
  // =========================================================================
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));
  sl.registerLazySingleton(() => RegisterBiometricUsecase(sl()));

  // =========================================================================
  // DATA LAYER
  // =========================================================================
  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
    remoteDataSource: sl(),
    localDatasource: sl()
  ));
  sl.registerLazySingleton<BiometricAuthRepository>(() => BiometricAuthRepositoryImpl(
    localDatasource: sl(),
    remoteDatasource: sl()
  ));
  // Data sources
  sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(secureStorage: sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(apiClient: sl()));
  sl.registerLazySingleton<BiometricLocalDataSource>(() => BiometricLocalDataSourceImpl(secureStorage: sl()));
  sl.registerLazySingleton<BiometricRemoteDataSource>(() => BiometricRemoteDataSourceImpl(sl()));

  // =========================================================================
  // CORE & EXTERNAL
  // =========================================================================
  // Router
  sl.registerLazySingleton(() => AppRouter(sl()));
  // Network
  sl.registerLazySingleton(() => InternetConnection());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => AuthInterceptor(secureStorage: sl()));
  sl.registerLazySingleton<DioClient>(() => DioClient(
    sl(),
    authInterceptor: sl(),
    logInterceptor: LogInterceptor(
      request: ApiConstants.isDev,
      requestHeader: ApiConstants.isDev,
      requestBody: ApiConstants.isDev,
      responseHeader: ApiConstants.isDev,
      responseBody: ApiConstants.isDev,
      error: ApiConstants.isDev
    )
  ));
  sl.registerLazySingleton<ApiClient>(() => ApiClientImpl(sl()));
  sl.registerLazySingleton(() => Dio());
}