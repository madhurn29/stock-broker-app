import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stockbasket/models/stock_model.dart';
import 'package:stockbasket/widgets/order_pad_bottom_sheet.dart';

void showOrderPadBottomSheet(BuildContext context, Stock stock) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,

    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder:
        (ctx) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SafeArea(
              top: false,
              bottom: true,
              child: OrderPadBottomSheet(stock: stock),
            ),
          ),
        ),
  );
}
