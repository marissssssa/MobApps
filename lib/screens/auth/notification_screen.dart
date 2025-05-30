import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool taskNotification = true;
  bool announcementNotification = false;
  bool reminderNotification = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.notifications, color: Colors.black),
            SizedBox(width: 8),
            Text('Notifikasi', style: TextStyle(color: Colors.black)),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Positioned(
            top: -40,
            left: -50,
            child: Opacity(
              opacity: 0.7,
              child: Icon(
                Icons.notifications_active,
                size: 400,
                color: const Color(0x3384BDC2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildToggleTile(
                  icon: Icons.assignment,
                  title: 'Tugas Baru',
                  value: taskNotification,
                  onChanged: (val) => setState(() => taskNotification = val),
                ),
                _buildToggleTile(
                  icon: Icons.campaign,
                  title: 'Pengumuman',
                  value: announcementNotification,
                  onChanged: (val) => setState(() => announcementNotification = val),
                ),
                _buildToggleTile(
                  icon: Icons.alarm,
                  title: 'Pengingat Jadwal',
                  value: reminderNotification,
                  onChanged: (val) => setState(() => reminderNotification = val),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.black54),
        title: Text(title),
        trailing: Transform.scale(
          scale: 0.75,
          child: Switch(
            value: value,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
