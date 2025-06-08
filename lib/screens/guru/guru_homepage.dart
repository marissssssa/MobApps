// lib/screens/guru/guru_homepage.dart
import 'package:flutter/material.dart';
<<<<<<< HEAD
import './discussion_page.dart'; 
import './my_classes_page.dart'; 
=======
import './discussion_page.dart';
import './my_classes_page.dart';
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48

class GuruHomepage extends StatelessWidget {
  const GuruHomepage({super.key});
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = 375;
          // Cek jika maxWidth dari constraints lebih kecil dari yang kita set
          // Atau jika lebar dari MediaQuery lebih kecil (untuk layar yang sangat sempit)
          final screenWidth = MediaQuery.of(context).size.width;
          if (constraints.maxWidth < maxWidth || screenWidth < maxWidth) {
<<<<<<< HEAD
            maxWidth = (constraints.maxWidth < screenWidth) ? constraints.maxWidth : screenWidth;
=======
            maxWidth = (constraints.maxWidth < screenWidth)
                ? constraints.maxWidth
                : screenWidth;
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
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
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4),
<<<<<<< HEAD
                Text('Hello,', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black87)),
                SizedBox(height: 4),
                Text('Esther Howard!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87, height: 1.1)),
                SizedBox(height: 2),
                Text('(Teacher)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.grey)),
=======
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
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
              ],
            ),
          ),
          Stack(
            children: [
              Icon(Icons.notifications_none, size: 30, color: Colors.grey[800]),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 8,
                  height: 8,
<<<<<<< HEAD
                  decoration: BoxDecoration(color: Colors.yellow[700], shape: BoxShape.circle),
=======
                  decoration: BoxDecoration(
                    color: Colors.yellow[700],
                    shape: BoxShape.circle,
                  ),
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFD8CCFF),
<<<<<<< HEAD
              image: DecorationImage(image: NetworkImage('https://i.pravatar.cc/150?img=47'), fit: BoxFit.cover),
=======
              image: DecorationImage(
                image: NetworkImage('https://i.pravatar.cc/150?img=47'),
                fit: BoxFit.cover,
              ),
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
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
<<<<<<< HEAD
        spacing: 12, 
        runSpacing: 12, 
        children: [
          _buildMenuCard(
            context: context, 
            icon: Icons.desktop_mac_rounded,
            label: 'My Classes',
            onTap: () {
               Navigator.pushNamed(context, MyClassesPage.routeName);
=======
        spacing: 12,
        runSpacing: 12,
        children: [
          _buildMenuCard(
            context: context,
            icon: Icons.desktop_mac_rounded,
            label: 'My Classes',
            onTap: () {
              Navigator.pushNamed(context, MyClassesPage.routeName);
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
            },
          ),
          _buildMenuCard(
            context: context,
            icon: Icons.cloud_upload_rounded,
            label: 'Upload Materials',
            onTap: () {
<<<<<<< HEAD
                ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Halaman Upload Materials Belum Ada')),
=======
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Halaman Upload Materials Belum Ada'),
                ),
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
              );
            },
          ),
          _buildMenuCard(
<<<<<<< HEAD
            context: context, 
            icon: Icons.menu_book_rounded,
            label: 'RPP & Tools',
            onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
=======
            context: context,
            icon: Icons.menu_book_rounded,
            label: 'RPP & Tools',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
                const SnackBar(content: Text('Halaman RPP & Tools Belum Ada')),
              );
            },
          ),
          _buildMenuCard(
            context: context,
            icon: Icons.show_chart_rounded,
            label: 'Student Performance',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
<<<<<<< HEAD
                const SnackBar(content: Text('Halaman Student Performance Belum Ada')),
=======
                const SnackBar(
                  content: Text('Halaman Student Performance Belum Ada'),
                ),
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({
    required BuildContext context, // Tambahkan context
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
<<<<<<< HEAD
    final screenWidthForContent = MediaQuery.of(context).size.width > 375 
                                  ? 375 
                                  : MediaQuery.of(context).size.width;
    final cardWidth = (screenWidthForContent - 16 * 2 - 12) / 2;


=======
    final screenWidthForContent = MediaQuery.of(context).size.width > 375
        ? 375
        : MediaQuery.of(context).size.width;
    final cardWidth = (screenWidthForContent - 16 * 2 - 12) / 2;

>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth, // Gunakan lebar dinamis
        height: 88,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
<<<<<<< HEAD
            )
=======
            ),
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
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
<<<<<<< HEAD
              child: Icon(
                icon,
                size: 24,
                color: const Color(0xFF3A82FF),
              ),
=======
              child: Icon(icon, size: 24, color: const Color(0xFF3A82FF)),
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
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

  Widget _buildTodaysClassesTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
<<<<<<< HEAD
      child: Text('Today’s Classes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87)),
=======
      child: Text(
        'Today’s Classes',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
    );
  }

  Widget _buildClassList() {
<<<<<<< HEAD
     return Column(
=======
    return Column(
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
<<<<<<< HEAD
              _buildClassCard(className: 'XI IPA 3', subject: 'Mathematics', date: 'Thu, 8 May 2025', time: '07:15 - 08:30', studentCount: 28),
              const SizedBox(height: 12),
              _buildClassCard(className: 'XII IPA 1', subject: 'Mathematics', date: 'Thu, 8 May 2025', time: '08:45 - 10:10', studentCount: 31),
              const SizedBox(height: 12),
              _buildClassCard(className: 'XII IPA 5', subject: 'Mathematics', date: 'Thu, 8 May 2025', time: '11:15 - 12:30', studentCount: 30),
=======
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
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
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
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
<<<<<<< HEAD
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 12, offset: const Offset(0, 6))],
=======
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
          ),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
<<<<<<< HEAD
                  Text(className, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black87)),
=======
                  Text(
                    className,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
                  const Icon(Icons.more_vert_rounded, color: Colors.grey),
                ],
              ),
              const SizedBox(height: 4),
<<<<<<< HEAD
              Text(subject, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey)),
              const SizedBox(height: 12),
              Container(
                height: 36,
                decoration: BoxDecoration(color: const Color(0xFFE5F9F7), borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    const Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xFF12B38C)),
                    const SizedBox(width: 4),
                    Text(date, style: const TextStyle(fontSize: 12, color: Color(0xFF12B38C))),
                    const VerticalDivider(width: 24, thickness: 1, color: Color(0xFF12B38C), indent: 6, endIndent: 6),
                    const Icon(Icons.access_time, size: 16, color: Color(0xFF12B38C)),
                    const SizedBox(width: 4),
                    Text(time, style: const TextStyle(fontSize: 12, color: Color(0xFF12B38C))),
                    const VerticalDivider(width: 24, thickness: 1, color: Color(0xFF12B38C), indent: 6, endIndent: 6),
                    const Icon(Icons.person_outline, size: 16, color: Color(0xFF12B38C)),
                    const SizedBox(width: 4),
                    Text('$studentCount Students', style: const TextStyle(fontSize: 12, color: Color(0xFF12B38C))),
=======
              Text(
                subject,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 12),
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
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: -32,
          bottom: -32,
          child: Container(
            width: 100,
            height: 100,
<<<<<<< HEAD
            decoration: BoxDecoration(color: const Color(0xFF12B38C).withOpacity(0.2), shape: BoxShape.circle),
=======
            decoration: BoxDecoration(
              color: const Color(0xFF12B38C).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
          ),
        ),
      ],
    );
  }

<<<<<<< HEAD
  Widget _buildBottomNav(BuildContext context) { // Tambahkan context
=======
  Widget _buildBottomNav(BuildContext context) {
    // Tambahkan context
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
    // Untuk mengetahui rute saat ini agar bisa mengatur isActive dengan benar.
    final String? currentRoute = ModalRoute.of(context)?.settings.name;

    return BottomAppBar(
      elevation: 8,
      color: Colors.white,
      child: SizedBox(
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              context: context, // Teruskan context
<<<<<<< HEAD
              icon: Icons.home_filled, 
              isActive: currentRoute == GuruHomepage.routeName || currentRoute == '/', // Cek apakah ini rute home
=======
              icon: Icons.home_filled,
              isActive:
                  currentRoute == GuruHomepage.routeName ||
                  currentRoute == '/', // Cek apakah ini rute home
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
              routeName: GuruHomepage.routeName, // Atau bisa juga '/'
            ),
            _buildNavItem(
              context: context, // Teruskan context
<<<<<<< HEAD
              icon: Icons.menu_book_outlined, 
=======
              icon: Icons.menu_book_outlined,
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
              isActive: false, // Ganti jika halaman RPP sudah ada
              placeholderLabel: 'RPP (Soon)',
            ),
            _buildNavItem(
              context: context, // Teruskan context
<<<<<<< HEAD
              icon: Icons.format_list_bulleted, 
=======
              icon: Icons.format_list_bulleted,
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
              isActive: false, // Ganti jika halaman Tugas sudah ada
              placeholderLabel: 'Tugas (Soon)',
            ),
            _buildNavItem(
              context: context, // Teruskan context
<<<<<<< HEAD
              icon: Icons.chat_bubble_outline, 
              isActive: currentRoute == DiscussionPage.routeName, // Cek apakah ini rute diskusi
              routeName: DiscussionPage.routeName, // Navigasi ke Halaman Diskusi
=======
              icon: Icons.chat_bubble_outline,
              isActive:
                  currentRoute ==
                  DiscussionPage.routeName, // Cek apakah ini rute diskusi
              routeName:
                  DiscussionPage.routeName, // Navigasi ke Halaman Diskusi
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context, // Tambahkan context
<<<<<<< HEAD
    required IconData icon, 
=======
    required IconData icon,
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
    required bool isActive,
    String? routeName, // Nama rute untuk navigasi
    String? placeholderLabel, // Teks untuk item yang belum berfungsi
  }) {
    return IconButton(
      onPressed: () {
        if (routeName != null) {
          if (ModalRoute.of(context)?.settings.name != routeName) {
<<<<<<< HEAD
             Navigator.pushNamed(context, routeName);
          }
        } else if (placeholderLabel != null) {
          // Tampilkan pesan jika halaman belum ada
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(placeholderLabel)),
          );
=======
            Navigator.pushNamed(context, routeName);
          }
        } else if (placeholderLabel != null) {
          // Tampilkan pesan jika halaman belum ada
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(placeholderLabel)));
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
        }
      },
      icon: Icon(
        icon,
        size: 28,
        color: isActive ? const Color(0xFF12B38C) : Colors.grey[400],
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
