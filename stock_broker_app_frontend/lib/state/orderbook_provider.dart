import 'package:flutter/material.dart';
import 'package:stock_broker_app_frontend/models/order_model.dart';
import 'package:stock_broker_app_frontend/services/mock_api_services.dart';

class OrderbookProvider extends ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<void> fetchOrders(username) async {
    _isLoading = true;
    notifyListeners();

    _orders = await MockApiService.getOrderbook(username);

    _isLoading = false;
    notifyListeners();
  }
}
