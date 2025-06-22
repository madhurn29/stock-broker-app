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

class Position {
  final String stockSymbol;
  final int quantity;
  final double entryPrice;
  final DateTime openedAt;

  Position({
    required this.stockSymbol,
    required this.quantity,
    required this.entryPrice,
    required this.openedAt,
  });

  // double get pnl => (StockDB.getPrice(stockSymbol) - entryPrice) * quantity;
}
