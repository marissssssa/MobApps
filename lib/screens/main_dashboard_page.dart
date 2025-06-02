import 'package:flutter/material.dart';
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
  }
}
