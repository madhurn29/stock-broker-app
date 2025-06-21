import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_broker_app_frontend/state/holding_provider.dart';

class HoldingsScreen extends StatelessWidget {
  const HoldingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HoldingsProvider>(context);

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final holdings = provider.holdings;

    return ListView.builder(
      itemCount: holdings.length,
      itemBuilder: (context, index) {
        final stock = holdings[index];
        return ListTile(
          title: Text(stock.name),
          subtitle: Text("Qty: ${stock.quantity} | Avg: ₹${stock.avgPrice}"),
          trailing: Text("Value: ₹${stock.quantity * stock.avgPrice}"),
        );
      },
    );
  }
}
