import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    HomePage(brokerAddress: ''), // Alamat broker akan diisi dari ConnectionPage
    ConnectionPage(),
    HistoryPage(),
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
      bottomNavigationBar: SafeArea(
        bottom: false,
        child: Container(
          height: 70 + MediaQuery.of(context).viewPadding.bottom,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: [
              _buildNavItem('assets/icons/nav_home.svg', "Home", 0),
              _buildNavItem('assets/icons/nav_connection.svg', "Koneksi", 1),
              _buildNavItem('assets/icons/nav_history.svg', "Histori", 2),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      String iconPath, String label, int index) {
    bool isSelected = _currentIndex == index;
    return BottomNavigationBarItem(
      icon: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple.shade100 : Colors.transparent,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SvgPicture.asset(
          iconPath,
          width: 24,
          height: 24,
          color: Colors.black,
        ),
      ),
      label: label,
    );
  }
}