import 'package:flutter/material.dart';
import 'package:educonnect/l10n/app_localizations.dart';
import 'package:educonnect/l10n/l10n.dart';
import 'package:provider/provider.dart';
import 'package:educonnect/models/quiz_model.dart';
import 'package:educonnect/screens/siswa/kuis_attempt_page.dart.dart';
import 'package:educonnect/providers/theme_provider.dart';

class QuizDetailPage extends StatelessWidget {
  final Quiz quiz;
  final Function(Quiz) onQuizStarted;
  final Function(String, Duration, List<QuizQuestion>) onQuizCompleted;
  final Function(Quiz, Duration, List<QuizQuestion>) onQuizPaused;

  const QuizDetailPage({
    super.key,
    required this.quiz,
    required this.onQuizStarted,
    required this.onQuizCompleted,
    required this.onQuizPaused,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final l10n = AppLocalizations.of(context)!;
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          quiz.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quiz.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${l10n.duration}: ${quiz.durationMinutes} ${l10n.minutes}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (!quiz.isCompleted && quiz.remainingTime.inSeconds < quiz.durationMinutes * 60)
                      Text(
                        '${l10n.remainingTime}: ${quiz.remainingTime.inMinutes} ${l10n.minutes} ${quiz.remainingTime.inSeconds % 60} ${l10n.seconds}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                final now = DateTime.now();
                final updatedQuiz = quiz.copyWith(
                  startTime: quiz.startTime ?? now,
                );

                onQuizStarted(updatedQuiz);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizAttemptPage(
                      quiz: updatedQuiz,
                      onQuizCompleted: onQuizCompleted,
                      onQuizPaused: onQuizPaused,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode
                    ? const Color.fromRGBO(82, 193, 185, 1) // Warna untuk dark mode
                    : const Color.fromRGBO(160, 203, 196, 1), // Warna untuk light mode
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                quiz.startTime != null && !quiz.isCompleted
                    ? l10n.continueQuiz
                    : l10n.startQuiz,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}