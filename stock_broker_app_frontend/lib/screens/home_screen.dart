import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockbasket/screens/holding_screen.dart';
import 'package:stockbasket/screens/login_screen.dart';
import 'package:stockbasket/screens/orderbook_screen.dart';
import 'package:stockbasket/screens/positions_screen.dart';
import 'package:stockbasket/state/holding_provider.dart';
import 'package:stockbasket/state/orderbook_provider.dart';
import 'package:stockbasket/state/positions_provider.dart';
import 'package:stockbasket/widgets/fab.dart';
import '../state/app_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    HoldingsScreen(),
    OrderBookScreen(),
    PositionsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final holdingsProvider = Provider.of<HoldingsProvider>(
      context,
      listen: false,
    );
    final orderbookProvider = Provider.of<OrderbookProvider>(
      context,
      listen: false,
    );
    final positionsProvider = Provider.of<PositionsProvider>(
      context,
      listen: false,
    );

    final holdingsStocks =
        holdingsProvider.holdings.map((e) => e.stock).toList();
    final orderbookStocks =
        orderbookProvider.orders.map((e) => e.stock).toList();
    final positionsStocks =
        positionsProvider.position.map((e) => e.stock).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, ${appState.loggedInUserName}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              appState.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.indigo,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Holdings',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Orderbook'),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Positions',
          ),
        ],
      ),

      floatingActionButton: ExpandableDraggableFAB(
        currentScreenStocks:
            _selectedIndex == 0
                ? holdingsStocks
                : _selectedIndex == 1
                ? orderbookStocks
                : positionsStocks,
      ),
    );
  }
}
