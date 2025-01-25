import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Histori')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Histori direkap selama satu minggu dan otomatis terhapus',
                style: TextStyle(fontSize: 14)),
            SizedBox(height: 10),
            ElevatedButton(onPressed: () {}, child: Text('Download Histori')),
          ],
        ),
      ),
    );
  }
}
