import 'package:stock_broker_app_frontend/models/stock_model.dart';

enum OrderType { buy, sell }

enum OrderStatus { pending, completed, cancelled }

class Order {
  final String id;
  final Stock stock;
  final String type;
  final int quantity;
  final double price;
  final DateTime placedAt;
  final String status;
  final double buyPrice;

  Order({
    required this.id,
    required this.stock,
    required this.type,
    required this.quantity,
    required this.price,
    required this.placedAt,
    required this.status,
    required this.buyPrice,
  });

  bool get isBuy => type == OrderType.buy;

  double get totalValue => price * quantity;
}
