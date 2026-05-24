import 'package:dio/dio.dart';

import '../models/product_model.dart';

class ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSource(this.dio);

  Future<List<ProductModel>> fetchProducts() async {
    final response = await dio.get('/products');
    if (response.statusCode == 200 && response.data is List) {
      return (response.data as List)
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      error: 'Failed to load products',
      type: DioExceptionType.badResponse,
    );
  }

  Future<ProductModel> fetchProductById(int id) async {
    final response = await dio.get('/products/$id');
    if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
      return ProductModel.fromJson(response.data as Map<String, dynamic>);
    }
    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      error: 'Failed to load product detail',
      type: DioExceptionType.badResponse,
    );
  }
}
