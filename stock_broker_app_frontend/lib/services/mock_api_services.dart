import 'dart:math';

import 'package:stock_broker_app_frontend/models/holding_model.dart';
import 'package:stock_broker_app_frontend/models/order_model.dart';
import 'package:stock_broker_app_frontend/models/user_model.dart';
import 'package:stock_broker_app_frontend/services/stock_db.dart';
import 'package:stock_broker_app_frontend/services/user_date_db.dart';

enum LoginStatus { success, invalid, error }

class MockApiService {
  static Future<LoginStatus> login(
    String broker,
    String username,
    String pass,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    User? user = MockDatabase.getUserById(username);

    if (user != null) {
      return LoginStatus.success;
    }

    return LoginStatus.invalid;

    // simulate server error randomly
  }

  static Future<List<Holding>> getHoldings(username) async {
    await Future.delayed(const Duration(milliseconds: 800));

    User? user = MockDatabase.getUserById(username);

    return user?.holdings ?? [];
  }

  /// Holdings: Settled stocks, shown in holdings tab
  // static Future<List<Holding>> getHoldings() async {
  //   await Future.delayed(const Duration(milliseconds: 800));

  //   return [
  //     Holding(
  //       stockSymbol: "TCS",
  //       quantity: 10,
  //       avgPrice: 3400,
  //       acquiredAt: DateTime.now().subtract(const Duration(days: 4)),
  //     ),
  //     Holding(
  //       stockSymbol: "INFY",
  //       quantity: 20,
  //       avgPrice: 1480,
  //       acquiredAt: DateTime.now().subtract(const Duration(days: 5)),
  //     ),
  //     Holding(
  //       stockSymbol: "HDFC",
  //       quantity: 15,
  //       avgPrice: 1600,
  //       acquiredAt: DateTime.now().subtract(const Duration(days: 6)),
  //     ),
  //   ];
  // }

  // static Future<List<Holding>> getHoldings() async {
  //   await Future.delayed(const Duration(milliseconds: 800));

  //   return [
  //     Holding(
  //       stock: StockDB.getBySymbol("TCS"),
  //       quantity: 10,
  //       avgPrice: 3400,
  //       acquiredAt: DateTime.now().subtract(const Duration(days: 4)),
  //     ),
  //     Holding(
  //       stock: StockDB.getBySymbol("INFY"),
  //       quantity: 20,
  //       avgPrice: 1480,
  //       acquiredAt: DateTime.now().subtract(const Duration(days: 5)),
  //     ),
  //     Holding(
  //       stock: StockDB.getBySymbol("HDFC"),
  //       quantity: 15,
  //       avgPrice: 1600,
  //       acquiredAt: DateTime.now().subtract(const Duration(days: 6)),
  //     ),
  //   ];
  // }

  /// Orders: All user orders (pending, completed, cancelled)
  static Future<List<Order>> getOrderbook() async {
    await Future.delayed(const Duration(milliseconds: 800));

    return [
      Order(
        id: "ORD001",
        stock: StockDB.getBySymbol("TCS"),
        type: "buy",
        quantity: 5,
        price: 3450,
        placedAt: DateTime.now().subtract(const Duration(hours: 1)),
        status: "completed",
      ),
      Order(
        id: "ORD002",
        stock: StockDB.getBySymbol("INFY"),
        type: "sell",
        quantity: 10,
        price: 1500,
        placedAt: DateTime.now().subtract(const Duration(days: 1)),
        status: "completed",
      ),
      Order(
        id: "ORD003",
        stock: StockDB.getBySymbol("HDFC"),
        type: "buy",
        quantity: 7,
        price: 1580,
        placedAt: DateTime.now().subtract(const Duration(hours: 4)),
        status: "pending",
      ),
    ];
  }

  /// Positions: Active trades not yet settled
  // static Future<List<Position>> getPositions() async {
  //   await Future.delayed(const Duration(milliseconds: 800));

  //   return [
  //     Position(
  //       stockSymbol: "RELIANCE",
  //       quantity: 8,
  //       entryPrice: 2400,
  //       openedAt: DateTime.now().subtract(const Duration(days: 1)),
  //     ),
  //     Position(
  //       stockSymbol: "ITC",
  //       quantity: 12,
  //       entryPrice: 460,
  //       openedAt: DateTime.now().subtract(const Duration(hours: 5)),
  //     ),
  //     Position(
  //       stockSymbol: "ZOMATO",
  //       quantity: 30,
  //       entryPrice: 140,
  //       openedAt: DateTime.now().subtract(const Duration(hours: 3)),
  //     ),
  //   ];
  // }

  // static Future<List<Stock>> getHoldings() async {
  //   await Future.delayed(const Duration(milliseconds: 800));
  //   return [
  //     Stock(name: "TCS", quantity: 10, avgPrice: 3400),
  //     Stock(name: "Infosys", quantity: 20, avgPrice: 1480),
  //     Stock(name: "HDFC Bank", quantity: 15, avgPrice: 1600),
  //   ];
  // }

  // static Future<List<Order>> getOrderbook() async {
  //   await Future.delayed(const Duration(milliseconds: 800));
  //   return [
  //     Order(stockName: "TCS", quantity: 5, price: 3450, type: "buy"),
  //     Order(stockName: "Infosys", quantity: 10, price: 1500, type: "sell"),
  //     Order(stockName: "HDFC Bank", quantity: 7, price: 1580, type: "buy"),
  //   ];
  // }

  // static Future<List<Position>> getPositions() async {
  //   await Future.delayed(const Duration(milliseconds: 800));
  //   return [
  //     Position(
  //       stockName: "Reliance",
  //       quantity: 8,
  //       entryPrice: 2400,
  //       pnl: _randomPNL(),
  //     ),
  //     Position(
  //       stockName: "ITC",
  //       quantity: 12,
  //       entryPrice: 460,
  //       pnl: _randomPNL(),
  //     ),
  //     Position(
  //       stockName: "Zomato",
  //       quantity: 30,
  //       entryPrice: 140,
  //       pnl: _randomPNL(),
  //     ),
  //   ];
  // }

  static double _randomPNL() {
    final rand = Random();
    return (rand.nextDouble() * 500) * (rand.nextBool() ? 1 : -1);
  }
}
