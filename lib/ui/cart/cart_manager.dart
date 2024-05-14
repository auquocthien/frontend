import 'package:flutter/material.dart';
import 'package:frontend/ui/cart/cart_item.dart';
import 'package:frontend/models/order.dart';
import 'package:frontend/services/order_service.dart';

class CartManager with ChangeNotifier {
  List<CartItem> _carts = [];

  final OrderService _orderService;

  CartManager() : _orderService = OrderService();

  int get cartLength {
    return _carts.length;
  }

  void addProduct(Map<String, dynamic> item) {
    CartItem cartItem = CartItem.fromJson(item);
    int existingIndex =
        _carts.indexWhere((cart) => cart.productId == cartItem.productId);
    if (existingIndex != -1) {
      _carts[existingIndex] =
          _carts[existingIndex].copyWith(quantity: cartItem.quantity);
    } else {
      _carts.add(cartItem);
    }
    notifyListeners();
  }

  void deleteCart() {
    _carts = [];
    notifyListeners();
  }

  void addOrder(int sellerId) async {
    try {
      await _orderService.addOrder(sellerId, _carts);
    } catch (e) {
      print(e);
    }
  }

  double totalAmount() {
    double amount = 0.0;

    _carts.forEach((element) {
      amount = amount + (element.price * element.quantity);
    });

    return amount;
  }

  List<CartItem> get carts => _carts;
}
