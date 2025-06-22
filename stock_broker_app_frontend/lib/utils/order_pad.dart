// lib/utils/order_pad.dart

import 'package:flutter/material.dart';
import 'package:stock_broker_app_frontend/models/stock_model.dart';
import 'package:stock_broker_app_frontend/widgets/order_pad_bottom_sheet.dart';

void showOrderPadModal(BuildContext context, Stock stock) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) => OrderPadBottomSheet(stock: stock),
  );
}
