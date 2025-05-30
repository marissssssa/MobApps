import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Menggunakan Scaffold untuk struktur halaman dasar (AppBar, Body, dll.)
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        // Pengaturan AppBar agar terlihat bersih seperti di desain
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      // 2. Menggunakan ListView agar konten bisa di-scroll jika tidak muat di layar kecil
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          // --- BAGIAN PROFIL ATAS ---
          Column(
            children: [
              // 3. Menggunakan CircleAvatar untuk foto profil bulat sempurna
              const CircleAvatar(
                radius: 50,
                // Di aplikasi nyata, URL ini akan datang dari data pengguna
                backgroundImage: NetworkImage(
                  "https://i.pravatar.cc/150?img=12",
                ), // Placeholder image
              ),
              const SizedBox(height: 16),
              const Text(
                "Frank Sinatra", // Diambil dari desain
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                "franksinatra72@gmail.com",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),
              // 4. Menggunakan ElevatedButton untuk tombol yang benar
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF52C1B9), // Warna dari Figma
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  "Edit Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),
          const Divider(),

          // --- BAGIAN DAFTAR MENU ---
          // 5. Menggunakan ListTile untuk setiap item menu agar rapi dan konsisten
          _buildProfileMenuItem(
            icon: Icons.person_outline,
            title: "Role",
            subtitle: "Parent",
          ),
          _buildProfileMenuItem(
            icon: Icons.school_outlined,
            title: "Institution",
            subtitle: "Public High School",
          ),
          _buildProfileMenuItem(
            icon: Icons.language_outlined,
            title: "Language",
          ),
          _buildProfileMenuItem(
            icon: Icons.notifications_outlined,
            title: "Notification settings",
          ),
          _buildProfileMenuItem(
            icon: Icons.color_lens_outlined,
            title: "Theme",
            subtitle: "Light",
          ),
          _buildProfileMenuItem(
            icon: Icons.download_for_offline_outlined,
            title: "Download materials",
          ),
          _buildProfileMenuItem(
            icon: Icons.delete_sweep_outlined,
            title: "Clear Cache",
          ),
          const Divider(),
          _buildProfileMenuItem(
            icon: Icons.logout,
            title: "Log out",
            textColor: Colors.red,
            isLogout: true,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileMenuItem({
    required IconData icon,
    required String title,
    String? subtitle,
    Color textColor = Colors.black,
    bool isLogout = false,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: textColor),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w500, color: textColor),
      ),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: isLogout ? null : const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}
