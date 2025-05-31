import 'package:flutter/material.dart';
import 'materi_page.dart';
import 'tugas_page.dart';

class SiswaHomepage extends StatelessWidget {
  const SiswaHomepage({super.key});

  @override
  Widget build(BuildContext context) {
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
            _buildHomeworkItem(context, "Algebra II", "20 Apr - 14 May"),
            _buildHomeworkItem(context, "World History", "20 Apr - 14 May"),
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
      _buildMaterialCard(context, Icons.calculate, "Mathematics", Colors.orange),
      _buildMaterialCard(context, Icons.biotech, "Biology", Colors.green),
      _buildMaterialCard(context, Icons.science, "Chemistry", Colors.blue),
      _buildMaterialCard(context, Icons.rocket_launch, "Physics", Colors.purple),
      _buildMaterialCard(context, Icons.history_edu, "History", Colors.red),
      _buildMaterialCard(context, Icons.flag, "Citizenship", Colors.teal),
    ],
  );
}

Widget _buildMaterialCard(BuildContext context, IconData icon, String title, Color color) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MateriPage()),
      );
    },
    child: Card(
      color: color.withOpacity(0.1),
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TugasPage()),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: const Icon(Icons.assignment, color: Colors.blueAccent),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(date),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
      ),
    );
  }
}
