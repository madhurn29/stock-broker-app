import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_broker_app_frontend/constants/app_theme.dart';
import 'package:stock_broker_app_frontend/screens/splash_screen.dart';
import 'package:stock_broker_app_frontend/state/app_state.dart';

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
      ],
      child: MaterialApp(
        title: 'Stock Broker App',
        theme: appTheme,
        home: SplashScreen(),
      ),
    );
  }
}
