import 'package:flutter/material.dart';

class TugasPage extends StatelessWidget {
  const TugasPage({super.key});

  final List<Map<String, dynamic>> kuis = const [
    {'title': 'Kuis 1', 'deadline': '8 May 2025, 23:59 PM'},
    {'title': 'Kuis 2', 'deadline': '17 May 2025, 23:59 PM'},
  ];

  final List<Map<String, dynamic>> latihan = const [
    {'title': 'Latihan 1', 'deadline': '8 May 2025, 23:59 PM'},
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
            ...latihan.map((item) => Card(
                  child: ListTile(
                    title: Text(item['title']), 
                    subtitle: Text(item['deadline']),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
