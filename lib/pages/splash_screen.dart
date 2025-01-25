import 'package:flutter/material.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 1.0; // Untuk animasi fade out
  double _offsetY = 0;  // Offset untuk swipe ke atas

  void _onSwipeUp() {
    setState(() {
      _opacity = 0.0;
      _offsetY = -500; // Geser layar ke atas
    });

    // Navigasi ke halaman utama setelah animasi selesai
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            // Deteksi swipe ke atas
            _onSwipeUp();
          }
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          transform: Matrix4.translationValues(0, _offsetY, 0),
          child: Opacity(
            opacity: _opacity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(color: Colors.blue), // Background biru
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.health_and_safety, size: 100, color: Colors.white),
                    SizedBox(height: 20),
                    Text(
                      'MyHealth',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Pantau Udaramu, Jaga Harimu',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
