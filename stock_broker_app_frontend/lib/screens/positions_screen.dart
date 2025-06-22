import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_broker_app_frontend/widgets/pnl_card.dart';
import 'package:stock_broker_app_frontend/widgets/position_card.dart';
import '../state/positions_provider.dart';

class PositionsScreen extends StatelessWidget {
  const PositionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PositionsProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            const PNLCard(unrealized: 800, realized: 450),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: provider.position.length,
                itemBuilder: (context, index) {
                  final pos = provider.position[index];
                  return PositionCard(position: pos);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
