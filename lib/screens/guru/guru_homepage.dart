// lib/screens/guru/guru_homepage.dart

import 'package:flutter/material.dart';
import 'package:educonnect/models/class_model.dart';
import 'package:educonnect/widgets/class_item_card.dart';

class GuruHomepage extends StatelessWidget {
  const GuruHomepage({super.key});
  static const List<ClassModel> todayClasses = [
    ClassModel(
      className: "XI IPA 3",
      subject: "Mathematics",
      time: "07:00 - 09:30",
      progress: 0.7,
      totalStudents: 30,
    ),
    ClassModel(
      className: "XII IPA 1",
      subject: "Mathematics",
      time: "10:00 - 12:00",
      progress: 0.4,
      totalStudents: 25,
    ),
    ClassModel(
      className: "XII IPA 5",
      subject: "Mathematics",
      time: "13:00 - 15:00",
      progress: 0.9,
      totalStudents: 32,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            // --- Header ---
            _buildHeader("Esther Howard"),
            const SizedBox(height: 30),

            // --- Menu Utama ---
            _buildMainMenu(),
            const SizedBox(height: 30),

            // --- Today's Classes ---
            const Text(
              "Today's Classes",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Column(
              children: todayClasses.map((classData) {
                return ClassItemCard(
                  className: classData.className,
                  subject: classData.subject,
                  time: classData.time,
                  progress: classData.progress,
                  students: classData.totalStudents,
                );
              }).toList(),
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
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=1'),
        ),
      ],
    );
  }

  Widget _buildMainMenu() {
    return Row(
      children: [
        Expanded(child: _buildMenuCard(Icons.class_, "My Classes")),
        const SizedBox(width: 16),
        Expanded(child: _buildMenuCard(Icons.upload_file, "Upload Materials")),
      ],
    );
  }

  Widget _buildMenuCard(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          const BoxShadow(
            color: Color.fromARGB(255, 117, 117, 117),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 40, color: Colors.blue),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
