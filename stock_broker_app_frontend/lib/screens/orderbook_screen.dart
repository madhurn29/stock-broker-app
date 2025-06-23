import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_broker_app_frontend/constants/app_theme.dart';
import 'package:stock_broker_app_frontend/models/order_model.dart';
import 'package:stock_broker_app_frontend/state/orderbook_provider.dart';
import 'package:stock_broker_app_frontend/widgets/orderbook_card.dart';
import 'package:stock_broker_app_frontend/widgets/shimmer_screen.dart';

class OrderBookScreen extends StatefulWidget {
  const OrderBookScreen({super.key});

  @override
  State<OrderBookScreen> createState() => _OrderBookScreenState();
}

class _OrderBookScreenState extends State<OrderBookScreen> {
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderbookProvider>(context, listen: false).fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderbookProvider>(
      builder: (context, provider, child) {
        var realizedPNL = 0.0;
        var unrealizedPNL = 0.0;
        if (provider.orders.isNotEmpty) {
          realizedPNL = calculateRealizedPNL(provider.orders);
          unrealizedPNL = 1200.0;
        }

        // mock value
        return provider.isLoading && provider.orders.isEmpty
            ? ShimmerScreen()
            : provider.orders.isEmpty
            ? Center(child: Text("No data"))
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
              ).textTheme.titleSmall?.copyWith(color: AppColors.primary),
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
        Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith()),
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
