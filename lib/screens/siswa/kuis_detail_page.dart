import 'package:flutter/material.dart';
import 'package:educonnect/models/quiz_model.dart';
import 'package:educonnect/screens/siswa/kuis_attempt_page.dart.dart';

class QuizDetailPage extends StatelessWidget {
  final Quiz quiz;
  final Function(Quiz) onQuizStarted; // Callback saat kuis dimulai
  final Function(String, Duration, List<QuizQuestion>) onQuizCompleted; // Callback saat kuis selesai
  final Function(Quiz, Duration, List<QuizQuestion>) onQuizPaused; // Callback saat kuis di-pause

  const QuizDetailPage({
    super.key,
    required this.quiz,
    required this.onQuizStarted,
    required this.onQuizCompleted,
    required this.onQuizPaused,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(quiz.title, style: const TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quiz.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Durasi: ${quiz.durationMinutes} Menit',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    // Tampilkan sisa waktu jika kuis belum selesai
                    if (!quiz.isCompleted && quiz.remainingTime.inSeconds < quiz.durationMinutes * 60)
                      Text(
                        'Sisa Waktu: ${quiz.remainingTime.inMinutes} menit ${quiz.remainingTime.inSeconds % 60} detik',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Saat tombol mulai ditekan
                DateTime now = DateTime.now();
                Quiz updatedQuiz = quiz.copyWith(
                  startTime: quiz.startTime ?? now, // Set startTime hanya jika belum diset
                  // remainingTime tidak perlu direset di sini, karena QuizAttemptPage yang akan mengelolanya
                );

                onQuizStarted(updatedQuiz); // Panggil callback untuk memperbarui state di MainDashboardPage

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizAttemptPage(
                      quiz: updatedQuiz,
                      onQuizCompleted: onQuizCompleted,
                      onQuizPaused: onQuizPaused, // Teruskan callback onQuizPaused
                    ),
                  ),
                ).then((_) {
                  // Ketika kembali dari QuizAttemptPage, refresh state jika diperlukan
                  // Ini akan memicu build() lagi dan memperbarui tampilan sisa waktu
                  // jika pengguna kembali dari QuizAttemptPage tanpa menyelesaikannya.
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(160, 203, 196, 1),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                quiz.startTime != null && !quiz.isCompleted ? 'Lanjutkan' : 'Mulai', // Ubah teks tombol
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}