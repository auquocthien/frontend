import 'package:flutter/material.dart';
import 'package:frontend/services/product.service.dart';

import '../../models/product.dart';

class ProductManager with ChangeNotifier {
  List<Product>? products;

  final ProductService _productService;
  ProductManager() : _productService = ProductService();

  int get productLength {
    return products!.length;
  }

  Future<List<Product>?> getProducts() async {
    try {
      products = await _productService.getProduct();
      if (products!.isNotEmpty) {
        return products;
      }
    } catch (e) {
      print(e);
    }

    notifyListeners();
    return null;
  }

  Future<List<Product>> getProductByName(String productName) async {
    List<Product> result = [];

    try {
      products!.forEach((product) {
        if (product.productName
            .toLowerCase()
            .contains(productName.toLowerCase())) {
          result.add(product);
        }
      });
    } catch (e) {
      print(e);
    }
    return result;
  }

  Future getProductBestSell() async {
    List<Map<String, dynamic>> result = [];
    try {
      result = await _productService.getProductBestSell();
    } catch (e) {
      print('error while get product best sell $e');
    }

    return result;
  }
}
