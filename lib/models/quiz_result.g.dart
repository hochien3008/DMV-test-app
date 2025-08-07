// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizResult _$QuizResultFromJson(Map<String, dynamic> json) => QuizResult(
  id: (json['id'] as num).toInt(),
  date: DateTime.parse(json['date'] as String),
  totalQuestions: (json['totalQuestions'] as num).toInt(),
  correctAnswers: (json['correctAnswers'] as num).toInt(),
  score: (json['score'] as num).toInt(),
  category: json['category'] as String,
  timeTaken: Duration(microseconds: (json['timeTaken'] as num).toInt()),
  userAnswers: (json['userAnswers'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  xpEarned: (json['xpEarned'] as num).toInt(),
  maxXp: (json['maxXp'] as num).toInt(),
);

Map<String, dynamic> _$QuizResultToJson(QuizResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'totalQuestions': instance.totalQuestions,
      'correctAnswers': instance.correctAnswers,
      'score': instance.score,
      'category': instance.category,
      'timeTaken': instance.timeTaken.inMicroseconds,
      'userAnswers': instance.userAnswers,
      'xpEarned': instance.xpEarned,
      'maxXp': instance.maxXp,
    };
