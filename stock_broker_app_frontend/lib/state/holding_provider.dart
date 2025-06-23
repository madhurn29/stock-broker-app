import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_broker_app_frontend/constants/strings.dart';
import 'package:stock_broker_app_frontend/models/holding_model.dart';
import 'package:stock_broker_app_frontend/services/mock_api_services.dart';

class HoldingsProvider with ChangeNotifier {
  List<Holding> _holdings = [];

  List<Holding> get holdings => _holdings;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchHoldings() async {
    _isLoading = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();

    _holdings = await MockApiService.getHoldings(prefs.getString(USERNAME));

    _isLoading = false;
    notifyListeners();
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
