import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  String? selectedBroker;
  bool isLoggedIn = false;

  Stock? selectedStock;

  void login(String broker) {
    selectedBroker = broker;
    isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    selectedBroker = null;
    isLoggedIn = false;
    selectedStock = null;
    notifyListeners();
  }

  void setSelectedStock(Stock stock) {
    selectedStock = stock;
    notifyListeners();
  }

  initializeFromPrefs() {}
}

class Stock {}
