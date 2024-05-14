enum PriceHistoryType { purchase, sold }

class PriceHistory {
  final String _priceHistorId;
  final int _quantity;
  final double _price;
  final DateTime _startDate;
  final DateTime _endDate;
  final PriceHistoryType _type;
  final String _productId;

  PriceHistory(
      {priceHistoryId, quantity, price, startDate, endDate, type, productId})
      : _priceHistorId = priceHistoryId,
        _quantity = quantity,
        _price = price,
        _startDate = startDate,
        _endDate = endDate,
        _type = type,
        _productId = productId;

  Map<String, dynamic> toJson() {
    return {
      "PriceHistory": _priceHistorId,
      "Quantity": _quantity,
      "Price": _price,
      "StartDate": _startDate,
      "EndDate": _endDate,
      "Type": _type,
      "ProductID": _productId
    };
  }

  PriceHistory fromJson(Map<String, dynamic> json) {
    return PriceHistory(
        priceHistoryId: json['PriceHistory'],
        quantity: json['Quantity'],
        price: json['price'],
        startDate: json['StartDate'],
        endDate: json['EndDate'],
        type: json['Type'],
        productId: json['Product']['ProductID']);
  }
}
