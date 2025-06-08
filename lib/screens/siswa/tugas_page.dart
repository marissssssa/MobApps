import 'package:flutter/material.dart';
import 'package:educonnect/models/quiz_model.dart';
import 'package:educonnect/screens/siswa/latihan_detail_page.dart';

class TugasPage extends StatelessWidget {
  final List<Map<String, dynamic>> allLatihan;
  final void Function(String title) navigateToLatihanDetail;
  final List<Quiz> allQuizzes;
  final void Function(String title) openQuiz;

  const TugasPage({
    super.key,
    required this.allLatihan,
    required this.navigateToLatihanDetail,
    required this.allQuizzes,
    required this.openQuiz,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text('Kuis', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...allQuizzes.map((quiz) {
              return Card(
                color: quiz.isCompleted ? const Color.fromRGBO(160, 203, 196, 1) : null,
                child: ListTile(
                  title: Text(
                    quiz.title,
                    style: TextStyle(
                      color: quiz.isCompleted ? Colors.white : Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    quiz.deadline,
                    style: TextStyle(
                      color: quiz.isCompleted ? Colors.white70 : Colors.grey,
                    ),
                  ),
                  onTap: quiz.isCompleted
                      ? null
                      : () {
                          openQuiz(quiz.title);
                        },
                ),
              );
            }).toList(),
            const SizedBox(height: 16),
            const Text('Latihan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...allLatihan.map((item) {
              return Card(
                color: (item['uploadedFileNames'] != null && item['uploadedFileNames'].isNotEmpty)
                    ? const Color.fromRGBO(160, 203, 196, 1)
                    : null,
                child: ListTile(
                  title: Text(
                    item['title'],
                    style: TextStyle(
                        color: (item['uploadedFileNames'] != null && item['uploadedFileNames'].isNotEmpty)
                            ? Colors.white
                            : Colors.black),
                  ),
                  subtitle: Text(
                    item['deadline'],
                    style: TextStyle(
                        color: (item['uploadedFileNames'] != null && item['uploadedFileNames'].isNotEmpty)
                            ? Colors.white70
                            : Colors.grey),
                  ),
                  onTap: () {
                    navigateToLatihanDetail(item['title']);
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}