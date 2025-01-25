import 'package:esp_control/pages/splash_screen.dart';
import 'package:flutter/material.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHealthNavigation(),
      home: SplashScreen(),
    );
  }
}

class MyHealthNavigation extends StatefulWidget {
  @override
  _MyHealthNavigationState createState() => _MyHealthNavigationState();
}

class _MyHealthNavigationState extends State<MyHealthNavigation> {
  int _currentIndex = 0; // Indeks halaman aktif

  // List halaman
  final List<Widget> _pages = [
    HomePage(),
    HistoryPage(),
    ConnectionPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index; // Ubah indeks halaman saat ikon diklik
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex, // Halaman yang sedang ditampilkan
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped, // Handle perubahan tab
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Koneksi',
          ),
        ],
      ),
    );
  }
}
