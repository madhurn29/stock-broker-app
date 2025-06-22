import 'package:flutter/material.dart';
import 'package:stock_broker_app_frontend/constants/app_theme.dart';

class StockSymbolCircle extends StatelessWidget {
  const StockSymbolCircle({super.key, required this.symbol});
  final String symbol;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: Colors.blueGrey.shade50,
      child: Text(
        symbol.characters.first.toUpperCase(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
