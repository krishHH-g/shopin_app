import 'package:flutter/material.dart';
import 'package:shopping_prod/models/model_product.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void addProduct(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  double get totalPrice {
    return _cartItems.fold(0.0, (total, product) => total + product.price);
  }
}
