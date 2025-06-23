import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockbasket/constants/app_theme.dart';
import 'package:stockbasket/screens/splash_screen.dart';
import 'package:stockbasket/state/app_state.dart';
import 'package:stockbasket/state/holding_provider.dart';
import 'package:stockbasket/state/orderbook_provider.dart';
import 'package:stockbasket/state/positions_provider.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
        debugShowCheckedModeBanner: false,
        title: 'Stock Broker App',
        theme: appTheme,
        home: SplashScreen(),
      ),
    );
  }
}
