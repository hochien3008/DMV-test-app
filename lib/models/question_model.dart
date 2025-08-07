import 'answer_model.dart';

class QuestionModel {
  final String id;
  final String category; // thêm thuộc tính category
  final String text;
  final String? image; //ảnh biển báo
  final List<AnswerModel> answers;

  QuestionModel({required this.id, required this.category, required this.text, required this.answers, this.image});

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] ?? '', 
      category: json['category'] ?? '', // khôi phục thuộc tính category
      text: json['text'] ?? '', 
      image: json['image'] ?? '',
      answers: (json['answers'] as List).map((item) => 
      AnswerModel.fromJson(item)).toList(),);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category, // thêm thuộc tính category vào phương thức toJson
      'text': text,
      'image': image,
      'answers': answers.map((a) => a.toJSon()).toList(),
    };
  }
}

// Ví dụ về cách sử dụng QuestionModel với thuộc tính category
void main() {
  var question = QuestionModel(
    id: 'w1',
    category: 'rules', // hoặc 'traffic', 'defensive', 'special', 'sharing', 'alcohol'
    text: 'What does this warning sign mean?',
    answers: [], // Thay thế bằng danh sách câu trả lời thực tế
  );

  print(question.toJson());
}