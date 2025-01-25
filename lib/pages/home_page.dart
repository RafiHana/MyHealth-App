import 'package:flutter/material.dart';
import '../widgets/status_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MyHealth')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hallo Selamat Pagi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Udara di sekitarmu sedang baik, selamat beraktifitas',
                style: TextStyle(fontSize: 14)),
            SizedBox(height: 20),
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
      ),
    );
  }
}
