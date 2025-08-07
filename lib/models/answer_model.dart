class AnswerModel {
   final String text;
   final bool isCorrect;

  AnswerModel({required this.text, required this.isCorrect});

 factory AnswerModel.fromJson(Map<String, dynamic> json) {
   return AnswerModel(
    text: json['text'] ?? '', 
    isCorrect: json['isCorrect'] ?? false);
 }
 Map<String, dynamic> toJSon() {
  return {
    'text': text,
    'is_correct': isCorrect,
  };
 }
}
