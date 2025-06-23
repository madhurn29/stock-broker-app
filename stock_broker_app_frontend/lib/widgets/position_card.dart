import 'package:flutter/material.dart';
import 'package:stock_broker_app_frontend/constants/app_theme.dart';
import 'package:stock_broker_app_frontend/models/position_model.dart';
import 'package:stock_broker_app_frontend/widgets/stock_symbol_circle.dart';

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
            //  Header Row: Stock Avatar + Name + PNL
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    StockSymbolCircle(symbol: position.stock.symbol),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        position.stock.name,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${isProfit ? '+' : '-'}₹${position.pnl.abs().toStringAsFixed(2)}",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: pnlColor),
                    ),
                    Text(
                      " (${position.pnlPercent.toStringAsFixed(2)}%)",
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: pnlColor),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 8),

            //  Quantity | Entry Price | LTP
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Qty: ${position.quantity} @ ₹${position.entryPrice.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                Text(
                  "LTP: ₹${position.stock.currentPrice.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color:
                        position.stock.dayChange >= 0
                            ? AppColors.buyGreen
                            : AppColors.sellRed,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Current Value | Opened Date
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
