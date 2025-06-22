import 'package:stock_broker_app_frontend/models/holding_model.dart';
import 'package:stock_broker_app_frontend/models/order_model.dart';
import 'package:stock_broker_app_frontend/models/position_model.dart';

class User {
  final String userId;
  final String username;
  final String email;
  final String password; // 🔐 New field

  final List<Holding> holdings;
  final List<Order> orders;
  final List<Position> positions;

  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.password, // include it in constructor
    required this.holdings,
    required this.orders,
    required this.positions,
  });
}
