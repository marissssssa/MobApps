// lib/screens/guru/my_classes_page.dart
import 'package:flutter/material.dart';

class MyClassesPage extends StatelessWidget {
  const MyClassesPage({super.key});

  // Definisikan nama rute untuk halaman ini
  static const String routeName = '/my_classes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Classes'),
        backgroundColor: Colors.teal[200], // Samakan dengan tema DiscussionPage
      ),
      body: const Center(
        child: Text('Halaman Daftar Kelas Saya'),
      ),
    );
  }
}