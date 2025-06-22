import 'package:stock_broker_app_frontend/models/holding_model.dart';
import 'package:stock_broker_app_frontend/models/order_model.dart';
import 'package:stock_broker_app_frontend/models/position_model.dart';
import 'package:stock_broker_app_frontend/models/user_model.dart';
import 'package:stock_broker_app_frontend/services/user_date_db.dart';

enum LoginStatus { success, invalid, error }

class MockApiService {
  static Future<LoginStatus> login(
    String broker,
    String username,
    String pass,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    User? user = MockDatabase.getUserByUserName(username);

    if (user != null) {
      return LoginStatus.success;
    }

    return LoginStatus.invalid;
  }

  static Future<List<Holding>> getHoldings(username) async {
    await Future.delayed(const Duration(milliseconds: 800));
    User? user = MockDatabase.getUserByUserName(username);
    return user?.holdings ?? [];
  }

  static Future<List<Order>> getOrderbook(username) async {
    await Future.delayed(const Duration(milliseconds: 800));
    User? user = MockDatabase.getUserByUserName(username);
    return user?.orders ?? [];
  }

  static Future<List<Position>> getPositions(username) async {
    await Future.delayed(const Duration(milliseconds: 800));
    User? user = MockDatabase.getUserByUserName(username);
    return user?.positions ?? [];
  }
}
