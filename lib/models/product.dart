class Product {
  final int _productId;
  final String _productName;
  final double _currentPrice;
  final String _description;
  final String _image;
  final int _quantity;

  Product({productId, productName, currentPrice, description, image, quantity})
      : _productId = productId,
        _productName = productName,
        _currentPrice = currentPrice,
        _description = description,
        _image = image,
        _quantity = quantity;

  Product copyWith(
      {int? productId,
      String? productName,
      double? currentPrice,
      String? description,
      String? image,
      int? quantity}) {
    return Product(
        productId: productId ?? _productId,
        productName: productName ?? _productName,
        currentPrice: currentPrice ?? _currentPrice,
        description: description ?? _description,
        image: image ?? _image,
        quantity: quantity ?? _quantity);
  }

  String get productName => _productName;
  String get image => _image;
  int get productId => _productId;
  int get quatity => _quantity;
  String get desc => _description;
  double get price => _currentPrice;

  Map<String, dynamic> toJson() {
    return {
      "ProductID": _productId,
      "ProductName": _productName,
      "CurrentPrice": _currentPrice,
      "Description": _description,
      "Image": _image,
      "Quantity": _quantity
    };
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
        productId: json['ProductID'],
        productName: json['ProductName'],
        currentPrice: double.parse(json['CurrentPrice']),
        description: json['Description'],
        image: json['Image'],
        quantity: json['Quantity']);
  }

  @override
  String toString() {
    // TODO: implement toString
    return _productName;
  }
}
