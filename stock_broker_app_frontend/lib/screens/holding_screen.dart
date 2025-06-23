import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockbasket/constants/app_theme.dart';
import 'package:stockbasket/state/holding_provider.dart';
import 'package:stockbasket/utils/order_pad.dart';
import 'package:stockbasket/widgets/holding_card.dart';
import 'package:stockbasket/widgets/shimmer_screen.dart';

class HoldingsScreen extends StatefulWidget {
  const HoldingsScreen({super.key});

  @override
  State<HoldingsScreen> createState() => _HoldingsScreenState();
}

class _HoldingsScreenState extends State<HoldingsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HoldingsProvider>(context, listen: false).fetchHoldings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HoldingsProvider>(
      builder: (context, provider, child) {
        return provider.isLoading && provider.holdings.isEmpty
            ? ShimmerScreen()
            : provider.holdings.isEmpty
            ? Center(child: Text("No data"))
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
      },
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
