enum QuestionType { multipleChoice, essay }

class QuizQuestion {
  final String id; // Untuk identifikasi unik setiap soal
  final String questionText;
  final QuestionType type;
  final List<String>? options; // Hanya untuk multipleChoice
  final String? correctAnswer; // Untuk validasi atau ditampilkan setelah selesai
  final String? studentAnswer; // Jawaban yang disimpan siswa

  QuizQuestion({
    required this.id,
    required this.questionText,
    required this.type,
    this.options,
    this.correctAnswer,
    this.studentAnswer, // Inisialisasi dengan null
  });

  // Metode untuk membuat salinan dengan studentAnswer baru
  QuizQuestion copyWith({String? studentAnswer}) {
    return QuizQuestion(
      id: id,
      questionText: questionText,
      type: type,
      options: options,
      correctAnswer: correctAnswer,
      studentAnswer: studentAnswer ?? this.studentAnswer,
    );
  }
}

class Quiz {
  final String title;
  final String description;
  final String deadline;
  final int durationMinutes; // Durasi kuis
  final List<QuizQuestion> questions;
  bool isCompleted; // Menandakan apakah kuis sudah selesai
  Duration remainingTime; // Sisa waktu saat ini
  DateTime? startTime; // Waktu kuis dimulai

  Quiz({
    required this.title,
    required this.description,
    required this.deadline,
    required this.durationMinutes,
    required this.questions,
    this.isCompleted = false,
    Duration? remainingTime,
    this.startTime,
  }) : remainingTime = remainingTime ?? Duration(minutes: durationMinutes);

  // Metode untuk membuat salinan dengan properti yang diperbarui
  Quiz copyWith({
    bool? isCompleted,
    Duration? remainingTime,
    DateTime? startTime,
    List<QuizQuestion>? questions,
  }) {
    return Quiz(
      title: title,
      description: description,
      deadline: deadline,
      durationMinutes: durationMinutes,
      questions: questions ?? this.questions,
      isCompleted: isCompleted ?? this.isCompleted,
      remainingTime: remainingTime ?? this.remainingTime,
      startTime: startTime ?? this.startTime,
    );
  }
}