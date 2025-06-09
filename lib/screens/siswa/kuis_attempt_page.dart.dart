import 'dart:async';
import 'package:flutter/material.dart';
import 'package:educonnect/l10n/app_localizations.dart';
import 'package:educonnect/l10n/l10n.dart';
import 'package:provider/provider.dart';
import 'package:educonnect/models/quiz_model.dart';
import 'package:educonnect/providers/theme_provider.dart';

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
          _finishQuiz(autoSubmit: true);
        }
      });
    });//
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

  void _finishQuiz({bool autoSubmit = false}) {
    final l10n = AppLocalizations.of(context)!;

    if (!autoSubmit) {
      showDialog<bool>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text(l10n.confirmation),
            content: Text(l10n.finishQuizConfirmation),
            actions: <Widget>[
              TextButton(
                child: Text(l10n.no),
                onPressed: () => Navigator.of(dialogContext).pop(false),
              ),
              TextButton(
                child: Text(l10n.yes),
                onPressed: () => Navigator.of(dialogContext).pop(true),
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
      _performFinishActions();
    }
  }

  void _performFinishActions() {
    _timer.cancel();
    widget.onQuizCompleted(widget.quiz.title, _remainingTime, _currentQuestions);
    setState(() {
      _isFinished = true;
    });

    Navigator.of(context).pop();
    Navigator.of(context).pop();
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final l10n = AppLocalizations.of(context)!;
    final currentQuestion = _currentQuestions[_currentQuestionIndex];
    final isDarkMode = themeProvider.isDarkMode;

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
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
            onPressed: () {
              _onWillPop().then((value) {
                if (value) {
                  Navigator.pop(context);
                }
              });
            },
          ),
          title: Text(
            widget.quiz.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  _formatDuration(_remainingTime),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
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
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_currentQuestionIndex + 1}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currentQuestion.questionText,
                        style: Theme.of(context).textTheme.bodyLarge,
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
                        color: isSelected
                            ? isDarkMode
                            ? const Color.fromRGBO(82, 193, 185, 1)
                            : const Color.fromRGBO(160, 203, 196, 1)
                            : Theme.of(context).cardColor,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  option,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: isSelected
                                        ? Colors.white
                                        : Theme.of(context).textTheme.bodyLarge?.color,
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
                    hintText: l10n.writeYourAnswerHere,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
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
                              ? Theme.of(context).colorScheme.primary
                              : hasAnswer
                              ? isDarkMode
                              ? const Color.fromRGBO(82, 193, 185, 1)
                              : const Color.fromRGBO(160, 203, 196, 1)
                              : Theme.of(context).colorScheme.surface,
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
                                : Theme.of(context).textTheme.bodyLarge?.color,
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
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    )
                  else
                    const SizedBox(width: 60),

                  _currentQuestionIndex < _currentQuestions.length - 1
                      ? ElevatedButton(
                    onPressed: _isFinished ? null : _nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode
                          ? const Color.fromRGBO(82, 193, 185, 1)
                          : const Color.fromRGBO(160, 203, 196, 1),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  )
                      : ElevatedButton(
                    onPressed: _isFinished ? null : () => _finishQuiz(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      l10n.finish,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
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