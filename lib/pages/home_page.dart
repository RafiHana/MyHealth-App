import 'package:flutter/material.dart';
import '../widgets/status_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyHealth'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hallo Selamat Pagi',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Udara di sekitarmu sedang baik, selamat beraktifitas',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '01 Oktober, Senin',
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              Text(
                'Pantauan Udara',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              // Status Card List
              Column(
                children: [
                  StatusCard(
                    title: "Karbon Dioksida",
                    value: "500 ppm",
                  ),
                  StatusCard(
                    title: "Asap",
                    value: "500 µg/m³",
                  ),
                  StatusCard(
                    title: "Kelembapan",
                    value: "50%",
                  ),
                  StatusCard(
                    title: "Suhu",
                    value: "30°C",
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Section Catatan atau Tips
              Text(
                'Tips Hari Ini',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.green, size: 30),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Minumlah cukup air hari ini dan hindari aktivitas berat saat cuaca panas.',
                        style: TextStyle(fontSize: 14, color: Colors.green.shade800),
                      ),
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
