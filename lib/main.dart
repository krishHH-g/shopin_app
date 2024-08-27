import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_prod/screens/product_list_screen.dart';
import 'package:shopping_prod/states/provider_cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'Product App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        home: const ProductListScreen(),
       
      ),
    );
  }
}

