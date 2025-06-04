import 'package:flutter/material.dart';

class DiscussionPage extends StatelessWidget {
  // Constructor diperbarui menggunakan super parameter
  const DiscussionPage({super.key});

  final List<Map<String, dynamic>> discussions = const [
    {
      'name': 'Alya Amira',
      'message':
          'Halo semua, saya sedang mengajar kelas 11 yang terdiri dari siswa reguler dan beberapa siswa dengan disleksia...',
      'replies': '12 replies',
      'time': '5 minutes',
      'avatar': Icons.person,
    },
    {
      'name': 'Putra Andre',
      'message':
          'Halo, saya sedang mengajar kelas 11 yang terdiri dari siswa reguler dan beberapa siswa dengan disleksia...',
      'replies': '10 replies',
      'time': '15 minutes',
      'avatar': Icons.person,
    },
    {
      'name': 'Bagus Putra',
      'message':
          'Halo, juga sedang mengajar kelas 11 yang terdiri dari siswa reguler dan beberapa siswa dengan disleksia...',
      'replies': '8 replies',
      'time': '12 minutes',
      'avatar': Icons.person,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DISCUSSION'),
        centerTitle: true,
        backgroundColor: Colors.teal[200],
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: discussions.length,
        itemBuilder: (context, index) {
          final item = discussions[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        item['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(item['message']),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        const Icon(Icons.message, size: 16),
                        const SizedBox(width: 4),
                        Text(item['replies']),
                      ]),
                      Text(item['time']),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
