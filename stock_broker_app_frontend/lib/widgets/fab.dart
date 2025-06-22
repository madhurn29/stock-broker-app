import 'package:flutter/material.dart';
import 'package:stock_broker_app_frontend/models/stock_model.dart';
import 'package:stock_broker_app_frontend/services/stock_db.dart';
import 'package:stock_broker_app_frontend/utils/order_pad.dart';

class ExpandableDraggableFAB extends StatefulWidget {
  final List<Stock> currentScreenStocks;

  const ExpandableDraggableFAB({super.key, required this.currentScreenStocks});

  @override
  State<ExpandableDraggableFAB> createState() => _ExpandableDraggableFABState();
}

class _ExpandableDraggableFABState extends State<ExpandableDraggableFAB> {
  bool isExpanded = false;
  Offset position = const Offset(20, 500); // starting position

  void _openPad(String action) {
    final topStock =
        widget.currentScreenStocks.isNotEmpty
            ? widget.currentScreenStocks.first
            : StockDB.getAllSortedAlphabetically().first;

    showOrderPadBottomSheet(context, topStock);
    setState(() => isExpanded = false);
  }

  Widget _buildActionButton(
    String label,
    Color color,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return FloatingActionButton.extended(
      heroTag: label,
      backgroundColor: color,
      icon: Icon(icon),
      label: Text(label),
      onPressed: onPressed,
    );
  }

  Widget _mainFAB() {
    return FloatingActionButton(
      heroTag: 'main-fab',
      onPressed: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Icon(isExpanded ? Icons.close : Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          left: position.dx,

          top: position.dy,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                position += details.delta;
              });
            },

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    // Expanded Buttons above FAB
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child:
                          isExpanded
                              ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildActionButton(
                                    "Buy",
                                    Colors.green,
                                    Icons.shopping_cart,
                                    () => _openPad("Buy"),
                                  ),
                                  const SizedBox(height: 8),
                                  _buildActionButton(
                                    "Sell",
                                    Colors.red,
                                    Icons.sell,
                                    () => _openPad("Sell"),
                                  ),
                                ],
                              )
                              : SizedBox(),
                    ),
                  ],
                ),
                _mainFAB(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
