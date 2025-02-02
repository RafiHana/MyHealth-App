import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:esp_control/backend/mqtt_client_handler.dart';

class ConnectionPage extends StatefulWidget {
  @override
  _ConnectionPageState createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  bool isConnected = false;
  String ipAddress = ""; 
  final TextEditingController _ipController = TextEditingController();
  final MqttClientHandler mqttHandler = MqttClientHandler();

  @override
  void initState() {
    super.initState();
    mqttHandler.onConnectionStatusChange = (status) {
      setState(() {
        isConnected = status;
      });
    };
  }

  void connectToESP() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('brokerAddress', _macController.text);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(brokerAddress: _macController.text),
      ),
    );
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
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: connectToESP,
                child: Text(
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
              SizedBox(height: 50),
              Center(
                child: Column(
                  children: [
                    Text(
                      "Status koneksi",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 19, 19, 69),
                      ),
                    ),
                    Text(
                      isConnected ? "TERHUBUNG" : "TERPUTUS",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        color: isConnected ? Colors.green : Colors.red,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      isConnected
                          ? "Aplikasi telah terkoneksi dengan ESP32\nIP: $ipAddress"
                          : "Aplikasi belum terkoneksi dengan ESP32",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    SizedBox(height: 20),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: isConnected ? Colors.green : Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
