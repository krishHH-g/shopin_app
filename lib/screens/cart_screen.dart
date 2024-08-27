import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_prod/states/provider_cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: cartProvider.cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.cartItems.length,
                    padding: const EdgeInsets.all(15),
                    itemBuilder: (context, index) {
                      final product = cartProvider.cartItems[index];
                      return Card(
                        child: ListTile(
                          leading: Image.network(product.images[0]),
                          title: Text(product.title),
                          subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                          trailing: IconButton(
                            icon:const  Icon(Icons.remove_shopping_cart,color: Colors.red,),
                            onPressed: () {
                              cartProvider.removeProduct(product);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}', style:const TextStyle(fontSize: 23)),
                ),
              ],
            ),
    );
  }
}
