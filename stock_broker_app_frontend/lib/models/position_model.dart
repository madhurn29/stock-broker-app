// class Position {
//   final String stockName;
//   final int quantity;
//   final double entryPrice;
//   final double pnl;

//   Position({
//     required this.stockName,
//     required this.quantity,
//     required this.entryPrice,
//     required this.pnl,
//   });
// }

// class Position {
//   final String stockSymbol;
//   final int quantity;
//   final double entryPrice;
//   final DateTime openedAt;

//   Position({
//     required this.stockSymbol,
//     required this.quantity,
//     required this.entryPrice,
//     required this.openedAt,
//     required stock,
//   });
// }

import 'package:stock_broker_app_frontend/models/stock_model.dart';

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
