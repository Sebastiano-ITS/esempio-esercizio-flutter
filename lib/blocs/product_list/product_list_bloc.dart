import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ProductRepository repository;

  ProductListBloc(this.repository) : super(const ProductListState()) {
    on<ProductListRequested>(_onRequested);
  }

  Future<void> _onRequested(
    ProductListRequested event,
    Emitter<ProductListState> emit,
  ) async {
    emit(state.copyWith(status: ProductListStatus.loading));
    try {
      final products = await repository.fetchProducts();
      emit(state.copyWith(status: ProductListStatus.success, products: products));
    } catch (error) {
      emit(state.copyWith(
        status: ProductListStatus.failure,
        errorMessage: 'Impossibile caricare i prodotti. Riprova.',
      ));
    }
  }
}
