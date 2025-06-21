import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_broker_app_frontend/constants/app_theme.dart';
import 'package:stock_broker_app_frontend/screens/splash_screen.dart';
import 'package:stock_broker_app_frontend/state/app_state.dart';
import 'package:stock_broker_app_frontend/state/holding_provider.dart';
import 'package:stock_broker_app_frontend/state/orderbook_provider.dart';
import 'package:stock_broker_app_frontend/state/positions_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(create: (context) => AppState()),
        ChangeNotifierProvider(create: (_) => HoldingsProvider()),
        ChangeNotifierProvider(create: (_) => OrderbookProvider()),
        ChangeNotifierProvider(create: (_) => PositionsProvider()),
      ],
      child: MaterialApp(
        title: 'Stock Broker App',
        theme: appTheme,
        home: SplashScreen(),
      ),
    );
  }
}
