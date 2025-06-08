import 'package:flutter/material.dart';
import 'package:educonnect/screens/guru/guru_homepage.dart';
import 'package:educonnect/screens/shared/discussion_page.dart'; 

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    // Mendeteksi rute yang sedang aktif untuk menyorot ikon yang benar
    final String? currentRoute = ModalRoute.of(context)?.settings.name;

    return BottomAppBar(
      elevation: 10,
      color: Colors.white,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              context: context,
              icon: Icons.home_rounded,
              isActive: currentRoute == GuruHomepage.routeName || currentRoute == '/',
              routeName: GuruHomepage.routeName,
            ),
            _buildNavItem(
              context: context,
              icon: Icons.menu_book_rounded,
              isActive: false, 
              placeholderLabel: "Materi (Soon)",
            ),
            _buildNavItem(
              context: context,
              icon: Icons.format_list_bulleted_rounded,
              isActive: false, 
              placeholderLabel: "Tugas (Soon)",
            ),
            _buildNavItem(
              context: context,
              icon: Icons.chat_rounded,
              isActive: currentRoute == DiscussionPage.routeName,
              routeName: DiscussionPage.routeName,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required bool isActive,
    String? routeName,
    String? placeholderLabel,
  }) {
    return IconButton(
      onPressed: () {
        if (routeName != null) {
          // Hanya navigasi jika item tidak sedang aktif
          if (!isActive) {
            // Gunakan pushReplacementNamed agar tidak menumpuk halaman di stack navigasi
            Navigator.pushReplacementNamed(context, routeName);
          }
        } else if (placeholderLabel != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(placeholderLabel)),
          );
        }
      },
      icon: Icon(
        icon,
        size: 28,
        color: isActive ? const Color(0xFF68A5A2) : Colors.grey[400],
      ),
    );
  }
}