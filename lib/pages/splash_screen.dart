import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:esp_control/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 1.0;
  double _offsetY = 0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _opacity = 0.0;
          _offsetY = -500;
        });
      }
    });

    Future.delayed(Duration(milliseconds: 1500), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyHealthNavigation()),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(0, _offsetY, 0),
        child: Opacity(
          opacity: _opacity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(color: Colors.blue),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/my_health_icon.svg',
                    height: 100,
                    width: 100,
                  ),
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
    );
  }
}
