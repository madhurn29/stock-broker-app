// import 'package:flutter/material.dart';
// import 'package:stock_broker_app_frontend/models/stock_model.dart';
// import 'package:stock_broker_app_frontend/services/mock_api_services.dart';

// class HoldingsProvider extends ChangeNotifier {
//   List<Stock> holdings = [];
//   bool isLoading = true;

//   HoldingsProvider() {
//     loadHoldings();
//   }

//   Future<void> loadHoldings() async {
//     isLoading = true;
//     notifyListeners();
//     holdings = await MockApiService.getHoldings();
//     isLoading = false;
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:stock_broker_app_frontend/models/holding_model.dart';
import 'package:stock_broker_app_frontend/services/mock_api_services.dart';

// class HoldingsProvider with ChangeNotifier {
//   List<Holding> _holdings = [];

//   List<Holding> get holdings => _holdings;

//   HoldingsProvider() {
//     fetchHoldings();
//   }

//   Future<void> fetchHoldings() async {
//     _holdings = await MockApiService.getHoldings();
//     notifyListeners();
//   }
// }

class HoldingsProvider with ChangeNotifier {
  List<Holding> _holdings = [];

  List<Holding> get holdings => _holdings;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchHoldings() async {
    _isLoading = true;
    notifyListeners();

    _holdings = await MockApiService.getHoldings();

    _isLoading = false;
    notifyListeners();
  }

  HoldingsProvider() {
    fetchHoldings();
  }

  // Summary Calculations for Header
  double get totalInvested =>
      _holdings.fold(0.0, (sum, h) => sum + h.totalInvested);

  double get totalCurrentValue =>
      _holdings.fold(0.0, (sum, h) => sum + h.currentValue);

  double get totalReturns => totalCurrentValue - totalInvested;

  double get totalReturnsPercent =>
      totalInvested == 0 ? 0 : (totalReturns / totalInvested) * 100;
}
