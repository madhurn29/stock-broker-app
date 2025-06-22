import 'package:stock_broker_app_frontend/models/holding_model.dart';
import 'package:stock_broker_app_frontend/models/order_model.dart';
import 'package:stock_broker_app_frontend/models/position_model.dart';
import 'package:stock_broker_app_frontend/models/user_model.dart';
import 'package:stock_broker_app_frontend/services/stock_db.dart';

class MockDatabase {
  static final List<User> users = [
    User(
      userId: "u123",
      username: "madhur",
      email: "madhur@example.com",
      password: "madhur@123",
      holdings: [
        Holding(
          stock: StockDB.getBySymbol("TCS"),
          lots: [
            Lot(quantity: 5, pricePerShare: 3400),
            Lot(quantity: 5, pricePerShare: 3450),
          ],
          firstAcquiredAt: DateTime.now().subtract(const Duration(days: 4)),
        ),
        Holding(
          stock: StockDB.getBySymbol("INFY"),
          lots: [Lot(quantity: 10, pricePerShare: 1480)],
          firstAcquiredAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
      ],
      positions: [
        Position(
          stock: StockDB.getBySymbol("HDFC"),
          quantity: 7,
          entryPrice: 1580,
          openedAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ],
      orders: [
        Order(
          id: "ORD1001",
          stock: StockDB.getBySymbol("TCS"),
          type: "buy",
          quantity: 10,
          price: 3425,
          status: "completed",
          placedAt: DateTime.now().subtract(const Duration(days: 4)),
        ),
      ],
    ),

    // ✅ Second user
    // User(
    //   userId: "u456",
    //   username: "ravi",
    //   email: "ravi@example.com",
    //   password: "ravi@123",
    //   holdings: [
    //     Holding(
    //       stock: StockDB.getBySymbol("ITC"),
    //       lots: [Lot(quantity: 20, pricePerShare: 450)],
    //       firstAcquiredAt: DateTime.now().subtract(const Duration(days: 3)),
    //     ),
    //   ],
    //   positions: [
    //     Position(
    //       stock: StockDB.getBySymbol("ZOMATO"),
    //       quantity: 15,
    //       entryPrice: 135,
    //       openedAt: DateTime.now().subtract(const Duration(days: 2)),
    //     ),
    //   ],
    //   orders: [
    //     Order(
    //       id: "ORD2001",
    //       stock: StockDB.getBySymbol("ITC"),
    //       type: "buy",
    //       quantity: 20,
    //       price: 450,
    //       status: "completed",
    //       placedAt: DateTime.now().subtract(const Duration(days: 3)),
    //     ),
    //     Order(
    //       id: "ORD2002",
    //       stock: StockDB.getBySymbol("ZOMATO"),
    //       type: "buy",
    //       quantity: 15,
    //       price: 135,
    //       status: "completed",
    //       placedAt: DateTime.now().subtract(const Duration(days: 2)),
    //     ),
    //   ],
    // ),
  ];

  static User? getUserById(String username) {
    try {
      return users.firstWhere((user) => user.username == username);
    } catch (e) {
      return null;
    }
  }
}
