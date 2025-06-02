// lib/main.dart

import 'package:flutter/material.dart';
import 'screens/guru/guru_homepage.dart'; // Pastikan path sesuai: lib/screens/guru/guru_homepage.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduConnect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const GuruHomepage(), // Halaman utama kita
    );
  }
}
