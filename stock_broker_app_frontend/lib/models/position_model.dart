import 'package:stockbasket/models/stock_model.dart';

class Position {
  final Stock stock;
  final int quantity;
  final double entryPrice;
  final DateTime openedAt;

  Position({
    required this.stock,
    required this.quantity,
    required this.entryPrice,
    required this.openedAt,
  });

  double get currentValue => stock.currentPrice * quantity;

  double get pnl => currentValue - (entryPrice * quantity);

  double get pnlPercent =>
      (entryPrice * quantity) == 0 ? 0 : (pnl / (entryPrice * quantity)) * 100;
}
