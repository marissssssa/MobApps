// lib/screens/siswa/materi_page.dart

import 'package:flutter/material.dart';

class MateriPage extends StatelessWidget {
  // Parameter wajib yang akan diisi dari SiswaHomepage
  final String selectedSubject;

  const MateriPage({Key? key, required this.selectedSubject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Contoh UI sederhana untuk halaman materi:
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          selectedSubject,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.grey[100],
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul materi
            Text(
              'Materi: $selectedSubject',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            // Contoh konten materi
            Expanded(
              child: Center(
                child: Text(
                  'Di sini akan ditampilkan detail materi untuk "$selectedSubject".\n\n'
                  'Anda bisa menambahkan daftar sub‐materi, video, PDF, atau konten lain sesuai kebutuhan.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
