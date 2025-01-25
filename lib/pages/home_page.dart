import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart'; 
import 'package:intl/date_symbol_data_local.dart'; 

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('id_ID', null);
    String currentDate = DateFormat('EEEE, dd MMMM', 'id_ID').format(DateTime.now());

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
                          "30°",
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
                    buildInfoCard("Suhu", "30°C", "assets/icons/temp.svg"),
                    buildInfoCard("Kelembapan", "50%", "assets/icons/humidity.svg"),
                    buildInfoCard("Karbon Dioksida", "500 ppm", "assets/icons/co2.svg"),
                    buildInfoCard("Asap", "500 µg/m³", "assets/icons/smoke.svg"),
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          if (value.isNotEmpty)
            SizedBox(height: 5),
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
