import 'dart:math';

import 'package:stock_broker_app_frontend/models/order_model.dart';
import 'package:stock_broker_app_frontend/models/position_model.dart';
import 'package:stock_broker_app_frontend/models/stock_model.dart';

enum LoginStatus { success, invalid, error }

class MockApiService {
  static Future<LoginStatus> login(
    String broker,
    String user,
    String pass,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    if (user == "demo" && pass == "123") {
      return LoginStatus.success;
    }
    if (user.isEmpty || pass.isEmpty || user.length < 3) {
      return LoginStatus.invalid;
    }

    return LoginStatus.error; // simulate server error randomly
  }

  static Future<List<Stock>> getHoldings() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      Stock(name: "TCS", quantity: 10, avgPrice: 3400),
      Stock(name: "Infosys", quantity: 20, avgPrice: 1480),
      Stock(name: "HDFC Bank", quantity: 15, avgPrice: 1600),
    ];
  }

  static Future<List<Order>> getOrderbook() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      Order(stockName: "TCS", quantity: 5, price: 3450, type: "buy"),
      Order(stockName: "Infosys", quantity: 10, price: 1500, type: "sell"),
      Order(stockName: "HDFC Bank", quantity: 7, price: 1580, type: "buy"),
    ];
  }

  static Future<List<Position>> getPositions() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      Position(
        stockName: "Reliance",
        quantity: 8,
        entryPrice: 2400,
        pnl: _randomPNL(),
      ),
      Position(
        stockName: "ITC",
        quantity: 12,
        entryPrice: 460,
        pnl: _randomPNL(),
      ),
      Position(
        stockName: "Zomato",
        quantity: 30,
        entryPrice: 140,
        pnl: _randomPNL(),
      ),
    ];
  }

  static double _randomPNL() {
    final rand = Random();
    return (rand.nextDouble() * 500) * (rand.nextBool() ? 1 : -1);
  }
}
