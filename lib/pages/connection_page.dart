import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'home_page.dart';
import 'package:esp_control/backend/mqtt_client_handler.dart'; 

class ConnectionPage extends StatefulWidget {
  @override
  _ConnectionPageState createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  final TextEditingController _ipController = TextEditingController();
  late MqttClientHandler _mqttTester;
  String _connectionStatus = "TERPUTUS";
  bool _isConnecting = false;

  @override
  void initState() {
    super.initState();
    _mqttTester = MqttClientHandler('');
    _loadSavedBroker();
  }

  void _loadSavedBroker() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedBroker = prefs.getString('brokerAddress');
    if (savedBroker != null) {
      _ipController.text = savedBroker;
    }
  }

  Future<void> _testConnection() async {
    if (_ipController.text.isEmpty) return;

    setState(() {
      _isConnecting = true;
      _connectionStatus = "MENGHUBUNGKAN...";
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('brokerAddress', _ipController.text);

      _mqttTester.broker = _ipController.text;
      await _mqttTester.connect();
      
      setState(() {
        _connectionStatus = "TERHUBUNG";
      });
      
      await Future.delayed(Duration(seconds: 1));
      _mqttTester.disconnect();
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
                        "Sambungkan dengan alamat ESP anda",
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
              Text(
                "Masukkan di bawah ini",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _ipController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukkan alamat IP ESP32',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => _ipController.clear(),
                  ),
                ),
                keyboardType: TextInputType.text,
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
    _mqttTester.disconnect();
    super.dispose();
  }
}