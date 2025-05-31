import 'package:flutter/material.dart';
import 'package:educonnect/screens/guru/guru_homepage.dart';
import 'package:educonnect/screens/siswa/siswa_homepage.dart';
import 'package:educonnect/screens/orang_tua/orang_tua_homepage.dart';
import 'package:educonnect/screens/profile/profile_page.dart';
import 'package:educonnect/screens/siswa/materi_page.dart';
import 'package:educonnect/screens/siswa/tugas_page.dart';

// Enum untuk mendefinisikan peran pengguna. Ini lebih aman daripada menggunakan String.
enum UserRole { guru, siswa, orangTua }

class MainDashboardPage extends StatefulWidget {
  final UserRole role;

  const MainDashboardPage({super.key, required this.role});

  @override
  State<MainDashboardPage> createState() => _MainDashboardPageState();
}

class _MainDashboardPageState extends State<MainDashboardPage> {
  int _selectedIndex = 0; // Index untuk item navigasi bawah yang aktif

  // Fungsi untuk memilih halaman mana yang akan ditampilkan berdasarkan peran
  Widget _getHomepageForRole() {
    switch (widget.role) {
      case UserRole.guru:
        return const GuruHomepage();
      case UserRole.siswa:
        return const SiswaHomepage();
      case UserRole.orangTua:
        return const OrangTuaHomepage();
    }
  }

  List<Widget> _buildScreens() {
    return [
      _getHomepageForRole(), // Halaman utama sesuai peran
      MateriPage(),     // Materi page
      TugasPage(),      // Tugas page
      const ProfilePage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = _buildScreens();
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Materi'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Tugas'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
