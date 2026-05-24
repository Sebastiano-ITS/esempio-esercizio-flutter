import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart/cart_cubit.dart';
import '../data/models/product_model.dart';
import '../data/repositories/product_repository.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<ProductRepository>(context);

    return FutureBuilder<ProductModel>(
      future: repository.fetchProductById(productId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: const Text('Dettaglio prodotto')),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Impossibile caricare il prodotto.'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => (context as Element).markNeedsBuild(),
                    child: const Text('Riprova'),
                  ),
                ],
              ),
            ),
          );
        }

        final product = snapshot.data!;
        return Scaffold(
          appBar: AppBar(title: const Text('Dettaglio prodotto')),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 260,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 96),
                  ),
                ),
                const SizedBox(height: 16),
                Text(product.title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(product.category, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 16),
                Text(product.description, style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 24),
                Text('€ ${product.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<CartCubit>().addProduct(product);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Prodotto aggiunto al carrello')));
                  },
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('Aggiungi al carrello'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
