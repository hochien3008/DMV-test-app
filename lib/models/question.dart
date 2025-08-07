import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question {
  final int id;
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String explanation;
  final String category;
  final String imageUrl;
  final bool isImageQuestion;

  Question({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    required this.category,
    this.imageUrl = '',
    this.isImageQuestion = false,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  bool isCorrect(int selectedAnswer) {
    return selectedAnswer == correctAnswer;
  }

  String get correctAnswerText {
    return options[correctAnswer];
  }
}
