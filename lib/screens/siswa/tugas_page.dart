import 'package:flutter/material.dart';
import 'package:educonnect/l10n/app_localizations.dart';
import 'package:educonnect/l10n/l10n.dart';
import 'package:provider/provider.dart';
import 'package:educonnect/models/quiz_model.dart';
import 'package:educonnect/screens/siswa/latihan_detail_page.dart';
import 'package:educonnect/providers/theme_provider.dart';
//
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
    final l10n = AppLocalizations.of(context)!;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    Color getCompletedColor() {
      return isDarkMode
          ? const Color.fromRGBO(82, 193, 185, 1) // Dark mode color
          : const Color.fromRGBO(160, 203, 196, 1); // Light mode color
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              l10n.quizzes,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...allQuizzes.map((quiz) {
              final isCompleted = quiz.isCompleted;
              final completedColor = getCompletedColor();

              return Card(
                color: isCompleted ? completedColor : Theme.of(context).cardColor,
                child: ListTile(
                  title: Text(
                    quiz.title,
                    style: TextStyle(
                      color: isCompleted ? Colors.white : Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  subtitle: Text(
                    quiz.deadline,
                    style: TextStyle(
                      color: isCompleted ? Colors.white70 : Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                  trailing: isCompleted
                      ? const Icon(Icons.check_circle, color: Colors.white)
                      : null,
                  onTap: isCompleted
                      ? null
                      : () => openQuiz(quiz.title),
                ),
              );
            }).toList(),
            const SizedBox(height: 16),
            Text(
              l10n.exercises,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...allLatihan.map((item) {
              final isSubmitted = item['uploadedFileNames'] != null &&
                  item['uploadedFileNames'].isNotEmpty;
              final completedColor = getCompletedColor();

              return Card(
                color: isSubmitted ? completedColor : Theme.of(context).cardColor,
                child: ListTile(
                  title: Text(
                    item['title'],
                    style: TextStyle(
                      color: isSubmitted ? Colors.white : Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  subtitle: Text(
                    item['deadline'],
                    style: TextStyle(
                      color: isSubmitted ? Colors.white70 : Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                  trailing: isSubmitted
                      ? const Icon(Icons.check_circle, color: Colors.white)
                      : null,
                  onTap: () => navigateToLatihanDetail(item['title']),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}