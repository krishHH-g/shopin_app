import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping_prod/models/model_product.dart';

class ApiService {
  
Future<ProductList> fetchProducts() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/products?limit=10&skip=10&select=title,price,description,images'));

  if (response.statusCode == 200) {
    return ProductList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load products');
  }
}
}

