class Order {
  final int _orderId;
  final DateTime _orderDate;
  final double _amount;
  Order({orderId, orderDate, amount})
      : _orderId = orderId,
        _orderDate = orderDate,
        _amount = amount;

  int get orderId => _orderId;
  DateTime get orderDate => _orderDate;
  double get amount => _amount;

  static Order fromJson(Map<String, dynamic> json) {
    return Order(
        orderId: json['OrderID'],
        orderDate: json['OrderDate'],
        amount: json['TotalAmount']);
  }
}
