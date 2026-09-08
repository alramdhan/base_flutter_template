import 'package:login_biometrics_app/core/constants/api_constants.dart';
import 'package:login_biometrics_app/core/network/api_client.dart';
import 'package:login_biometrics_app/features/products/data/models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final ApiClient apiClient;

  CategoryRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<CategoryModel>> getCategories() async {
    // try {
      // Response CategoryController@index Laravel: { success, data: [...] }
      return apiClient.get<List<CategoryModel>>(
        ApiConstants.endpoints.categories,
        fromJson: (response) => List<CategoryModel>.from(response.map((x) => CategoryModel.fromJson(x)))
      );

    //   if (response.statusCode == 200) {
    //     final List<dynamic> data = response.data['data'] as List<dynamic>;
    //     return data
    //         .map((item) => CategoryModel.fromJson(item as Map<String, dynamic>))
    //         .toList();
    //   }

    //   throw ServerException(
    //     response.data?['message'] ?? 'Gagal mengambil daftar kategori.',
    //   );
    // } on DioException catch (e) {
    //   if (e.type == DioExceptionType.connectionTimeout ||
    //       e.type == DioExceptionType.receiveTimeout ||
    //       e.type == DioExceptionType.connectionError) {
    //     throw const NetworkException();
    //   }
    //   throw ServerException(
    //     e.response?.data?['message'] ?? 'Terjadi kesalahan saat mengambil kategori.',
    //   );
    // }
  }
}