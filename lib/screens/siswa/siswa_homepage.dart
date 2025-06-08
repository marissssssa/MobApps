import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'tugas_page.dart';
=======
// import 'materi_page.dart'; // Tidak perlu diimpor di sini
// import 'tugas_page.dart'; // Tidak perlu diimpor di sini
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48

class SiswaHomepage extends StatelessWidget {
  final void Function(String subject) onSubjectSelected;
  final void Function(String title) onHomeworkSelected; // Callback baru
  final List<Map<String, dynamic>> allLatihan; // Data latihan dari MainDashboardPage

  const SiswaHomepage({
    super.key,
    required this.onSubjectSelected,
    required this.onHomeworkSelected,
    required this.allLatihan, // Tambahkan ini
  });

  @override
  Widget build(BuildContext context) {
    // Filter latihan yang akan ditampilkan sebagai homework di homepage
    // Contoh: Asumsikan 'Algebra II' dan 'World History' adalah latihan pertama
    final List<Map<String, dynamic>> homeworkItems = allLatihan.where((item) =>
      item['title'] == 'Algebra II' || item['title'] == 'World History'
    ).toList();


    return Container(
      color: Colors.grey[100],
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            // --- Header ---
            _buildHeader("Skeeter Davis"),
            const SizedBox(height: 24),

            // --- Search Bar ---
            _buildSearchBar(),
            const SizedBox(height: 24),

            // --- Materials Section ---
            const Text(
              "Materials",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildMaterialsGrid(context),
            const SizedBox(height: 24),

            // --- Homework Section ---
            const Text(
              "Homework",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Tampilkan homework dari data yang diteruskan
            ...homeworkItems.map((item) {
              return _buildHomeworkItem(context, item['title'], item['deadline']);
            }).toList(),
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
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5'),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildMaterialsGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 2.5, // Mengatur rasio lebar:tinggi kartu
      children: [
        _buildMaterialCard(
<<<<<<< HEAD
            context, Icons.calculate, "Mathematics", Colors.orange),
        _buildMaterialCard(context, Icons.biotech, "Biology", Colors.green),
        _buildMaterialCard(context, Icons.science, "Chemistry", Colors.blue),
        _buildMaterialCard(
            context, Icons.rocket_launch, "Physics", Colors.purple),
=======
          context,
          Icons.calculate,
          "Mathematics",
          Colors.orange,
        ),
        _buildMaterialCard(context, Icons.biotech, "Biology", Colors.green),
        _buildMaterialCard(context, Icons.science, "Chemistry", Colors.blue),
        _buildMaterialCard(
          context,
          Icons.rocket_launch,
          "Physics",
          Colors.purple,
        ),
>>>>>>> 90ee457fe2d022664d411e9c86275447042a211a
        _buildMaterialCard(context, Icons.history_edu, "History", Colors.red),
        _buildMaterialCard(context, Icons.flag, "Citizenship", Colors.teal),
      ],
    );
  }

  Widget _buildMaterialCard(
<<<<<<< HEAD
      BuildContext context, IconData icon, String title, Color color) {
=======
    BuildContext context,
    IconData icon,
    String title,
    Color color,
  ) {
>>>>>>> 90ee457fe2d022664d411e9c86275447042a211a
    return GestureDetector(
      onTap: () {
        onSubjectSelected(title);
      },
      child: Card(
<<<<<<< HEAD
        color: color.withAlpha((255 * 0.1).round()),
=======
        color: color.withOpacity(0.1),
>>>>>>> 90ee457fe2d022664d411e9c86275447042a211a
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
        child: Center(
          child: ListTile(
            leading: Icon(icon, color: color),
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHomeworkItem(BuildContext context, String title, String date) {
    return GestureDetector(
      onTap: () {
        // Memanggil callback yang diteruskan dari MainDashboardPage
        onHomeworkSelected(title);
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: const Icon(Icons.assignment, color: Colors.blueAccent),
<<<<<<< HEAD
          title:
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
=======
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
>>>>>>> 90ee457fe2d022664d411e9c86275447042a211a
          subtitle: Text(date),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
      ),
    );
  }
}