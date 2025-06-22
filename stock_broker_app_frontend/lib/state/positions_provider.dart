import 'package:flutter/material.dart';
import 'package:stock_broker_app_frontend/models/position_model.dart';
import 'package:stock_broker_app_frontend/services/mock_api_services.dart';

class PositionsProvider extends ChangeNotifier {
  List<Position> _positions = [];
  bool isLoading = true;

  List<Position> get position => _positions;

  Future<void> fetchPositions(username) async {
    isLoading = true;
    notifyListeners();
    _positions = await MockApiService.getPositions(username);
    isLoading = false;
    notifyListeners();
  }
}
