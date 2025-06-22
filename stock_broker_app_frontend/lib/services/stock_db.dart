import 'package:stock_broker_app_frontend/models/stock_model.dart';

// class StockDB {
//   // Centralized list of all available stocks
//   static final List<Stock> _allStocks = [
//     Stock(
//       symbol: "TCS",
//       name: "Tata Consultancy Services",
//       currentPrice: 3520.0,
//     ),
//     Stock(symbol: "INFY", name: "Infosys Ltd", currentPrice: 1492.5),
//     Stock(symbol: "HDFC", name: "HDFC Bank Ltd", currentPrice: 1650.0),
//     Stock(
//       symbol: "RELIANCE",
//       name: "Reliance Industries",
//       currentPrice: 2500.0,
//     ),
//     Stock(symbol: "ITC", name: "ITC Ltd", currentPrice: 455.0),
//     Stock(symbol: "ZOMATO", name: "Zomato Ltd", currentPrice: 132.0),
//   ];

//   /// Get all stocks
//   static List<Stock> get all => _allStocks;

//   /// Get a stock by its symbol (case-insensitive)
//   static Stock getBySymbol(String symbol) {
//     return _allStocks.firstWhere(
//       (s) => s.symbol.toUpperCase() == symbol.toUpperCase(),
//       orElse: () => throw Exception("Stock not found: $symbol"),
//     );
//   }

//   /// Optionally, update price if needed (e.g. for live price simulation)
//   static void updatePrice(String symbol, double newPrice) {
//     final index = _allStocks.indexWhere(
//       (s) => s.symbol.toUpperCase() == symbol.toUpperCase(),
//     );
//     if (index != -1) {
//       _allStocks[index] = Stock(
//         symbol: _allStocks[index].symbol,
//         name: _allStocks[index].name,
//         currentPrice: newPrice,
//       );
//     }
//   }

//   //   static double getPrice(String symbol) {
// //     return _prices[symbol] ?? 100.0;
// //   }
// }

// stock_db.dart

class StockDB {
  static final List<Stock> _allStocks = [
    Stock(
      symbol: "TCS",
      name: "Tata Consultancy Services",
      currentPrice: 3040.0,
      dayChange: 18.0,
      dayChangePercent: 0.48,
    ),
    Stock(
      symbol: "INFY",
      name: "Infosys Ltd",
      currentPrice: 1520.0,
      dayChange: -12.5,
      dayChangePercent: -0.82,
    ),
    Stock(
      symbol: "HDFC",
      name: "HDFC Bank Ltd",
      currentPrice: 1685.5,
      dayChange: 9.2,
      dayChangePercent: 0.55,
    ),
    // Add more stocks below as needed...
  ];

  /// Get all stocks
  static List<Stock> get all => _allStocks;

  /// Get a stock by its symbol (case-insensitive)
  static Stock getBySymbol(String symbol) {
    return _allStocks.firstWhere(
      (s) => s.symbol.toUpperCase() == symbol.toUpperCase(),
      orElse: () => throw Exception("Stock not found: $symbol"),
    );
  }

  /// Update price dynamically if needed
  static void updatePrice(String symbol, double newPrice) {
    final index = _allStocks.indexWhere(
      (s) => s.symbol.toUpperCase() == symbol.toUpperCase(),
    );
    if (index != -1) {
      _allStocks[index] = Stock(
        symbol: _allStocks[index].symbol,
        name: _allStocks[index].name,
        currentPrice: newPrice,
        dayChange: _allStocks[index].dayChange, // keep same for now
        dayChangePercent: _allStocks[index].dayChangePercent,
      );
    }
  }
}
