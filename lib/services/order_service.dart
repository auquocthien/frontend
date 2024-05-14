import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/ui/cart/cart_item.dart';
import 'package:frontend/models/order.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderService {
  OrderService();

  String baseUrl = '${dotenv.env['BASE_URL']}order';

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  Future<void> addOrder(int sellerId, List<CartItem> products) async {
    List cartItemJson = products.map((e) => e.toJson()).toList();
    print(cartItemJson);
    try {
      final payload = {"sellerID": sellerId, "products": cartItemJson};
      final body = json.encode(payload);
      print(body);
      final response =
          await http.post(Uri.parse(baseUrl), body: body, headers: headers);

      print(response.body);
    } catch (e) {
      throw Exception('cannot add order $e');
    }
  }

  Future<List<Map<String, dynamic>>> getOrderByUserId(String userId) async {
    List<Map<String, dynamic>> result = [];

    try {
      final body = json.encode({"userID": userId});
      final response = await http.post(Uri.parse('$baseUrl/orders'),
          body: body, headers: headers);
      print(response.body);
      Map<String, dynamic> resultData = await json.decode(response.body);

      resultData['data'].forEach((el) {
        el as Map<String, dynamic>;
        result.add(el);
      });
    } catch (e) {
      throw Exception('cannot get orders by userId $e');
    }
    return result;
  }
}
