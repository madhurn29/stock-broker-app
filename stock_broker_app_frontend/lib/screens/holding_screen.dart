import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_broker_app_frontend/constants/app_theme.dart';
import 'package:stock_broker_app_frontend/state/holding_provider.dart';
import 'package:stock_broker_app_frontend/utils/order_pad.dart';
import 'package:stock_broker_app_frontend/widgets/holding_card.dart';

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
