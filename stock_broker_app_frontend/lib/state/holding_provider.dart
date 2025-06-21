import 'package:flutter/material.dart';
import 'package:stock_broker_app_frontend/models/stock_model.dart';
import 'package:stock_broker_app_frontend/services/mock_api_services.dart';

class HoldingsProvider extends ChangeNotifier {
  List<Stock> holdings = [];
  bool isLoading = true;

  HoldingsProvider() {
    loadHoldings();
  }

  Future<void> loadHoldings() async {
    isLoading = true;
    notifyListeners();
    holdings = await MockApiService.getHoldings();
    isLoading = false;
    notifyListeners();
  }
}
