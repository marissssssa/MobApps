import 'package:flutter/material.dart';

class ProfileGuruScreen extends StatelessWidget {
  const ProfileGuruScreen({Key? key}) : super(key: key);

  // Ganti dengan path ke asset lokal atau NetworkImage mu
  final String _avatarImage = 'assets/images/profile.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // ───── AppBar ─────
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      // ───── Body ─────
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 32),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(_avatarImage),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Esther Howard',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  'estherhoward199@gmail.com',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // TODO: implement edit profile
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7FBEC2),
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          // Menu list
          Expanded(
            child: ListView(
              children: [
                _buildTile(
                  icon: Icons.person,
                  title: 'Role',
                  subtitle: 'Teacher',
                ),
                _buildTile(
                  icon: Icons.school,
                  title: 'Institution',
                  subtitle: 'Public High School',
                ),
                _buildTile(icon: Icons.language, title: 'Language'),
                _buildTile(
                  icon: Icons.notifications,
                  title: 'Notification settings',
                ),
                _buildTile(
                  icon: Icons.brush,
                  title: 'Theme',
                  subtitle: 'Light',
                ),
                _buildTile(
                  icon: Icons.file_download,
                  title: 'Download materials',
                ),
                _buildTile(icon: Icons.delete, title: 'Clear cache'),
                // Logout
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    'Log out',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    // TODO: implement logout
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      // ───── Bottom Nav ─────
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF7FBEC2),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        ],
        onTap: (index) {
          // TODO: handle navigation
        },
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    String? subtitle,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black54),
          title: Text(title, style: const TextStyle(fontSize: 16)),
          subtitle: subtitle != null ? Text(subtitle) : null,
          onTap: () {
            // TODO: handle tap
          },
        ),
        const Divider(height: 1),
      ],
    );
  }
}
