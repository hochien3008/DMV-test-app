import 'package:json_annotation/json_annotation.dart';

part 'quiz_result.g.dart';

@JsonSerializable()
class QuizResult {
  final int id;
  final DateTime date;
  final int totalQuestions;
  final int correctAnswers;
  final int score;
  final String category;
  final Duration timeTaken;
  final List<int> userAnswers;
  final int xpEarned;
  final int maxXp;

  QuizResult({
    required this.id,
    required this.date,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.score,
    required this.category,
    required this.timeTaken,
    required this.userAnswers,
    required this.xpEarned,
    required this.maxXp,
  });

  factory QuizResult.fromJson(Map<String, dynamic> json) =>
      _$QuizResultFromJson(json);
  Map<String, dynamic> toJson() => _$QuizResultToJson(this);

  double get percentage => (correctAnswers / totalQuestions) * 100;
  bool get passed => percentage >= 70.0;

  // Calculate XP based on completion percentage
  static int calculateXp(double percentage, int maxXp) {
    return (percentage / 100 * maxXp).round();
  }
}
