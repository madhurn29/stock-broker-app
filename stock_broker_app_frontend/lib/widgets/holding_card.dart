import 'package:flutter/material.dart';
import 'package:stock_broker_app_frontend/constants/app_theme.dart';
import 'package:stock_broker_app_frontend/models/holding_model.dart';
import 'package:stock_broker_app_frontend/widgets/stock_symbol_circle.dart';

class HoldingCard extends StatelessWidget {
  final Holding holding;

  const HoldingCard({super.key, required this.holding});

  @override
  Widget build(BuildContext context) {
    final isProfit = holding.pnl >= 0;
    final pnlColor = isProfit ? AppColors.buyGreen : AppColors.sellRed;
    final ltpColor =
        holding.stock.dayChange >= 0 ? AppColors.buyGreen : AppColors.sellRed;

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
                    StockSymbolCircle(symbol: holding.stock.symbol),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        holding.stock.name,
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
                      "${isProfit ? '+' : '-'}₹${holding.pnl.abs().toStringAsFixed(2)}",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: pnlColor),
                    ),
                    Text(
                      " (${isProfit ? '+' : '-'}${holding.pnlPercent.abs().toStringAsFixed(2)}%)",
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: pnlColor),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Qty | Avg Price | LTP
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Qty: ${holding.totalQty} | Avg: ₹${holding.avgPrice.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                Text(
                  "LTP: ₹${holding.stock.currentPrice.toStringAsFixed(2)}",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: ltpColor),
                ),
              ],
            ),

            const SizedBox(height: 8),
            // Invested | Current Value
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Invested: ₹${holding.totalInvested.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  "Current: ₹${holding.currentValue.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
