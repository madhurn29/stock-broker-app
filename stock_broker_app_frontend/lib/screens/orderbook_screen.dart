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

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  bool get isBuy => order.type.toLowerCase() == 'buy';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔰 Top row: Icon + Stock name + Type badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _stockSymbolCircle(order.stock.symbol),
                    const SizedBox(width: 10),
                    Text(
                      order.stock.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                _typeChip(order.type),
              ],
            ),

            const SizedBox(height: 10),

            // 💹 Quantity × Price = Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Qty: ${order.quantity}"),
                Text("Price: ₹${order.price.toStringAsFixed(2)}"),
                Text(
                  "Total: ₹${order.totalValue.toStringAsFixed(2)}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // 📅 Placed date + status pill
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      _friendlyDate(order.placedAt),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                _statusChip(order.status),
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

  Widget _typeChip(String type) {
    final isBuy = type.toLowerCase() == 'buy';
    final color = isBuy ? Colors.green : Colors.red;
    final icon = isBuy ? Icons.arrow_upward : Icons.arrow_downward;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            type.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusChip(String status) {
    final statusColor = _statusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: statusColor,
          fontSize: 11,
          fontWeight: FontWeight.w500,
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
}
