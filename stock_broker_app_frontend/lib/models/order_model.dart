class Order {
  final String stockName;
  final int quantity;
  final double price;
  final String type; // buy or sell

  Order({
    required this.stockName,
    required this.quantity,
    required this.price,
    required this.type,
  });
}
