import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockbasket/constants/strings.dart';
import 'package:stockbasket/models/position_model.dart';
import 'package:stockbasket/services/mock_api_services.dart';

class PositionsProvider extends ChangeNotifier {
  List<Position> _positions = [];
  bool isLoading = true;

  List<Position> get position => _positions;

  Future<void> fetchPositions() async {
    isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    _positions = await MockApiService.getPositions(prefs.getString(USERNAME));
    isLoading = false;
    notifyListeners();
  }
}
