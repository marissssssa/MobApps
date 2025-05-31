import 'package:flutter/material.dart';

class MateriPage extends StatefulWidget {
  const MateriPage({super.key});

  @override
  State<MateriPage> createState() => _MateriPageState();
}

class _MateriPageState extends State<MateriPage> {
  String selectedSubject = 'Matematika';

  final List<String> subjects = ['Matematika', 'IPA', 'Bahasa'];
  final List<Map<String, dynamic>> materials = [
    {'type': Icons.description, 'label': 'Pelajaran 1'},
    {'type': Icons.volume_up, 'label': 'Pelajaran 1'},
    {'type': Icons.play_circle_filled, 'label': 'Pelajaran 1'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedSubject,
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  selectedSubject = value!;
                });
              },
              items: subjects
                  .map((subject) => DropdownMenuItem(
                        value: subject,
                        child: Text(subject),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            ...materials.map((material) {
              return Card(
                child: ListTile(
                  leading: Icon(material['type'], size: 32),
                  title: Text(material['label']),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigasi ke detail materi
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
