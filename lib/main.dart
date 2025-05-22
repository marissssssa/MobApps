import 'package:flutter/material.dart';
import 'screen/signup_screen.dart'; // Panggil SignUpScreen di sini
// import 'screen/splash_screen.dart';
// import 'screen/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EduConnect',
      home: const SignUpScreen(), // Ganti ke SignUpScreen
    );
  }
}