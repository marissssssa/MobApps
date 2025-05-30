import 'package:flutter/material.dart';

class OrangTuaHomepage extends StatelessWidget {
  const OrangTuaHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            // --- Header ---
            _buildHeader("Frank Sinatra"),
            const SizedBox(height: 30),

            // --- Dashboard Section ---
            const Text(
              "Dashboard",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildProgressCard(
              "Davis's Progress",
              "View weekly learning progress",
            ),
            const SizedBox(height: 16),
            _buildDashboardCard(
              Icons.forum,
              "Forum",
              "Join discussion and connect",
            ),
            const SizedBox(height: 16),
            _buildDashboardCard(
              Icons.event,
              "Upcoming",
              "Parent-Teacher meeting",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello,",
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
        ),
      ],
    );
  }

  Widget _buildProgressCard(String title, String subtitle) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Placeholder untuk gambar ilustrasi
            Image.network(
              'https://via.placeholder.com/80',
              width: 80,
              height: 80,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(subtitle, style: TextStyle(color: Colors.grey[600])),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("View details"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(IconData icon, String title, String subtitle) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(icon, size: 40, color: Colors.blueAccent),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
