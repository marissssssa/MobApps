// lib/screens/guru/guru_homepage.dart

import 'package:flutter/material.dart';

class GuruHomepage extends StatelessWidget {
  const GuruHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    // Kita batasi lebar konten agar menyerupai layar iPhone (max 375px)
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = 375;
          if (constraints.maxWidth < maxWidth) {
            maxWidth = constraints.maxWidth;
          }

          return Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildHeader(context),
                      const SizedBox(height: 16),
                      _buildGridMenu(context),
                      const SizedBox(height: 24),
                      _buildTodaysClassesTitle(),
                      const SizedBox(height: 12),
                      _buildClassList(),
                      const SizedBox(
                          height:
                              80), // Spasi agar bottom nav tidak menutup konten
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          // Kolom teks “Hello,” + “Esther Howard!” + “(Teacher)”
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4),
                Text(
                  'Hello,',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Esther Howard!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    height: 1.1,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '(Teacher)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          // Ikon notifikasi + titik kuning
          Stack(
            children: [
              Icon(
                Icons.notifications_none,
                size: 30,
                color: Colors.grey[800],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.yellow[700],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          // Foto profil bundar
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFD8CCFF),
              image: DecorationImage(
                image: NetworkImage('https://i.pravatar.cc/150?img=47'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ======== GRID MENU 2×2 ========
  Widget _buildGridMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 12, // Jarak horizontal antar-kotak
        runSpacing: 12, // Jarak vertikal antar-bar
        children: [
          _buildMenuCard(
            icon: Icons.desktop_mac_rounded,
            label: 'My Classes',
            onTap: () {},
          ),
          _buildMenuCard(
            icon: Icons.cloud_upload_rounded,
            label: 'Upload Materials',
            onTap: () {},
          ),
          _buildMenuCard(
            icon: Icons.menu_book_rounded,
            label: 'RPP & Tools',
            onTap: () {},
          ),
          _buildMenuCard(
            icon: Icons.show_chart_rounded,
            label: 'Student Performance',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // Lebar tiap kotak = (totalWidth(375) - padding kiri&kanan(16*2) - spacing antar-kotak(12)) / 2
        width: (375 - 16 * 2 - 12) / 2,
        height: 88,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFE5F1FF),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 24,
                color: const Color(0xFF3A82FF),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ======== Judul “Today’s Classes” ========
  Widget _buildTodaysClassesTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Today’s Classes',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  /// ======== DAFTAR KARTU KELAS ========
  Widget _buildClassList() {
    return Column(
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              _buildClassCard(
                className: 'XI IPA 3',
                subject: 'Mathematics',
                date: 'Thu, 8 May 2025',
                time: '07:15 - 08:30',
                studentCount: 28,
              ),
              const SizedBox(height: 12),
              _buildClassCard(
                className: 'XII IPA 1',
                subject: 'Mathematics',
                date: 'Thu, 8 May 2025',
                time: '08:45 - 10:10',
                studentCount: 31,
              ),
              const SizedBox(height: 12),
              _buildClassCard(
                className: 'XII IPA 5',
                subject: 'Mathematics',
                date: 'Thu, 8 May 2025',
                time: '11:15 - 12:30',
                studentCount: 30,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildClassCard({
    required String className,
    required String subject,
    required String date,
    required String time,
    required int studentCount,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // ===== KARTU UTAMA =====
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Baris 1: nama kelas + ikon tiga titik
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    className,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const Icon(
                    Icons.more_vert_rounded,
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              // Teks mata pelajaran
              Text(
                subject,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 12),
              // Bar info (tanggal, waktu, jumlah siswa)
              Container(
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5F9F7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: Color(0xFF12B38C),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF12B38C),
                      ),
                    ),
                    const VerticalDivider(
                      width: 24,
                      thickness: 1,
                      color: Color(0xFF12B38C),
                      indent: 6,
                      endIndent: 6,
                    ),
                    const Icon(
                      Icons.access_time,
                      size: 16,
                      color: Color(0xFF12B38C),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF12B38C),
                      ),
                    ),
                    const VerticalDivider(
                      width: 24,
                      thickness: 1,
                      color: Color(0xFF12B38C),
                      indent: 6,
                      endIndent: 6,
                    ),
                    const Icon(
                      Icons.person_outline,
                      size: 16,
                      color: Color(0xFF12B38C),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$studentCount Students',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF12B38C),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // ===== LINGKARAN DEKORATIF =====
        Positioned(
          right: -32,
          bottom: -32,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFF12B38C).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  /// ======== BOTTOM NAVIGATION BAR ========
  Widget _buildBottomNav() {
    return BottomAppBar(
      elevation: 8,
      color: Colors.white,
      child: SizedBox(
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(icon: Icons.home_filled, isActive: true),
            _buildNavItem(icon: Icons.menu_book_outlined, isActive: false),
            _buildNavItem(icon: Icons.format_list_bulleted, isActive: false),
            _buildNavItem(icon: Icons.chat_bubble_outline, isActive: false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required bool isActive}) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        icon,
        size: 28,
        color: isActive ? const Color(0xFF12B38C) : Colors.grey[400],
      ),
    );
  }
}
