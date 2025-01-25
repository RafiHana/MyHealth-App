import 'package:flutter/material.dart';
import 'pages/splash_screen.dart';
import 'pages/home_page.dart';
import 'pages/history_page.dart';
import 'pages/connection_page.dart';

void main() {
  runApp(MyHealthApp());
}

class MyHealthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyHealth',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(), 
    );
  }
}

class MyHealthNavigation extends StatefulWidget {
  @override
  _MyHealthNavigationState createState() => _MyHealthNavigationState();
}

class _MyHealthNavigationState extends State<MyHealthNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    HistoryPage(),
    ConnectionPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed, 
        backgroundColor: Colors.white,
        elevation: 10,
        items: [
          _buildNavItem(Icons.home, "Home", 0),
          _buildNavItem(Icons.wifi, "Koneksi", 1),
          _buildNavItem(Icons.history, "Histori", 2),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _currentIndex == index;

    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.purple.shade100 : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.black, // Warna ikon tetap hitam
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
      label: '',
    );
  }
}