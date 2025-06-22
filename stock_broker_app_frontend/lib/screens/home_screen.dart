import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_broker_app_frontend/screens/holding_screen.dart';
import 'package:stock_broker_app_frontend/screens/login_screen.dart';
import 'package:stock_broker_app_frontend/screens/orderbook_screen.dart';
import 'package:stock_broker_app_frontend/screens/positions_screen.dart';
import 'package:stock_broker_app_frontend/state/holding_provider.dart';
import 'package:stock_broker_app_frontend/widgets/fab.dart';
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
    final provider = Provider.of<HoldingsProvider>(context, listen: false);
    final currentStocks = provider.holdings.map((h) => h.stock).toList();

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
        currentScreenStocks: currentStocks,
      ),
    );
  }
}
