import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:esp_control/backend/mqtt_client_handler.dart';

class HomePage extends StatefulWidget {
  final String brokerAddress;

  HomePage({required this.brokerAddress});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MqttClientHandler mqttClientHandler;
  String temperature = '0°C';
  String humidity = '0%';
  String co2 = '0 ppm';
  String smoke = '0 µg/m³';
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null);

    mqttClientHandler = MqttClientHandler(widget.brokerAddress);
    
    mqttClientHandler.onConnectionStatus = (status) {
      setState(() {
        isConnected = status;
      });
    };

    mqttClientHandler.onTemperatureUpdate = (value) {
      setState(() {
        temperature = '$value°C';
      });
    };
    mqttClientHandler.onHumidityUpdate = (value) {
      setState(() {
        humidity = '$value%';
      });
    };
    mqttClientHandler.onCo2Update = (value) {
      setState(() {
        co2 = '$value ppm';
      });
    };
    mqttClientHandler.onSmokeUpdate = (value) {
      setState(() {
        smoke = '$value µg/m³';
      });
    };

    mqttClientHandler.connect();
  }

  @override
  void dispose() {
    mqttClientHandler.disconnect();
    super.dispose();
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
              SizedBox(height: 4),
              Text(
                "Status Koneksi: ${isConnected ? "TERHUBUNG" : "TERPUTUS"}",
                style: TextStyle(
                  fontSize: 16,
                  color: isConnected ? Colors.green : Colors.red,
                ),
              ),
              SizedBox(height: 16),
              // Tambahkan indikator koneksi di UI
              Center(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: isConnected ? Colors.green : Colors.red,
                ),
              ),
              SizedBox(height: 20),
              Flexible(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    buildInfoCard("Suhu", temperature, "assets/icons/temp.svg"),
                    buildInfoCard("Kelembapan", humidity, "assets/icons/humidity.svg"),
                    buildInfoCard("Karbon Dioksida", co2, "assets/icons/co2.svg"),
                    buildInfoCard("Asap", smoke, "assets/icons/smoke.svg"),
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
  Widget buildInfoCard(String title, String value, String iconPath) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconPath, height: 40, color: Colors.white),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          if (value.isNotEmpty) SizedBox(height: 5),
          if (value.isNotEmpty)
            Text(
              value,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
        ],
      ),
    );
  }
