import 'package:flutter/material.dart';
import 'package:shopping_prod/apis/api_service.dart';
import 'package:shopping_prod/models/model_product.dart';
import 'package:shopping_prod/screens/cart_screen.dart';
import 'package:shopping_prod/screens/product_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<ProductList> _productList;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    _productList = ApiService().fetchProducts();
  }

  Future<void> _refreshProducts() async {
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
              onPressed: (() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ),
                );
              }),
              icon: const Icon(Icons.trolley))
        ],
      ),
      body: FutureBuilder<ProductList>(
        future: _productList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.blueGrey,
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.products.isEmpty) {
            return const Center(child: Text('No products available'));
          }

          return RefreshIndicator(
            onRefresh: _refreshProducts,
            child: GridView.builder(
              itemCount: snapshot.data!.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 0.7,
                crossAxisCount: 2,
              ),
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final product = snapshot.data!.products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(product: product),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          imageUrl: product.images[0],
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          product.title,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Text('₹${product.price.toStringAsFixed(2)}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
