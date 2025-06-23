import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:stock_broker_app_frontend/models/broker_model.dart';
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

  final List<Broker> brokers = [
    Broker(title: "Zerodha", imagePath: "assets/brokers/kite.svg"),
    Broker(title: "Upstox", imagePath: "assets/brokers/upstox.svg"),
    Broker(title: "Groww", imagePath: "assets/brokers/groww.svg"),
    Broker(title: "Angel One", imagePath: "assets/brokers/angel_one.svg"),
    Broker(title: "HDFC", imagePath: "assets/brokers/hdfc.svg"),
  ];

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
            SizedBox(height: 10),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: brokers.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final broker = brokers[index];
                final isSelected = broker.title == selectedBroker;

                return GestureDetector(
                  onTap: () => setState(() => selectedBroker = broker.title),
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side:
                          isSelected
                              ? BorderSide(color: AppColors.primary, width: 2)
                              : BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Broker logo
                        SvgPicture.asset(
                          broker.imagePath,
                          height: 50,
                          width: 50,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 8),
                        // Broker name
                        Text(
                          broker.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                isSelected ? AppColors.primary : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
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
