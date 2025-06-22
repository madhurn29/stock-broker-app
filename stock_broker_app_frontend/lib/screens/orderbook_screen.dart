import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_broker_app_frontend/utils/order_pad.dart';
import 'package:stock_broker_app_frontend/widgets/pnl_card.dart';
import '../state/orderbook_provider.dart';

class OrderbookScreen extends StatelessWidget {
  const OrderbookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderbookProvider>(context);

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        const PNLCard(unrealized: 1200, realized: 650),
        const Divider(),
        Expanded(
          child: ListView.builder(
            itemCount: provider.orders.length,
            itemBuilder: (context, index) {
              final order = provider.orders[index];
              return GestureDetector(
                onTap: () {
                  // showOrderPadModal(context, stock);
                },
                child: ListTile(
                  title: Text(order.stockName),
                  subtitle: Text(
                    "Qty: ${order.quantity} | Type: ${order.type}",
                  ),
                  trailing: Text("₹${order.price}"),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
