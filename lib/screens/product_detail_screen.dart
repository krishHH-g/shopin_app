import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_prod/models/model_product.dart';
import 'package:shopping_prod/screens/cart_screen.dart';
import 'package:shopping_prod/states/provider_cart.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: AppBar(title: Text(product.title)),
      // FAB
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CartScreen(),
            ),
          );
        },
        child: const Icon(Icons.trolley),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: product.images[0],
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(height: 16.0),
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text('₹${product.price.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 20, color: Colors.green)),
            const SizedBox(height: 16.0),
            Text(product.description),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<CartProvider>(context, listen: false)
                      .addProduct(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to Cart')));
                },
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
