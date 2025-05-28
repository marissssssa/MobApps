import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSettingsTile(
              icon: Icons.person_outline,
              title: 'Profil Saya',
              onTap: () {
                // 
              },
            ),
            _buildLanguageDropdown(),
            _buildSettingsTile(
              icon: Icons.accessibility_new,
              title: 'Mode Aksesibilitas',
              onTap: () {
                //
              },
            ),
            _buildSettingsTile(
              icon: Icons.notifications_none,
              title: 'Notifikasi',
              onTap: () {
                //
              },
            ),
            _buildSettingsTile(
              icon: Icons.logout,
              title: 'Logout',
              onTap: () {
                //
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.black54),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.language, color: Colors.black54),
        title: const Text('Bahasa'),
        trailing: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: 'Indonesia',
            items: const [
              DropdownMenuItem(value: 'Indonesia', child: Text('Indonesia')),
              DropdownMenuItem(value: 'English', child: Text('English')),
            ],
            onChanged: (value) {
              //
            },
          ),
        ),
      ),
    );
  }
}
