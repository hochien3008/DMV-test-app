// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  icon: json['icon'] as String,
  questionCount: (json['questionCount'] as num).toInt(),
  isPremium: json['isPremium'] as bool? ?? false,
);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'icon': instance.icon,
  'questionCount': instance.questionCount,
  'isPremium': instance.isPremium,
};
