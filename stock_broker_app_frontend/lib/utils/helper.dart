import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_broker_app_frontend/constants/strings.dart';

class UserDetailsProvider {
  setUserLogin(String userName, String brokerName) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(USERNAME, userName);
    sharedPreferences.setBool(ISLOGGEDIN, true);
    sharedPreferences.setString(BROKERNAME, brokerName);
  }

  setUserLogout() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(USERNAME, "");
    sharedPreferences.setBool(ISLOGGEDIN, false);
    sharedPreferences.setString(BROKERNAME, "");
  }
}