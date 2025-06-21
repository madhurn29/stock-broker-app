class Position {
  final String stockName;
  final int quantity;
  final double entryPrice;
  final double pnl;

  Position({
    required this.stockName,
    required this.quantity,
    required this.entryPrice,
    required this.pnl,
  });
}
