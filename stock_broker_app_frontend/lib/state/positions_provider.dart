import 'package:flutter/material.dart';
import 'package:stock_broker_app_frontend/models/position_model.dart';
import 'package:stock_broker_app_frontend/services/mock_api_services.dart';

class PositionsProvider extends ChangeNotifier {
  List<Position> positions = [];
  bool isLoading = true;

  PositionsProvider() {
    loadPositions();
  }

  Future<void> loadPositions() async {
    isLoading = true;
    notifyListeners();
    // positions = await MockApiService.getPositions();
    isLoading = false;
    notifyListeners();
  }
}
