import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockbasket/constants/strings.dart';
import 'package:stockbasket/models/order_model.dart';
import 'package:stockbasket/services/mock_api_services.dart';

class OrderbookProvider extends ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<void> fetchOrders() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoading = true;
    notifyListeners();

    _orders = await MockApiService.getOrderbook(prefs.getString(USERNAME));

    _isLoading = false;
    notifyListeners();
  }
}
