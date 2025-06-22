// class Stock {
//   final String name;
//   final int quantity;
//   final double avgPrice;

//   Stock({
//     required this.name,
//     required this.quantity,
//     required this.avgPrice,
//   });
// }

class Stock {
  final String symbol;
  final String name;
  final double currentPrice;
  final double dayChange;
  final double dayChangePercent;
  // Live market price

  Stock({
    required this.symbol,
    required this.name,
    required this.currentPrice,
    required this.dayChange,
    required this.dayChangePercent,
  });
}
