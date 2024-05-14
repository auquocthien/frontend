import 'package:flutter/material.dart';
import 'package:frontend/ui/cart/cart_list.dart';
import 'package:frontend/ui/product/product_grid.dart';
import 'package:frontend/ui/shared/app_drawer.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/product-cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Product Cart',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 83, 86, 255),
      ),
      drawer: const AppDrawer(),
      body: const CartList(),
    );
  }
}
