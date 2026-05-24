import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';
import 'product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ProductModel>> fetchProducts() {
    return remoteDataSource.fetchProducts();
  }

  @override
  Future<ProductModel> fetchProductById(int id) {
    return remoteDataSource.fetchProductById(id);
  }
}
