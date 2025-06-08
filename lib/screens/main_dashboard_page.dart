import 'package:flutter/material.dart';
import 'package:educonnect/screens/guru/guru_homepage.dart';
import 'package:educonnect/screens/siswa/siswa_homepage.dart';
import 'package:educonnect/screens/orang_tua/orang_tua_homepage.dart';
import 'package:educonnect/screens/profile/profile_page.dart';
import 'package:educonnect/screens/siswa/materi_page.dart';
import 'package:educonnect/screens/siswa/tugas_page.dart';
import 'package:educonnect/screens/siswa/latihan_detail_page.dart'; // Import LatihanDetailPage

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

  // Pindahkan data latihan ke sini, sekarang dengan properti 'question'
  final List<Map<String, dynamic>> _allLatihan = [
    {
      'title': 'Algebra II',
      'deadline': '14 May 2025, 23:59 PM',
      'isSubmitted': false,
      'uploadedFileNames': <String>[],
      'question': 'Selesaikan persamaan kuadrat berikut: x^2 - 5x + 6 = 0 Tunjukkan langkah-langkah penyelesaiannya.'
    },
    {
      'title': 'World History',
      'deadline': '14 May 2025, 23:59 PM',
      'isSubmitted': false,
      'uploadedFileNames': <String>[],
      'question': 'Jelaskan dampak utama Revolusi Industri terhadap masyarakat Eropa pada abad ke-19. Sertakan setidaknya dua dampak positif dan dua dampak negatif.'
    },
  ];

  void _navigateToSubject(String subject) {
    setState(() {
      _selectedSubject = subject;
      _selectedIndex = 1; // ke tab Materi
    });
  }

  // Callback untuk menandai latihan sebagai submitted dari LatihanDetailPage
  void _markLatihanAsSubmitted(String title, List<String>? uploadedFileNames) {
    setState(() {
      int index = _allLatihan.indexWhere((item) => item['title'] == title);
      if (index != -1) {
        _allLatihan[index]['isSubmitted'] = uploadedFileNames != null && uploadedFileNames.isNotEmpty;
        _allLatihan[index]['uploadedFileNames'] = uploadedFileNames;
      }
    });
  }

  // Fungsi untuk menavigasi ke LatihanDetailPage dari mana saja
  void _navigateToLatihanDetail(String title) {
    // Temukan data latihan yang sesuai
    final selectedLatihan = _allLatihan.firstWhere((item) => item['title'] == title);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LatihanDetailPage(
          title: selectedLatihan['title'],
          initialFileNames: selectedLatihan['uploadedFileNames'],
          question: selectedLatihan['question'], // Meneruskan properti 'question'
          onTurnIn: (submittedTitle, fileNames) {
            _markLatihanAsSubmitted(submittedTitle, fileNames);
          },
        ),
      ),
    );
  }

  // Fungsi untuk memilih halaman mana yang akan ditampilkan berdasarkan peran
  Widget _getHomepageForRole() {
    switch (widget.role) {
      case UserRole.guru:
        return const GuruHomepage();
      case UserRole.siswa:
        // SiswaHomepage sekarang menerima onHomeworkSelected dan allLatihan
        return SiswaHomepage(
          onSubjectSelected: _navigateToSubject,
          onHomeworkSelected: _navigateToLatihanDetail, // Meneruskan fungsi navigasi
          allLatihan: _allLatihan, // Meneruskan data latihan ke SiswaHomepage
        );
      case UserRole.orangTua:
        return const OrangTuaHomepage();
    }
  }

  List<Widget> _buildScreens() {
    return [
      _getHomepageForRole(), // Halaman utama sesuai peran
      MateriPage(selectedSubject: _selectedSubject),     // Materi page
      TugasPage(
        allLatihan: _allLatihan, // Meneruskan data latihan ke TugasPage
        navigateToLatihanDetail: _navigateToLatihanDetail, // Meneruskan fungsi navigasi
      ),      // Tugas page
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
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}