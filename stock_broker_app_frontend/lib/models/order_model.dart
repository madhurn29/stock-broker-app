// class Order {
//   final String stockName;
//   final int quantity;
//   final double price;
//   final String type; // buy or sell

//   Order({
//     required this.stockName,
//     required this.quantity,
//     required this.price,
//     required this.type,
//   });
// }

enum OrderType { buy, sell }

enum OrderStatus { pending, completed, cancelled }

class Order {
  final String id;
  final String stockSymbol;
  final OrderType type;
  final int quantity;
  final double price;
  final DateTime placedAt;
  final OrderStatus status;

  Order({
    required this.id,
    required this.stockSymbol,
    required this.type,
    required this.quantity,
    required this.price,
    required this.placedAt,
    required this.status,
  });
}
