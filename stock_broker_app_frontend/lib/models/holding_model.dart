import 'package:stock_broker_app_frontend/models/stock_model.dart';

class Lot {
  final int quantity;
  final double pricePerShare;

  Lot({required this.quantity, required this.pricePerShare});
}

class Holding {
  final Stock stock;
  final List<Lot> lots;
  final DateTime firstAcquiredAt;

  Holding({
    required this.stock,
    required this.lots,
    required this.firstAcquiredAt,
  });
  int get totalQty => lots.fold(0, (sum, lot) => sum + lot.quantity);

  double get totalInvested =>
      lots.fold(0.0, (sum, lot) => sum + lot.quantity * lot.pricePerShare);

  double get avgPrice => totalQty == 0 ? 0.0 : totalInvested / totalQty;

  double get currentValue => stock.currentPrice * totalQty;

  double get pnl => currentValue - totalInvested;

  double get pnlPercent => totalInvested == 0 ? 0 : (pnl / totalInvested) * 100;
}
