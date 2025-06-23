import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockbasket/constants/strings.dart';
import 'package:stockbasket/utils/helper.dart';

class AppState extends ChangeNotifier {
  String? loggedInUserName;
  String? selectedBroker;
  bool isLoggedIn = false;

  Stock? selectedStock;

  Future<void> initializeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool(ISLOGGEDIN) ?? false;
    selectedBroker = prefs.getString(BROKERNAME);
    loggedInUserName = prefs.getString(USERNAME);
    notifyListeners();
  }

  void login(String userName, String broker) {
    loggedInUserName = userName;
    selectedBroker = broker;
    isLoggedIn = true;

    UserDetailsProvider().setUserLogin(userName, broker);
    notifyListeners();
  }

  void logout() {
    selectedBroker = null;
    isLoggedIn = false;
    selectedStock = null;
    UserDetailsProvider().setUserLogout();
    notifyListeners();
  }

  void setSelectedStock(Stock stock) {
    selectedStock = stock;
    notifyListeners();
  }
}

class Stock {}
