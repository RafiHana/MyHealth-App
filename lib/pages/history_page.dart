import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F2FF),
      body: SafeArea(
        child: SingleChildScrollView( // Tambahkan SingleChildScrollView di sini
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
                const SizedBox(height: 20),
                Table(
                  border: TableBorder(
                    horizontalInside: BorderSide(color: Colors.black, width: 1),
                  ),
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(2),
                    3: FlexColumnWidth(2),
                    4: FlexColumnWidth(2),
                  },
                  children: [
                    const TableRow(
                      decoration: BoxDecoration(),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Hari', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Suhu', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Kelembapan', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Karbon Dioksida', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Asap', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    buildRow('Senin', true),
                    buildRow('Selasa', false),
                    buildRow('Rabu', false),
                    buildRow('Kamis', true),
                    buildRow('Jumat', false),
                    buildRow('Sabtu', true),
                    buildRow('Minggu', false),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Keterangan:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Icon(Icons.circle, color: Colors.green, size: 12),
                    SizedBox(width: 8),
                    Text('Nilai terendah'),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Icon(Icons.circle, color: Colors.red, size: 12),
                    SizedBox(width: 8),
                    Text('Nilai tertinggi'),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Histori direkap selama satu minggu dan otomatis terhapus',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TableRow buildRow(String day, bool hasData) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(day),
        ),
        buildIconRow(hasData),
        buildIconRow(hasData),
        buildIconRow(hasData),
        buildIconRow(hasData),
      ],
    );
  }

  Widget buildIconRow(bool hasData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.circle, color: Colors.green, size: 12),
              const SizedBox(width: 4),
              Text(hasData ? "50" : "0"), // Data jika ada atau tidak
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.circle, color: Colors.red, size: 12),
              const SizedBox(width: 4),
              Text(hasData ? "100" : "0"), // Data jika ada atau tidak
            ],
          ),
        ],
      ),
    );
  }
}
