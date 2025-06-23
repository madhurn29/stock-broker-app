import 'package:flutter/material.dart';
import 'package:stockbasket/constants/app_theme.dart';
import 'package:stockbasket/models/stock_model.dart';
import 'package:stockbasket/widgets/stock_symbol_circle.dart';

class OrderPadBottomSheet extends StatefulWidget {
  final Stock stock;

  const OrderPadBottomSheet({super.key, required this.stock});

  @override
  State<OrderPadBottomSheet> createState() => _OrderPadBottomSheetState();
}

class _OrderPadBottomSheetState extends State<OrderPadBottomSheet> {
  final TextEditingController _qtyController = TextEditingController();
  int _qty = 0;
  double _totalPrice = 0.0;

  String _selectedExchange = "NSE";
  String _selectedOrderType = "Delivery";
  String? _qtyError;

  @override
  void initState() {
    super.initState();
    _qtyController.addListener(() {
      final qty = int.tryParse(_qtyController.text.trim()) ?? 0;
      setState(() {
        _qty = qty;
        _totalPrice = qty * widget.stock.currentPrice;
      });
    });
  }

  void _placeOrder(String action) {
    final qtyText = _qtyController.text.trim();

    setState(() {
      if (qtyText.isEmpty) {
        _qtyError = "Please enter quantity";
        return;
      }

      final qty = int.tryParse(qtyText);
      if (qty == null || qty <= 0) {
        _qtyError = "Enter a valid quantity greater than 0";
        return;
      }

      _qtyError = null; // Clear error if input is valid

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "$action Order placed for ${widget.stock.name} | Qty: $qty | ₹${_totalPrice.toStringAsFixed(2)}",
          ),
          backgroundColor: action == "Buy" ? Colors.green : Colors.red,
        ),
      );
    });
  }

  Widget _stockHeader() {
    final stock = widget.stock;
    return Row(
      children: [
        StockSymbolCircle(symbol: stock.symbol),

        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stock.name,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              "$_selectedExchange • ₹${stock.currentPrice.toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.primary.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _labelValue(String label, String value, {Color? color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.primary.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,

    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.primary.withOpacity(0.7),
            ),

            // const TextStyle(fontSize: 12, color: Colors.grey)
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.indigo),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                elevation: 1,

                value: value,
                items:
                    items.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e, style: TextStyle(fontSize: 12)),
                      );
                    }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final stock = widget.stock;

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Drag Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              _stockHeader(),
              const SizedBox(height: 20),

              // Exchange & Order Type Dropdowns
              Row(
                children: [
                  _buildDropdown(
                    label: "Exchange",
                    value: _selectedExchange,
                    items: const ["NSE", "BSE"],
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedExchange = val);
                    },
                  ),
                  const SizedBox(width: 12),
                  _buildDropdown(
                    label: "Order Type",
                    value: _selectedOrderType,
                    items: const ["Delivery", "Intraday"],
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedOrderType = val);
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              //  Price Info Block
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _labelValue(
                    "Market Price",
                    "₹${stock.currentPrice.toStringAsFixed(2)}",
                  ),
                  _labelValue(
                    "Total",
                    "₹${_totalPrice.toStringAsFixed(2)}",
                    color: Colors.indigo,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: _qtyController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Enter Quantity",
                  labelStyle: TextStyle(
                    color: AppColors.primary.withOpacity(0.7),
                  ),
                  errorText: _qtyError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo, width: 1.5),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo, width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Buy/Sell Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _placeOrder("Buy"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buyGreen,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Buy",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _placeOrder("Sell"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.sellRed,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Sell",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
