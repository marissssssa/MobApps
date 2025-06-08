// lib/screens/guru/discussion_page.dart
import 'package:flutter/material.dart';

class DiscussionPage extends StatelessWidget {
  const DiscussionPage({super.key});

  static const String routeName = '/discussion';

  // Data dummy untuk daftar diskusi
  final List<Map<String, String>> discussionData = const [
    {
      'name': 'Alya Amira',
      'message': 'Halo semua, saya sedang mengajar kelas 11 yang terdiri dari siswa reguler dan beberapa siswa dengan disleksia. Saya ingin tahu, strategi atau pendekatan apa yang efektif untuk membantu siswa disleksia memahami materi pelajaran, terutama yang berbasis teks? Apakah ada aplikasi atau teknik khusus yang bisa saya terapkan di kelas? Terima kasih sebelumnya.',
      'replies': '12 replies',
      'time': '5 minutes',
      'avatarUrl': 'https://i.pravatar.cc/150?img=1',
    },
    {
      'name': 'Putra Andre',
      'message': 'Halo, saya sedang mengajar kelas 11 yang terdiri dari siswa reguler dan beberapa siswa dengan disleksia. Saya ingin tahu, strategi atau pendekatan apa yang efektif untuk membantu siswa disleksia memahami materi pelajaran, terutama yang berbasis teks? Apakah ada aplikasi atau teknik khusus yang bisa saya terapkan di kelas? Terima kasih sebelumnya.',
      'replies': '10 replies',
      'time': '15 minutes',
      'avatarUrl': 'https://i.pravatar.cc/150?img=3',
    },
    {
      'name': 'Bagus Putra',
      'message': 'Halo, saya sedang mengajar kelas 11 yang terdiri dari siswa reguler dan beberapa siswa dengan disleksia. Saya ingin tahu, strategi atau pendekatan apa yang efektif untuk membantu siswa disleksia memahami materi pelajaran, terutama yang berbasis teks? Apakah ada aplikasi atau teknik khusus yang bisa saya terapkan di kelas? Terima kasih sebelumnya.',
      'replies': '10 replies',
      'time': '15 minutes',
      'avatarUrl': 'https://i.pravatar.cc/150?img=5',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: _buildAppBar(),
      body: _buildDiscussionList(),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  /// AppBar Kustom
  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: AppBar(
        automaticallyImplyLeading: false, 
        backgroundColor: const Color(0xFF68A5A2),
        elevation: 0,
        flexibleSpace: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'DISCUSSION',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  height: 3,
                  width: 40,
                  color: Colors.white.withOpacity(0.8),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Daftar Kartu Diskusi
  Widget _buildDiscussionList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: discussionData.length,
      itemBuilder: (context, index) {
        final discussion = discussionData[index];
        return _buildDiscussionCard(
          name: discussion['name']!,
          message: discussion['message']!,
          replies: discussion['replies']!,
          time: discussion['time']!,
          avatarUrl: discussion['avatarUrl']!,
        );
      },
    );
  }

  /// Widget untuk satu kartu diskusi
  Widget _buildDiscussionCard({
    required String name,
    required String message,
    required String replies,
    required String time,
    required String avatarUrl,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shadowColor: Colors.grey.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Avatar dan Nama
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
                const SizedBox(width: 12),
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Isi Pesan
            Text(
              message,
              style: TextStyle(color: Colors.grey[700], height: 1.5),
            ),
            const SizedBox(height: 12),
            // Footer: Replies dan Waktu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.chat_bubble_outline, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(replies, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(time, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Bottom Navigation Bar Kustom
  Widget _buildBottomNav(BuildContext context) {
    return BottomAppBar(
      elevation: 10,
      color: Colors.white,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(context: context, icon: Icons.home_rounded, isActive: false, routeName: '/'), // Arahkan ke rute home
            _buildNavItem(context: context, icon: Icons.menu_book_rounded, isActive: false),
            _buildNavItem(context: context, icon: Icons.format_list_bulleted_rounded, isActive: false),
            _buildNavItem(context: context, icon: Icons.chat_rounded, isActive: true, routeName: routeName), // Ikon aktif untuk halaman diskusi
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
  }) {
    return IconButton(
      onPressed: () {
        if (routeName != null && !isActive) {
          // Hanya navigasi jika item tidak sedang aktif
          Navigator.pushReplacementNamed(context, routeName); 
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