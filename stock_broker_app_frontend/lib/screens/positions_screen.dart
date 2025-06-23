import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockbasket/widgets/pnl_card.dart';
import 'package:stockbasket/widgets/position_card.dart';
import 'package:stockbasket/widgets/shimmer_screen.dart';
import '../state/positions_provider.dart';

class PositionsScreen extends StatefulWidget {
  const PositionsScreen({super.key});

  @override
  State<PositionsScreen> createState() => _PositionsScreenState();
}

class _PositionsScreenState extends State<PositionsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PositionsProvider>(context, listen: false).fetchPositions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PositionsProvider>(
      builder: (context, provider, child) {
        return provider.isLoading && provider.position.isEmpty
            ? ShimmerScreen()
            : provider.position.isEmpty
            ? Center(child: Text("No data"))
            : Column(
              children: [
                const PNLCard(unrealized: 800, realized: 450),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.position.length,
                    itemBuilder: (context, index) {
                      final pos = provider.position[index];
                      return PositionCard(position: pos);
                    },
                  ),
                ),
              ],
            );
      },
    );
  }
}
