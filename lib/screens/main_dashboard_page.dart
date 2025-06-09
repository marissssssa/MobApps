import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:educonnect/l10n/app_localizations.dart';
import 'package:educonnect/l10n/l10n.dart';
import 'package:educonnect/providers/theme_provider.dart';
import 'package:educonnect/providers/locale_provider.dart';
import 'package:educonnect/screens/guru/guru_homepage.dart';
import 'package:educonnect/screens/siswa/siswa_homepage.dart';
import 'package:educonnect/screens/orang_tua/orang_tua_homepage.dart';
import 'package:educonnect/screens/profile/profile_page.dart';
import 'package:educonnect/screens/siswa/materi_page.dart';
import 'package:educonnect/screens/siswa/tugas_page.dart';
import 'package:educonnect/screens/siswa/latihan_detail_page.dart';
import 'package:educonnect/screens/siswa/kuis_detail_page.dart';
import 'package:educonnect/models/quiz_model.dart';

enum UserRole { guru, siswa, orangTua }

class MainDashboardPage extends StatefulWidget {
  final UserRole role;

  const MainDashboardPage({super.key, required this.role});

  @override
  State<MainDashboardPage> createState() => _MainDashboardPageState();
}

class _MainDashboardPageState extends State<MainDashboardPage> {
  int _selectedIndex = 0;
  String _selectedSubject = 'All';

  final List<Map<String, dynamic>> _allLatihan = [
    {
      'title': 'Algebra II',
      'deadline': '14 May 2025, 23:59 PM',
      'isSubmitted': false,
      'uploadedFileNames': <String>[],
      'question': 'Selesaikan persamaan kuadrat berikut: x^2 - 5x + 6 = 0. Tunjukkan langkah-langkah penyelesaiannya.'
    },
    {
      'title': 'World History',
      'deadline': '14 May 2025, 23:59 PM',
      'isSubmitted': false,
      'uploadedFileNames': <String>[],
      'question': 'Jelaskan dampak utama Revolusi Industri terhadap masyarakat Eropa pada abad ke-19. Sertakan setidaknya dua dampak positif dan dua dampak negatif.'
    },
  ];

  final List<Quiz> _allQuizzes = [
    Quiz(
      title: 'Geometri',
      description: 'Kuis ini mencakup materi dasar geometri, termasuk sudut, garis, dan bangun datar.',
      deadline: '8 May 2025, 23:59 PM',
      durationMinutes: 30,
      questions: [
        QuizQuestion(id: 'q1', questionText: '1 + 1 = ...', type: QuestionType.multipleChoice, options: ['1', '2', '3', '4'], correctAnswer: '2'),
        QuizQuestion(id: 'q2', questionText: '12 + 8 = ...', type: QuestionType.multipleChoice, options: ['20', '25', '29', '19'], correctAnswer: '20'),
        QuizQuestion(id: 'q3', questionText: 'Jelaskan pengertian segitiga siku-siku!', type: QuestionType.essay),
        QuizQuestion(id: 'q4', questionText: 'Berapa jumlah sudut dalam lingkaran?', type: QuestionType.multipleChoice, options: ['90', '180', '270', '360'], correctAnswer: '360'),
        QuizQuestion(id: 'q5', questionText: 'Jika sebuah persegi memiliki sisi 5 cm, berapa luasnya?', type: QuestionType.essay),
      ],
    ),
    Quiz(
      title: 'Hukum Newton',
      description: 'Kuis ini akan menguji pemahaman Anda tentang tiga hukum gerak Newton.',
      deadline: '17 May 2025, 23:59 PM',
      durationMinutes: 45,
      questions: [
        QuizQuestion(id: 'q1', questionText: 'Hukum Newton I dikenal sebagai hukum...', type: QuestionType.multipleChoice, options: ['Aksi-Reaksi', 'Inersia', 'Gravitasi', 'Energi'], correctAnswer: 'Inersia'),
        QuizQuestion(id: 'q2', questionText: 'Rumus untuk Hukum Newton II adalah...', type: QuestionType.multipleChoice, options: ['E=mc²', 'F=ma', 'P=IV', 'V=IR'], correctAnswer: 'F=ma'),
        QuizQuestion(id: 'q3', questionText: 'Berikan contoh penerapan Hukum Newton III dalam kehidupan sehari-hari!', type: QuestionType.essay),
        QuizQuestion(id: 'q4', questionText: 'Satuan gaya dalam SI adalah...', type: QuestionType.multipleChoice, options: ['Joule', 'Watt', 'Newton', 'Pascal'], correctAnswer: 'Newton'),
        QuizQuestion(id: 'q5', questionText: 'Apa yang terjadi pada benda yang bergerak dengan kecepatan konstan jika tidak ada gaya eksternal yang bekerja padanya?', type: QuestionType.essay),
      ],
    ),
  ];

  void _navigateToSubject(String subject) {
    setState(() {
      _selectedSubject = subject;
      _selectedIndex = 1;
    });
  }

  void _markLatihanAsSubmitted(String title, List<String>? uploadedFileNames) {
    setState(() {
      int index = _allLatihan.indexWhere((item) => item['title'] == title);
      if (index != -1) {
        _allLatihan[index]['isSubmitted'] = uploadedFileNames != null && uploadedFileNames.isNotEmpty;
        _allLatihan[index]['uploadedFileNames'] = uploadedFileNames;
      }
    });
  }

  void _navigateToLatihanDetail(String title) {
    final selectedLatihan = _allLatihan.firstWhere((item) => item['title'] == title);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LatihanDetailPage(
          title: selectedLatihan['title'],
          initialFileNames: selectedLatihan['uploadedFileNames'],
          question: selectedLatihan['question'],
          onTurnIn: (submittedTitle, fileNames) {
            _markLatihanAsSubmitted(submittedTitle, fileNames);
          },
        ),
      ),
    );
  }

  void _markQuizAsCompleted(String quizTitle, Duration remainingTime, List<QuizQuestion> answeredQuestions) {
    setState(() {
      int index = _allQuizzes.indexWhere((quiz) => quiz.title == quizTitle);
      if (index != -1) {
        _allQuizzes[index] = _allQuizzes[index].copyWith(
          isCompleted: true,
          remainingTime: remainingTime,
          questions: answeredQuestions,
        );
      }
    });
  }

  void _openQuiz(String quizTitle) {
    final selectedQuiz = _allQuizzes.firstWhere((quiz) => quiz.title == quizTitle);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizDetailPage(
          quiz: selectedQuiz,
          onQuizStarted: (startedQuiz) {
            setState(() {
              int index = _allQuizzes.indexWhere((q) => q.title == startedQuiz.title);
              if (index != -1) {
                _allQuizzes[index] = startedQuiz;
              }
            });
          },
          onQuizCompleted: _markQuizAsCompleted,
          onQuizPaused: (pausedQuiz, remainingTime, currentQuestions) {
            setState(() {
              int index = _allQuizzes.indexWhere((q) => q.title == pausedQuiz.title);
              if (index != -1) {
                _allQuizzes[index] = pausedQuiz.copyWith(
                  remainingTime: remainingTime,
                  questions: currentQuestions,
                );
              }
            });
          },
        ),
      ),
    );
  }

  Widget _getHomepageForRole() {
    switch (widget.role) {
      case UserRole.guru:
        return const GuruHomepage();
      case UserRole.siswa:
        return SiswaHomepage(
          onSubjectSelected: _navigateToSubject,
          onHomeworkSelected: _navigateToLatihanDetail,
          allLatihan: _allLatihan,
        );
      case UserRole.orangTua:
        return const OrangTuaHomepage();
    }
  }

  List<Widget> _buildScreens() {
    return [
      _getHomepageForRole(),
      MateriPage(selectedSubject: _selectedSubject),
      TugasPage(
        allLatihan: _allLatihan,
        navigateToLatihanDetail: _navigateToLatihanDetail,
        allQuizzes: _allQuizzes,
        openQuiz: _openQuiz,
      ),
      const ProfilePage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index != 1) {
        _selectedSubject = 'All';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    final l10n = AppLocalizations.of(context)!;

    final screens = _buildScreens();

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: l10n.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.book),
            label: l10n.materials,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.assignment),
            label: l10n.tasks,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: l10n.profile,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      ),
    );
  }
}