import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerScreen extends StatelessWidget {
  const ShimmerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SummaryShimmer(),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (_, __) => const CardShimmer(),
          ),
        ),
      ],
    );
  }
}

class CardShimmer extends StatelessWidget {
  const CardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row for avatar and name
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(width: 80, height: 14, color: Colors.white),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(width: 60, height: 14, color: Colors.white),
                      const SizedBox(height: 4),
                      Container(width: 50, height: 12, color: Colors.white),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Qty | Avg Price | LTP
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  3,
                  (_) => Container(width: 80, height: 12, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),

              // Invested | Current Value
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  2,
                  (_) => Container(width: 120, height: 12, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SummaryShimmer extends StatelessWidget {
  const SummaryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            3,
            (_) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 60, height: 14, color: Colors.white),
                const SizedBox(height: 6),
                Container(width: 80, height: 16, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
