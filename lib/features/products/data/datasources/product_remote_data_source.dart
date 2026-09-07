import 'package:login_biometrics_app/core/constants/api_constants.dart';
import 'package:login_biometrics_app/core/network/api_client.dart';
import 'package:login_biometrics_app/features/products/data/models/product_list_response_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductListResponseModel> getProducts({
    required int page,
    required int perPage,
    String? search,
    int? categoryId,
    bool lowStockOnly = false,
  });
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient apiClient;

  ProductRemoteDataSourceImpl(this.apiClient);

  @override
  Future<ProductListResponseModel> getProducts({
    required int page,
    required int perPage,
    String? search,
    int? categoryId,
    bool lowStockOnly = false,
  }) async {
    return apiClient.get<ProductListResponseModel>(
      ApiConstants.endpoints.products,
      queryParams: {
        'page': page,
        'per_page': perPage,
        if (search != null && search.isNotEmpty) 'search': search,
        'category_id': ?categoryId,
        if (lowStockOnly) 'low_stock': 1,
      },
      fromJson: (responseData) => ProductListResponseModel.fromJson(
        responseData as Map<String, dynamic>,
      ),
    );
  }
}