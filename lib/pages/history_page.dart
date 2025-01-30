import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F2FF),
      body: SafeArea(
        child: SingleChildScrollView(
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
                ElevatedButton.icon(
                  onPressed: () => _downloadPdf(context),
                  icon: const Icon(
                    Icons.download,
                    color: Color.fromARGB(255, 249, 249, 249),
                  ),
                  label: const Text(
                    "Download History",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo.shade900,
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
                          padding: EdgeInsets.all(1.0),
                          child: Text('Hari',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Text('Suhu',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Text('Kelembapan',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Text('Karbon Dioksida',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Text('Asap',
                              style: TextStyle(fontWeight: FontWeight.bold)),
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
              Text(hasData ? "50" : "0"),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.circle, color: Colors.red, size: 12),
              const SizedBox(width: 4),
              Text(hasData ? "100" : "0"),
            ],
          ),
        ],
      ),
    );
  }

  void _downloadPdf(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "MyHealth History",
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 16),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Hari',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Suhu',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Kelembapan',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Karbon Dioksida',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Asap',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                    ],
                  ),
                  ...[
                    {
                      'Hari': 'Senin',
                      'Suhu': '50',
                      'Kelembapan': '50',
                      'Karbon Dioksida': '100',
                      'Asap': '10'
                    }
                  ].map((data) {
                    return pw.TableRow(
                        children:
                            data.values.map((val) => pw.Text(val)).toList());
                  }).toList(),
                ],
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
