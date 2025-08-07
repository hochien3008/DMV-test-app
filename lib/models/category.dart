import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  final String id;
  final String name;
  final String description;
  final String icon;
  final int questionCount;
  final bool isPremium;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.questionCount,
    this.isPremium = false,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
