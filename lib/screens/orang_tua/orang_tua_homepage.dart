import 'package:flutter/material.dart';

class OrangTuaHomepage extends StatelessWidget {
  const OrangTuaHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      // Membatasi lebar agar terlihat seperti layar HP (maksimum 400px)
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Scaffold(
          backgroundColor: Colors.grey[100],
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // === HEADER ===
                  _buildHeader(),
                  const SizedBox(height: 30),

                  // === SECTION TITLE “Dashboard” ===
                  const Text(
                    "Dashboard",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // === CARD: Davis’s Progress (menggunakan Image.asset) ===
                  _buildProgressCard(
                    title: "Davis’s Progress",
                    subtitle: "View weekly learning progress",
                  ),
                  const SizedBox(height: 16),

                  // === CARD: Forum ===
                  _buildDashboardCard(
                    icon: Icons.forum_outlined,
                    title: "Forum",
                    subtitle: "Join discussions and connect",
                  ),
                  const SizedBox(height: 16),

                  // === CARD: Upcoming ===
                  _buildDashboardCard(
                    icon: Icons.calendar_today_outlined,
                    title: "Upcoming",
                    subtitle: "Parent - Teacher meeting\nFri, May 24 – 1:00pm",
                  ),

                  // Spacer agar BottomNavigationBar tidak menutupi konten
                  const Spacer(),
                ],
              ),
            ),
          ),

          // === BOTTOM NAVIGATION BAR ===
          bottomNavigationBar: _buildBottomNavBar(),
        ),
      ),
    );
  }

  /// HEADER: “Hello, Frank Sinatra!” + “(Parent)” + Bell icon + Avatar
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Kolom untuk teks “Hello,”, nama lengkap, dan role “(Parent)”
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello,",
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            const Text(
              "Frank Sinatra!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Text(
              "(Parent)",
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),

        // Container melengkung berisi ikon bell dan avatar profil
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.notifications_none,
                size: 24,
                color: Colors.black87,
              ),
              const SizedBox(width: 12),
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/150?img=12',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// CARD BESAR untuk “Davis’s Progress” menggunakan Image.asset
  Widget _buildProgressCard({required String title, required String subtitle}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Ganti Image.network dengan Image.asset dari assets/images
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/progress_icon.png',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),

            // Judul, deskripsi, dan tombol “View details”
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
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 12),

                  // Tombol “View details” dengan teks putih
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Navigasi ke detail progress
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7FA9B8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "View details",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white, // Teks putih
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// CARD STANDAR untuk “Forum” dan “Upcoming”
  Widget _buildDashboardCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kotak kecil untuk ikon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 24, color: Colors.blueAccent),
            ),
            const SizedBox(width: 16),

            // Judul dan subjudul (dapat multi-line)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            // Ikon panah navigasi di kanan
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  /// BottomNavigationBar dengan 4 ikon (Home, Book, Menu, Chat)
  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.grey[600],
      currentIndex: 0, // “Home” dipilih secara default
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 8,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.book_outlined), label: 'Book'),
        BottomNavigationBarItem(icon: Icon(Icons.menu_outlined), label: 'Menu'),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          label: 'Chat',
        ),
      ],
      onTap: (index) {
        // TODO: Tambahkan logic navigasi sesuai index
      },
    );
  }
}
