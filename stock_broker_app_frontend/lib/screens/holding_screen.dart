import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_broker_app_frontend/constants/app_theme.dart';
import 'package:stock_broker_app_frontend/models/holding_model.dart';
import 'package:stock_broker_app_frontend/state/holding_provider.dart';
import 'package:stock_broker_app_frontend/utils/order_pad.dart';

class HoldingsScreen extends StatelessWidget {
  const HoldingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HoldingsProvider>(context);
    return provider.isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
          children: [
            _HoldingsSummary(provider: provider),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: provider.holdings.length,
                itemBuilder: (context, index) {
                  final holding = provider.holdings[index];
                  return GestureDetector(
                    onTap: () {
                      showOrderPadBottomSheet(context, holding.stock);
                    },
                    child: HoldingCard(holding: holding),
                  );
                },
              ),
            ),
          ],
        );
  }
}

class _HoldingsSummary extends StatelessWidget {
  final HoldingsProvider provider;

  const _HoldingsSummary({required this.provider});

  @override
  Widget build(BuildContext context) {
    final invested = provider.totalInvested;
    final value = provider.totalCurrentValue;
    final pnl = provider.totalReturns;
    final pnlPercent = provider.totalReturnsPercent;

    final isProfit = pnl >= 0;
    final pnlColor = isProfit ? AppColors.buyGreen : AppColors.sellRed;

    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _summaryRow(context, "Invested", "₹${invested.toStringAsFixed(2)}"),
            _summaryRow(context, "Current", "₹${value.toStringAsFixed(2)}"),
            _summaryRow(
              context,
              "P&L",
              "${isProfit ? '+' : '-'}₹${pnl.abs().toStringAsFixed(2)} (${pnlPercent.abs().toStringAsFixed(2)}%)",
              valueColor: pnlColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(
    BuildContext context,
    String label,
    String value, {
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyLarge),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: valueColor),
        ),
      ],
    );
  }
}

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
                    _stockSymbolCircle(holding.stock.symbol),
                    const SizedBox(width: 10),
                    Text(
                      holding.stock.name,
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
                      "${isProfit ? '+' : '-'}₹${holding.pnl.abs().toStringAsFixed(2)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: pnlColor,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "(${isProfit ? '+' : '-'}${holding.pnlPercent.abs().toStringAsFixed(2)}%)",
                      style: TextStyle(fontSize: 12, color: pnlColor),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Qty | Avg Price | LTP
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Qty: ${holding.totalQty}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  "Avg: ₹${holding.avgPrice.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  "LTP: ₹${holding.stock.currentPrice.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: ltpColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

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
}
