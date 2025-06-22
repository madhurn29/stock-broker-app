import 'package:stock_broker_app_frontend/models/stock_model.dart';

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
    Stock(
      symbol: "WPO",
      name: "Wipro",
      currentPrice: 1685.5,
      dayChange: 9.2,
      dayChangePercent: 0.55,
    ),
    Stock(
      symbol: "ITC",
      name: "Indian Tobacco Company",
      currentPrice: 168.5,
      dayChange: 9.2,
      dayChangePercent: 0.55,
    ),
    Stock(
      symbol: "ZMT",
      name: "Zomato",
      currentPrice: 148.5,
      dayChange: 9.2,
      dayChangePercent: 0.55,
    ),
    Stock(
      symbol: "LIC",
      name: "Life Insurance Company",
      currentPrice: 248.5,
      dayChange: 9.2,
      dayChangePercent: 0.55,
    ),
  ];

  /// Get all stocks
  static List<Stock> get all => _allStocks;

  /// Get a stock by its symbol (case-insensitive)
  static Stock getBySymbol(String symbol) {
    return _allStocks.firstWhere(
      (s) => s.symbol.toUpperCase() == symbol.toUpperCase(),
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

  static List<Stock> getAllSortedAlphabetically() {
    return _allStocks;
  }
}
