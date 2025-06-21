import 'package:flutter/material.dart';
import 'package:stock_broker_app_frontend/models/order_model.dart';
import 'package:stock_broker_app_frontend/services/mock_api_services.dart';

class OrderbookProvider extends ChangeNotifier {
  List<Order> orders = [];
  bool isLoading = true;

  OrderbookProvider() {
    loadOrders();
  }

  Future<void> loadOrders() async {
    isLoading = true;
    notifyListeners();
    orders = await MockApiService.getOrderbook();
    isLoading = false;
    notifyListeners();
  }
}
