import 'dart:convert';
import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:frontend/models/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  ProductService();

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  String baseUrl = '${dotenv.env['BASE_URL']}product';

  Future<List<Product>> getProduct() async {
    List<Product> products = [];
    try {
      final response = await http.get(Uri.parse(baseUrl));
      Map<String, dynamic> productData = await json.decode(response.body);

      productData['data'].forEach((product) {
        product as Map<String, dynamic>;
        products.add(Product.fromJson(product));
      });
    } catch (e) {
      throw Exception('cannot get product $e');
    }
    return products;
  }

  Future<void> updateProducFrice(payload) async {
    try {
      final body = json.encode(payload);

      await http.patch(Uri.parse('$baseUrl/update-price'), body: body);
    } catch (e) {
      print(e);
    }
  }

  Future<List<Map<String, dynamic>>> getProductBestSell() async {
    List<Map<String, dynamic>> result = [];
    DateTime now = DateTime.now();

    DateTime firstDay = now.subtract(Duration(days: now.weekday - 1));
    DateTime lastDay =
        now.add(Duration(days: DateTime.daysPerWeek - now.weekday));

    Map<String, String> query = {
      'startDate': DateFormat('yyyy-MM-dd').format(firstDay),
      'endDate': DateFormat('yyyy-MM-dd').format(lastDay),
    };
    try {
      Uri uri = Uri.parse('$baseUrl/best-sell').replace(queryParameters: query);
      final response = await http.get(uri);
      List<dynamic> resultData = json.decode(response.body)['data'];

      resultData.forEach((element) {
        result.add(element);
      });
      return result;
    } catch (e) {
      throw Exception('error while get best sell $e');
    }
  }

  Future<Product> getProductById(productId) async {
    Product product;

    try {
      Uri uri = Uri.parse('$baseUrl/detail/$productId');
      final response = await http.get(uri);

      product = Product.fromJson(json.decode(response.body)['data']);
      return product;
    } catch (e) {
      throw Exception('Cannot get product with id $productId');
    }
  }
}
