import 'dart:async';
import 'package:flutter/material.dart';
import 'package:educonnect/models/quiz_model.dart';

class QuizAttemptPage extends StatefulWidget {
  final Quiz quiz;
  final Function(String, Duration, List<QuizQuestion>) onQuizCompleted;
  final Function(Quiz, Duration, List<QuizQuestion>) onQuizPaused;

  const QuizAttemptPage({
    super.key,
    required this.quiz,
    required this.onQuizCompleted,
    required this.onQuizPaused,
  });

  @override
  State<QuizAttemptPage> createState() => _QuizAttemptPageState();
}

class _QuizAttemptPageState extends State<QuizAttemptPage> {
  late List<QuizQuestion> _currentQuestions;
  int _currentQuestionIndex = 0;
  late Timer _timer;
  late Duration _remainingTime;
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();
    _currentQuestions = widget.quiz.questions.map((q) => q.copyWith()).toList();
    _remainingTime = widget.quiz.remainingTime;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_remainingTime.inSeconds > 0) {
          _remainingTime = _remainingTime - const Duration(seconds: 1);
        } else {
          _timer.cancel();
          _finishQuiz(autoSubmit: true); // Otomatis selesai jika waktu habis
        }
      });
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _currentQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  void _goToQuestion(int index) {
    if (index >= 0 && index < _currentQuestions.length) {
      setState(() {
        _currentQuestionIndex = index;
      });
    }
  }

  void _saveStudentAnswer(String? answer) {
    setState(() {
      _currentQuestions[_currentQuestionIndex] =
          _currentQuestions[_currentQuestionIndex].copyWith(studentAnswer: answer);
    });
  }

  // Tambahkan parameter opsional autoSubmit
  void _finishQuiz({bool autoSubmit = false}) {
    // Jika bukan auto-submit, tampilkan konfirmasi
    if (!autoSubmit) {
      showDialog<bool>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('Konfirmasi'),
            content: const Text('Yakin ingin menyelesaikan kuis?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Tidak'),
                onPressed: () {
                  Navigator.of(dialogContext).pop(false); // Jangan selesaikan kuis
                },
              ),
              TextButton(
                child: const Text('Ya'),
                onPressed: () {
                  Navigator.of(dialogContext).pop(true); // Selesaikan kuis
                },
              ),
            ],
          );
        },
      ).then((confirmed) {
        if (confirmed == true) {
          _performFinishActions();
        }
      });
    } else {
      // Jika auto-submit (waktu habis), langsung selesaikan
      _performFinishActions();
    }
  }

  void _performFinishActions() {
    _timer.cancel();
    widget.onQuizCompleted(widget.quiz.title, _remainingTime, _currentQuestions);
    setState(() {
      _isFinished = true;
    });

    // Navigasi kembali ke TugasPage
    Navigator.of(context).pop(); // Pop QuizAttemptPage
    Navigator.of(context).pop(); // Pop QuizDetailPage
  }


  Future<bool> _onWillPop() async {
    _timer.cancel();
    widget.onQuizPaused(widget.quiz, _remainingTime, _currentQuestions);
    return true;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _currentQuestions[_currentQuestionIndex];

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _onWillPop().then((value) {
          if (value) {
            Navigator.of(context).pop();
          }
        });
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              _onWillPop().then((value) {
                if (value) {
                  Navigator.pop(context);
                }
              });
            },
          ),
          title: Text(widget.quiz.title, style: const TextStyle(color: Colors.black)),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  _formatDuration(_remainingTime),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
          ],
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
                        '${_currentQuestionIndex + 1}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currentQuestion.questionText,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (currentQuestion.type == QuestionType.multipleChoice && currentQuestion.options != null)
                Column(
                  children: currentQuestion.options!.map((option) {
                    final isSelected = currentQuestion.studentAnswer == option;
                    return GestureDetector(
                      onTap: _isFinished ? null : () => _saveStudentAnswer(option),
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        color: isSelected ? const Color.fromRGBO(160, 203, 196, 1) : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  option,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: isSelected ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              if (currentQuestion.type == QuestionType.essay)
                TextField(
                  enabled: !_isFinished,
                  onChanged: (text) => _saveStudentAnswer(text),
                  controller: TextEditingController(text: currentQuestion.studentAnswer),
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Tulis jawaban Anda di sini...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              const Spacer(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_currentQuestions.length, (index) {
                    final bool hasAnswer = _currentQuestions[index].studentAnswer != null &&
                        _currentQuestions[index].studentAnswer!.isNotEmpty;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ElevatedButton(
                        onPressed: () => _goToQuestion(index),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _currentQuestionIndex == index
                              ? Colors.teal
                              : hasAnswer
                                  ? const Color.fromRGBO(160, 203, 196, 1)
                                  : Colors.grey[300],
                          minimumSize: const Size(40, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: _currentQuestionIndex == index || hasAnswer
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentQuestionIndex > 0)
                    ElevatedButton(
                      onPressed: _isFinished ? null : _previousQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.black),
                    )
                  else
                    const SizedBox(width: 60),

                  _currentQuestionIndex < _currentQuestions.length - 1
                      ? ElevatedButton(
                          onPressed: _isFinished ? null : _nextQuestion,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(160, 203, 196, 1),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Icon(Icons.arrow_forward, color: Colors.white),
                        )
                      : ElevatedButton(
                          onPressed: _isFinished ? null : () => _finishQuiz(), // Panggil _finishQuiz tanpa parameter
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Selesai',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}