import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_broker_app_frontend/screens/home_screen.dart';
import 'package:stock_broker_app_frontend/services/mock_api_services.dart';
import 'package:stock_broker_app_frontend/state/holding_provider.dart';
import 'package:stock_broker_app_frontend/state/orderbook_provider.dart';
import 'package:stock_broker_app_frontend/state/positions_provider.dart';
import '../state/app_state.dart';
import '../constants/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? selectedBroker;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  final brokers = ["Zerodha", "Upstox", "Groww", "Angel One"];

  void handleLogin() async {
    if (selectedBroker == null) return;

    setState(() => isLoading = true);

    final response = await MockApiService.login(
      selectedBroker!,
      usernameController.text.trim(),
      passwordController.text.trim(),
    );

    setState(() => isLoading = false);

    if (!mounted) return;

    switch (response) {
      case LoginStatus.success:
        Provider.of<AppState>(
          context,
          listen: false,
        ).login(usernameController.text.trim(), selectedBroker!);

        Provider.of<HoldingsProvider>(
          context,
          listen: false,
        ).fetchHoldings(usernameController.text.trim());

        Provider.of<OrderbookProvider>(
          context,
          listen: false,
        ).fetchOrders(usernameController.text.trim());

        Provider.of<PositionsProvider>(
          context,
          listen: false,
        ).fetchPositions(usernameController.text.trim());

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );

        break;
      case LoginStatus.invalid:
        showSnackbar("Invalid credentials. Try again.", isError: true);
        break;
      case LoginStatus.error:
        showSnackbar("Server error. Please try again later.", isError: true);
        break;
    }
  }

  void showSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.sellRed : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              "Select your broker",
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 10,
              children:
                  brokers.map((broker) {
                    final isSelected = broker == selectedBroker;
                    return ChoiceChip(
                      label: Text(
                        broker,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : AppColors.primary,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: AppColors.primary,

                      onSelected: (_) {
                        setState(() => selectedBroker = broker);
                      },
                    );
                  }).toList(),
            ),
            const SizedBox(height: 24),
            if (selectedBroker != null) ...[
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: "Username",
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                  // border: OutlineInputBorder(
                  //   borderSide: BorderSide(color: AppColors.primary),
                  // ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Colors.grey),
                  labelText: "Password",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: isLoading ? null : handleLogin,
                child:
                    isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Login"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
