import 'package:bloc/bloc.dart';
import '../../data/models/product_model.dart';

class CartState {
  final List<ProductModel> items;

  CartState({this.items = const []});

  CartState copyWith({List<ProductModel>? items}) {
    return CartState(items: items ?? this.items);
  }
}

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState());

  void addProduct(ProductModel product) {
    emit(state.copyWith(items: List<ProductModel>.from(state.items)..add(product)));
  }

  void removeProduct(ProductModel product) {
    emit(state.copyWith(items: List<ProductModel>.from(state.items)..remove(product)));
  }

  void clear() {
    emit(CartState(items: []));
  }
}
