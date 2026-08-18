import 'package:dio/dio.dart';
import 'package:login_biometrics_app/core/network/api_client.dart';
import 'package:login_biometrics_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:login_biometrics_app/features/auth/data/models/user_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> login(String login, String password) async {
    try {
      final response = await client.post(
        '/login', // Ganti dengan Base URL API Anda
        data: {
          'login': login,
          'password': password,
        },
        fromJson: (responseData) => UserModel.fromJson(responseData),
      );

      if (response.isRight()) {
        return response.fold(
          (failure) => ,
          (response) =>
        );
      }

      // if (response.statusCode == 200) {
      //   final data = response.data['data'];
      //   return UserModel.fromJson(data['user'], data['access_token']);
      // } else {
      //   throw ServerException(response.data['message'] ?? 'Terjadi kesalahan');
      // }
    } on DioException catch(e) {

    } catch(e) {

    }
  }
  
}