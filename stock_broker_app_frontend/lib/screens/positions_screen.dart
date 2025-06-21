import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_broker_app_frontend/widgets/pnl_card.dart';
import '../state/positions_provider.dart';

class PositionsScreen extends StatelessWidget {
  const PositionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PositionsProvider>(context);

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        const PNLCard(unrealized: 800, realized: 450),
        const Divider(),
        Expanded(
          child: ListView.builder(
            itemCount: provider.positions.length,
            itemBuilder: (context, index) {
              final pos = provider.positions[index];
              return ListTile(
                title: Text(pos.stockName),
                subtitle: Text(
                  "Qty: ${pos.quantity} | Entry: ₹${pos.entryPrice}",
                ),
                trailing: Text("PNL: ₹${pos.pnl}"),
              );
            },
          ),
        ),
      ],
    );
  }
}
