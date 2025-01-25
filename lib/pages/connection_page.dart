import 'package:flutter/material.dart';

class ConnectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Koneksi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sambungkan dengan alamat ESP anda',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Masukkan alamat ESP',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: () {}, child: Text('Sambungkan')),
            SizedBox(height: 20),
            Text('Status koneksi:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Text(
                'Aplikasi anda belum terhubung dengan perangkat mikrokontroller'),
          ],
        ),
      ),
    );
  }
}
