import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_broker_app_frontend/constants/app_theme.dart';
import 'package:stock_broker_app_frontend/models/position_model.dart';
import 'package:stock_broker_app_frontend/widgets/pnl_card.dart';
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

class PositionCard extends StatelessWidget {
  final Position position;

  const PositionCard({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    final isProfit = position.pnl >= 0;
    final pnlColor = isProfit ? AppColors.buyGreen : AppColors.sellRed;

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔰 Header Row: Stock Avatar + Name + PNL
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _stockSymbolCircle(position.stock.symbol),
                    const SizedBox(width: 10),
                    Text(
                      position.stock.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${isProfit ? '+' : '-'}₹${position.pnl.abs().toStringAsFixed(2)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: pnlColor,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "(${position.pnlPercent.toStringAsFixed(2)}%)",
                      style: TextStyle(fontSize: 12, color: pnlColor),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 10),

            // 📦 Quantity | Entry Price | LTP
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Qty: ${position.quantity}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  "Entry: ₹${position.entryPrice.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  "LTP: ₹${position.stock.currentPrice.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color:
                        position.stock.dayChange >= 0
                            ? AppColors.buyGreen
                            : AppColors.sellRed,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // 💰 Current Value | Opened Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Current: ₹${position.currentValue.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _friendlyDate(position.openedAt),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _stockSymbolCircle(String symbol) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: Colors.blueGrey.shade50,
      child: Text(
        symbol.characters.first.toUpperCase(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
      ),
    );
  }

  String _friendlyDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays >= 1) {
      return "${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago";
    } else if (diff.inHours >= 1) {
      return "${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago";
    } else {
      return "${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago";
    }
  }
}
