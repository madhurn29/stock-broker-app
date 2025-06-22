import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_broker_app_frontend/constants/app_theme.dart';
import 'package:stock_broker_app_frontend/models/stock_model.dart';

// class OrderPadBottomSheet extends StatefulWidget {
//   final Stock stock;
//   final String orderType; // 'buy' or 'sell'

//   const OrderPadBottomSheet({
//     super.key,
//     required this.stock,
//     required this.orderType,
//   });

//   @override
//   State<OrderPadBottomSheet> createState() => _OrderPadBottomSheetState();
// }

// class _OrderPadBottomSheetState extends State<OrderPadBottomSheet> {
//   final TextEditingController _qtyController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();

//   String orderKind = 'Market'; // Market or Limit

//   @override
//   void initState() {
//     super.initState();
//     _priceController.text = widget.stock.avgPrice.toStringAsFixed(2);
//   }

//   void placeOrder() {
//     final qty = int.tryParse(_qtyController.text.trim());
//     final price = double.tryParse(_priceController.text.trim());

//     if (qty == null || price == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Invalid quantity or price")),
//       );
//       return;
//     }

//     Navigator.pop(context);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text("${widget.orderType.toUpperCase()} order placed for ${widget.stock.name}"),
//         backgroundColor: widget.orderType == 'buy' ? Colors.green : Colors.red,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isBuy = widget.orderType == 'buy';
//     final color = isBuy ? Colors.green : Colors.red;

//     return Padding(
//       padding: MediaQuery.of(context).viewInsets,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         height: 420,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "${isBuy ? 'Buy' : 'Sell'} ${widget.stock.name}",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _qtyController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: "Quantity"),
//             ),
//             const SizedBox(height: 12),
//             TextField(
//               controller: _priceController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: "Price"),
//             ),
//             const SizedBox(height: 12),
//             DropdownButtonFormField(
//               value: orderKind,
//               items: const [
//                 DropdownMenuItem(value: "Market", child: Text("Market")),
//                 DropdownMenuItem(value: "Limit", child: Text("Limit")),
//               ],
//               onChanged: (value) => setState(() => orderKind = value!),
//               decoration: const InputDecoration(labelText: "Order Type"),
//             ),
//             const Spacer(),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(backgroundColor: color),
//                 onPressed: placeOrder,
//                 child: Text(
//                   "Place ${isBuy ? 'Buy' : 'Sell'} Order",
//                   style: const TextStyle(color: Colors.white),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class OrderPadBottomSheet extends StatefulWidget {
//   final Stock stock;

//   const OrderPadBottomSheet({super.key, required this.stock});

//   @override
//   State<OrderPadBottomSheet> createState() => _OrderPadBottomSheetState();
// }

// class _OrderPadBottomSheetState extends State<OrderPadBottomSheet> {
//   final TextEditingController _qtyController = TextEditingController();
//   int _qty = 0;
//   double _totalPrice = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     _qtyController.addListener(() {
//       final qty = int.tryParse(_qtyController.text.trim()) ?? 0;
//       setState(() {
//         _qty = qty;
//         _totalPrice = qty * widget.stock.currentPrice;
//       });
//     });
//   }

//   void _placeOrder(String action) {
//     if (_qty <= 0) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Enter a valid quantity")));
//       return;
//     }

//     Navigator.pop(context);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           "$action Order placed for ${widget.stock.name} | Qty: $_qty | ₹${_totalPrice.toStringAsFixed(2)}",
//         ),
//         backgroundColor: action == "Buy" ? Colors.green : Colors.red,
//       ),
//     );
//   }

//   Widget _rowItem(String label, String value, {Color? color}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
//         const SizedBox(height: 4),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//             color: color,
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final stock = widget.stock;

//     return Padding(
//       padding: MediaQuery.of(context).viewInsets,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         height: 440,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Container(
//                 width: 40,
//                 height: 4,
//                 margin: const EdgeInsets.only(bottom: 12),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[600],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             Text(
//               stock.name,
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const Text("NSE", style: TextStyle(color: Colors.grey)),
//             const Divider(height: 24),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _rowItem("Avg. Price", "₹${stock.currentPrice.toStringAsFixed(2)}"),
//                 _rowItem("Current Qty", "1"),
//               ],
//             ),
//             const SizedBox(height: 12),
//             TextField(
//               controller: _qtyController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: "Enter Quantity"),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "Total Price",
//                   style: TextStyle(fontSize: 14, color: Colors.grey),
//                 ),
//                 Text(
//                   "₹${_totalPrice.toStringAsFixed(2)}",
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             const Spacer(),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () => _placeOrder("Buy"),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                     ),
//                     child: const Text(
//                       "Buy",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () => _placeOrder("Sell"),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                     ),
//                     child: const Text(
//                       "Sell",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class OrderPadBottomSheet extends StatefulWidget {
//   final Stock stock;

//   const OrderPadBottomSheet({super.key, required this.stock});

//   @override
//   State<OrderPadBottomSheet> createState() => _OrderPadBottomSheetState();
// }

// class _OrderPadBottomSheetState extends State<OrderPadBottomSheet> {
//   final TextEditingController _qtyController = TextEditingController();
//   int _qty = 0;
//   double _totalPrice = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     _qtyController.addListener(() {
//       final qty = int.tryParse(_qtyController.text.trim()) ?? 0;
//       setState(() {
//         _qty = qty;
//         _totalPrice = qty * widget.stock.currentPrice;
//       });
//     });
//   }

//   void _placeOrder(String action) {
//     if (_qty <= 0) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Enter a valid quantity")));
//       return;
//     }

//     Navigator.pop(context);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           "$action Order placed for ${widget.stock.name} | Qty: $_qty | ₹${_totalPrice.toStringAsFixed(2)}",
//         ),
//         backgroundColor: action == "Buy" ? Colors.green : Colors.red,
//       ),
//     );
//   }

//   Widget _stockHeader() {
//     final stock = widget.stock;
//     return Row(
//       children: [
//         CircleAvatar(
//           backgroundColor: Colors.blue.shade50,
//           child: Text(
//             stock.symbol[0].toUpperCase(),
//             style: const TextStyle(color: Colors.blue),
//           ),
//         ),
//         const SizedBox(width: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               stock.name,
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               "NSE • ₹${stock.currentPrice.toStringAsFixed(2)}",
//               style: const TextStyle(color: Colors.grey),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _labelValue(String label, String value, {Color? color}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
//         const SizedBox(height: 4),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 15,
//             fontWeight: FontWeight.bold,
//             color: color ?? Colors.black,
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final stock = widget.stock;

//     return Padding(
//       padding: MediaQuery.of(context).viewInsets,
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         height: 460,
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Top Drag Handle
//             Center(
//               child: Container(
//                 width: 40,
//                 height: 4,
//                 margin: const EdgeInsets.only(bottom: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[400],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),

//             _stockHeader(),

//             const Divider(height: 30),

//             // 📈 Price Info Block
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _labelValue(
//                   "Market Price",
//                   "₹${stock.currentPrice.toStringAsFixed(2)}",
//                 ),
//                 _labelValue(
//                   "Total",
//                   "₹${_totalPrice.toStringAsFixed(2)}",
//                   color: Colors.indigo,
//                 ),
//               ],
//             ),

//             const SizedBox(height: 20),

//             // 🔢 Qty Input
//             TextField(
//               controller: _qtyController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: "Enter Quantity",
//                 labelStyle: TextStyle(color: Colors.grey),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(
//                     color: Colors.indigo,
//                     width: 1.5,
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(
//                     color: Colors.indigo,
//                     width: 1.5,
//                   ),
//                 ),
//               ),
//             ),

//             const Spacer(),

//             // 🟢🔴 Buy/Sell Buttons
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () => _placeOrder("Buy"),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.buyGreen,
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text(
//                       "Buy",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () => _placeOrder("Sell"),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.sellRed,
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text(
//                       "Sell",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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

      _qtyError = null; // ✅ Clear error if input is valid

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
        CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          child: Text(
            stock.symbol[0].toUpperCase(),
            style: const TextStyle(color: Colors.blue),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stock.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "$_selectedExchange • ₹${stock.currentPrice.toStringAsFixed(2)}",
              style: const TextStyle(color: Colors.grey),
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
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: color ?? Colors.black,
          ),
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
            "label",
            style: const TextStyle(fontSize: 12, color: Colors.grey),
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
                  labelStyle: const TextStyle(color: Colors.grey),
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
