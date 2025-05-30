// lib/models/class_model.dart
class ClassModel {
  final String className;
  final String subject;
  final String time;
  final double progress;
  final int totalStudents;

  const ClassModel({
    required this.className,
    required this.subject,
    required this.time,
    required this.progress,
    required this.totalStudents,
  });
}
