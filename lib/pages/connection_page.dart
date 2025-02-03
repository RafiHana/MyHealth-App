import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:esp_control/backend/firebase_client_handler.dart';

class ConnectionPage extends StatefulWidget {
  @override
  _ConnectionPageState createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  late FirebaseClientHandler _firebaseHandler;
  String _connectionStatus = "TERPUTUS";
  bool _isConnecting = false;

  @override
  void initState() {
    super.initState();
    _firebaseHandler = FirebaseClientHandler();
    _firebaseHandler.onConnectionStatus = (isConnected) {
      setState(() {
        _connectionStatus = isConnected ? "TERHUBUNG" : "TERPUTUS";
      });
    };
  }

  Future<void> _testConnection() async {
    setState(() {
      _isConnecting = true;
      _connectionStatus = "MENGHUBUNGKAN...";
    });

    try {
      final snapshot = await _firebaseHandler.databaseRef.child('test').once();
      if (snapshot.snapshot.value != null) {
        setState(() {
          _connectionStatus = "TERHUBUNG";
        });
      } else {
        setState(() {
          _connectionStatus = "TERPUTUS";
        });
      }
    } catch (e) {
      setState(() {
        _connectionStatus = "TERPUTUS";
      });
    } finally {
      setState(() {
        _isConnecting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F2FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "MyHealth",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade900,
                ),
              ),
              SizedBox(height: 35),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 26, vertical: 24),
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/connection.svg',
                      height: 40,
                      width: 40,
                      color: Colors.indigo.shade900,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Sambungkan dengan Firebase",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isConnecting ? null : _testConnection,
                child: _isConnecting
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Sambungkan',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 21, 29, 113),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  _connectionStatus,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _connectionStatus == "TERHUBUNG"
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firebaseHandler.disconnect();
    super.dispose();
  }
}