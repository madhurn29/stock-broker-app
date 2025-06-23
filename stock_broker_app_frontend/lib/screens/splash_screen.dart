import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_broker_app_frontend/state/holding_provider.dart';
import 'package:stock_broker_app_frontend/state/orderbook_provider.dart';
import 'package:stock_broker_app_frontend/state/positions_provider.dart';
import '../state/app_state.dart';
import 'login_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final appState = Provider.of<AppState>(context, listen: false);
    await appState.initializeFromPrefs();

    // Add a delay for visual splash effect (optional)
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder:
            (_) =>
                appState.isLoggedIn ? const HomeScreen() : const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 8),
            Text("Loading Stock Basket..."),
          ],
        ),
      ),
    );
  }
}
