import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:esp_control/backend/firebase_client_handler.dart';

class HomePage extends StatefulWidget {
  final String brokerAddress;

  HomePage({required this.brokerAddress});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FirebaseClientHandler firebaseClientHandler;
  String temperature = '0°C';
  String humidity = '0%';
  String co2 = '0 ppm';
  String smoke = '0 µg/m³';
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null);
    firebaseClientHandler = FirebaseClientHandler();
    firebaseClientHandler.onTemperatureUpdate = (value) {
      setState(() {
        temperature = '$value°C';
      });
    };
    firebaseClientHandler.onHumidityUpdate = (value) {
      setState(() {
        humidity = '$value%';
      });
    };
    firebaseClientHandler.onCo2Update = (value) {
      setState(() {
        co2 = '$value ppm';
      });
    };
    firebaseClientHandler.onSmokeUpdate = (value) {
      setState(() {
        smoke = '$value µg/m³';
      });
    };
  }

  @override
  void dispose() {
    firebaseClientHandler.disconnect();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    String currentDate =
        DateFormat('EEEE, dd MMMM', 'id_ID').format(DateTime.now());

    String getGreeting() {
      final hour = DateTime.now().hour;
      if (hour >= 5 && hour < 10) {
        return "Selamat Pagi";
      } else if (hour >= 10 && hour < 14) {
        return "Selamat Siang";
      } else if (hour >= 14 && hour < 18) {
        return "Selamat Sore";
      } else {
        return "Selamat Malam";
      }
    }

    String greeting = getGreeting();

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
                "Halo, $greeting",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentDate,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          temperature,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade900,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Hari Yang\nCerah",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo.shade900,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Udara di sekitarmu sedang baik, selamat beraktifitas",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade900,
                  ),
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
                    buildInfoCard(
                        "Kelembapan", humidity, "assets/icons/humidity.svg"),
                    buildInfoCard(
                        "Karbon Dioksida", co2, "assets/icons/co2.svg"),
                    buildInfoCard("Asap", smoke, "assets/icons/smoke.svg"),
                    buildInfoCard("Koneksi", "", "assets/icons/connection.svg"),
                    buildInfoCard("History", "", "assets/icons/history.svg"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
}