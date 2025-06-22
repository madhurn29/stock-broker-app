import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_broker_app_frontend/constants/app_theme.dart';
import 'package:stock_broker_app_frontend/models/order_model.dart';
import 'package:stock_broker_app_frontend/state/orderbook_provider.dart';

class OrderBookScreen extends StatelessWidget {
  const OrderBookScreen({super.key});

  double calculateRealizedPNL(List<Order> orders) {
    double pnl = 0.0;

    for (final order in orders) {
      if (order.type.toLowerCase() == 'sell' && order.status == 'completed') {
        final buyPrice = order.buyPrice;
        pnl += (order.price - buyPrice) * order.quantity;
      }
    }

    return pnl;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderbookProvider>(
      builder: (context, provider, child) {
        final realizedPNL = calculateRealizedPNL(provider.orders);
        final unrealizedPNL = 1200.0; // mock value
        return provider.orders.isEmpty
            ? Container()
            : Column(
              children: [
                PNLCard(realizedPNL: realizedPNL, unrealizedPNL: unrealizedPNL),
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.orders.length,
                    itemBuilder:
                        (context, index) =>
                            OrderCard(order: provider.orders[index]),
                  ),
                ),
              ],
            );
      },
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  bool get isBuy => order.type.toLowerCase() == 'buy';

  @override
  Widget build(BuildContext context) {
    final Color typeColor = isBuy ? Colors.green : Colors.red;
    final Color bgTypeColor = isBuy ? Colors.green.shade50 : Colors.red.shade50;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔄 Row: Stock name + BUY/SELL pill
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.stock.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: bgTypeColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    order.type.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: typeColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            Text(
              "Qty: ${order.quantity} @ ₹${order.price.toStringAsFixed(2)} = ₹${(order.quantity * order.price).toStringAsFixed(2)}",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textPrimary),
            ),

            const SizedBox(height: 8),

            // 📍 Date + Status Pill
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: AppColors.textPrimary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatDate(order.placedAt),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor(order.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    order.status.toUpperCase(),
                    style: TextStyle(
                      color: _statusColor(order.status),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  String _formatDate(DateTime date) {
    final d = date.toLocal();
    return "${d.day}/${d.month}/${d.year}";
  }
}

class PNLCard extends StatelessWidget {
  final double realizedPNL;
  final double unrealizedPNL;

  const PNLCard({
    super.key,
    required this.realizedPNL,
    required this.unrealizedPNL,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "PNL Summary",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _pnlItem("Realized", realizedPNL, Colors.green, context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _pnlItem(
    String label,
    double value,
    Color color,
    BuildContext context,
  ) {
    final isPositive = value >= 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: Colors.blueGrey),
        ),
        const SizedBox(height: 4),
        Text(
          "₹${value.toStringAsFixed(2)}",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isPositive ? color : Colors.red,
          ),
        ),
      ],
    );
  }
}
