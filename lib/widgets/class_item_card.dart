// lib/widgets/class_item_card.dart
import 'package:flutter/material.dart';

class ClassItemCard extends StatelessWidget {
  final String className;
  final String subject;
  final String time;
  final double progress;
  final int students;

  const ClassItemCard({
    super.key,
    required this.className,
    required this.subject,
    required this.time,
    required this.progress,
    required this.students,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              className,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(subject, style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(time, style: TextStyle(color: Colors.grey[600])),
                const Spacer(),
                Icon(Icons.people, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  "$students Students",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
