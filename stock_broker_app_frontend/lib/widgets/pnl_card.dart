import 'package:flutter/material.dart';

class PNLCard extends StatelessWidget {
  final double unrealized;
  final double realized;

  const PNLCard({
    super.key,
    required this.unrealized,
    required this.realized,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildPNL("Unrealized", unrealized, Colors.orange),
            _buildPNL("Realized", realized, Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildPNL(String label, double value, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(
          "₹${value.toStringAsFixed(2)}",
          style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
