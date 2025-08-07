// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
  id: (json['id'] as num).toInt(),
  question: json['question'] as String,
  options: (json['options'] as List<dynamic>).map((e) => e as String).toList(),
  correctAnswer: (json['correctAnswer'] as num).toInt(),
  explanation: json['explanation'] as String,
  category: json['category'] as String,
  imageUrl: json['imageUrl'] as String? ?? '',
  isImageQuestion: json['isImageQuestion'] as bool? ?? false,
);

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
  'id': instance.id,
  'question': instance.question,
  'options': instance.options,
  'correctAnswer': instance.correctAnswer,
  'explanation': instance.explanation,
  'category': instance.category,
  'imageUrl': instance.imageUrl,
  'isImageQuestion': instance.isImageQuestion,
};
