import 'package:flutter/material.dart';
import 'package:educonnect/screens/siswa/latihan_detail_page.dart'; // Import LatihanDetailPage

class TugasPage extends StatelessWidget {
  // Terima data latihan dari MainDashboardPage
  final List<Map<String, dynamic>> allLatihan;
  // Terima fungsi navigasi dari MainDashboardPage
  final void Function(String title) navigateToLatihanDetail;

  const TugasPage({
    super.key,
    required this.allLatihan,
    required this.navigateToLatihanDetail,
  });

  final List<Map<String, dynamic>> kuis = const [
    {'title': 'Geometri', 'deadline': '8 May 2025, 23:59 PM'},
    {'title': 'Hukum Newton', 'deadline': '17 May 2025, 23:59 PM'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text('Kuis', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...kuis.map((item) => Card(
                  child: ListTile(
                    title: Text(item['title']),
                    subtitle: Text(item['deadline']),
                  ),
                )),
            const SizedBox(height: 16),
            const Text('Latihan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            // Gunakan allLatihan yang diterima dari MainDashboardPage
            ...allLatihan.map((item) {
              return Card(
                color: (item['uploadedFileNames'] != null && item['uploadedFileNames'].isNotEmpty)
                    ? const Color.fromRGBO(160, 203, 196, 1)
                    : null,
                child: ListTile(
                  title: Text(
                    item['title'],
                    style: TextStyle(
                        color: (item['uploadedFileNames'] != null && item['uploadedFileNames'].isNotEmpty)
                            ? Colors.white
                            : Colors.black),
                  ),
                  subtitle: Text(
                    item['deadline'],
                    style: TextStyle(
                        color: (item['uploadedFileNames'] != null && item['uploadedFileNames'].isNotEmpty)
                            ? Colors.white70
                            : Colors.grey),
                  ),
                  onTap: () {
                    // Panggil fungsi navigasi yang diterima
                    navigateToLatihanDetail(item['title']);
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}