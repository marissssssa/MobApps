import 'package:flutter/material.dart';
import 'dart:async'; // Import untuk Timer
import 'package:educonnect/screens/main_dashboard_page.dart'; // Sesuaikan path

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      // Setelah 2 detik, navigasi ke MainDashboardPage
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MainDashboardPage(role: UserRole.siswa),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Sesuaikan warna latar belakang
      body: Center(
        child: Image.asset(
          'assets/images/LOGO.png', 
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}