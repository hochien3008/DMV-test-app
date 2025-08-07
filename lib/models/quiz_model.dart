import 'question_model.dart';

class QuizModel {
  final String id;
  final String title;
  final String description;
  final int questionCount;
  final int commentCount;
  final int timeLimit; //trong vài giây
  final List<QuestionModel> questions;

  QuizModel({
    required this.id,
    required this.title,
    required this.description,
    required this.questionCount,
    required this.commentCount,
    required this.timeLimit,
    required this.questions,
  });
  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'] ?? '', 
      title: json['title'] ?? '', 
      description: json['description'] ?? '', 
      questionCount: json['questionCount'] ?? 0, 
      commentCount: json['commentCount'] ?? 0, 
      timeLimit: json['timeLimit'] ?? 1800, //số giây
      questions: (json['questions'] as List).map((q) => 
      QuestionModel.fromJson(q)).toList(),);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'questionCount': questionCount,
      'commentCount': commentCount,
      'timeLimit': timeLimit,
      'questions': questions.map((q) => q.toJson()).toList(), //danh sách câu hỏi
    };
  }
}
