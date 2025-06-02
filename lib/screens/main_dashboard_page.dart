import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:mobapps/screens/guru/guru_homepage.dart'; // 🔑 Import perbaikan

/// Contoh halaman dashboard sederhana yang memanggil GuruHomepage.
/// Jika nanti kamu ingin menambahkan tab Siswa/Homepage lain,
/// tambahkan import dan navigasi di sini.
class MainDashboardPage extends StatelessWidget {
  const MainDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Untuk sekarang kita langsung menampilkan GuruHomepage.
    return const GuruHomepage();
=======
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
  String _selectedSubject = 'All';

  void _navigateToSubject(String subject) {
    setState(() {
      _selectedSubject = subject;
      _selectedIndex = 1; // ke tab Materi
    });
  }

  // Fungsi untuk memilih halaman mana yang akan ditampilkan berdasarkan peran
  Widget _getHomepageForRole() {
    switch (widget.role) {
      case UserRole.guru:
        return const GuruHomepage();
      case UserRole.siswa:
        return SiswaHomepage(onSubjectSelected: _navigateToSubject);
      case UserRole.orangTua:
        return const OrangTuaHomepage();
    }
  }

  List<Widget> _buildScreens() {
    return [
      _getHomepageForRole(), // Halaman utama sesuai peran
      MateriPage(selectedSubject: _selectedSubject),     // Materi page
      TugasPage(),      // Tugas page
      const ProfilePage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      // Reset subject jika keluar dari tab materi
      if (index != 1) {
        _selectedSubject = 'All';
      }
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
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Material'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Task'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
>>>>>>> f4841ee8c5135e24e1306c9ff81ecfe5e95112ac
  }
}
