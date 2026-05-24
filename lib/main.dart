import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'blocs/cart/cart_cubit.dart';
import 'blocs/product_list/product_list_bloc.dart';
import 'config/dio_config.dart';
import 'data/datasources/product_remote_data_source.dart';
import 'data/repositories/product_repository_impl.dart';
import 'data/repositories/product_repository.dart';
import 'screens/cart_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/product_list_screen.dart';

void main() {
  final dio = DioConfig.create();
  final repository = ProductRepositoryImpl(ProductRemoteDataSource(dio));

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final ProductRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const ProductListScreen(),
        ),
        GoRoute(
          path: '/products/:id',
          builder: (context, state) {
            final productId = int.tryParse(state.params['id'] ?? '') ?? 0;
            return ProductDetailScreen(productId: productId);
          },
        ),
        GoRoute(
          path: '/cart',
          builder: (context, state) => const CartScreen(),
        ),
      ],
    );

    return RepositoryProvider<ProductRepository>.value(
      value: repository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ProductListBloc>(
            create: (_) => ProductListBloc(repository),
          ),
          BlocProvider<CartCubit>(
            create: (_) => CartCubit(),
          ),
        ],
        child: MaterialApp.router(
          title: 'Shop Online',
          theme: ThemeData(primarySwatch: Colors.blue),
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          routeInformationProvider: router.routeInformationProvider,
        ),
      ),
    );
  }
}
