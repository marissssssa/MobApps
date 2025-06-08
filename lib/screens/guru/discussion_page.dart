// lib/screens/guru/discussion_page.dart
import 'package:flutter/material.dart';

class DiscussionPage extends StatelessWidget {
  const DiscussionPage({super.key});

  static const String routeName = '/discussion';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Discussion"),
        backgroundColor: Colors.teal[200],
      ),
      body: const Center(child: Text("Kolom diskusi dengan orang tua.")),
    );
  }
}
