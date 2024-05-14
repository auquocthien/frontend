import 'dart:ffi';

class CartItem {
  final int _productId;
  final int _quantity;
  final double _price;
  final String _productName;

  CartItem({productId, quantity, price, productName})
      : _productId = productId,
        _quantity = quantity,
        _price = price,
        _productName = productName;

  CartItem copyWith(
      {int? productId, int? quantity, double? price, String? productName}) {
    return CartItem(
        productId: productId ?? _productId,
        quantity: quantity ?? _quantity,
        price: price ?? _price,
        productName: productName ?? _productName);
  }

  int get productId => _productId;
  double get price => _price;
  String get productName => _productName;
  int get quantity => _quantity;

  static CartItem fromJson(Map<String, dynamic> json) {
    return CartItem(
        productId: json['productId'],
        quantity: json['quantity'],
        price: json['price'],
        productName: json['productName']);
  }

  Map<String, dynamic> toJson() {
    return {
      "productID": productId,
      "quantity": quantity,
    };
  }
}
