import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quiz_result.dart';
import '../services/database_service.dart';
import '../services/question_service.dart';
import 'app_settings_provider.dart';
import 'dart:math';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class QuizProvider with ChangeNotifier {
  List<Map<String, dynamic>> _currentQuestions = [];
  List<int> _userAnswers = [];
  int _currentQuestionIndex = 0;
  DateTime? _quizStartTime;
  bool _isQuizActive = false;
  int _currentCategoryId = 0;
  int _currentSetNumber = 0; // Track current set number
  final DatabaseService _databaseService = DatabaseService();
  final QuestionService _questionService = QuestionService();
  
  // Study mode specific variables
  bool _isStudyMode = false;
  Map<int, List<int>> _questionAnswerOrder = {}; // Store answer order for each question
  Map<int, int> _questionSeed = {}; // Store seed for each question to ensure consistency

  // Getters
  List<Map<String, dynamic>> get currentQuestions => _currentQuestions;
  List<int> get userAnswers => _userAnswers;
  int get currentQuestionIndex => _currentQuestionIndex;
  bool get isQuizActive => _isQuizActive;
  int get currentCategoryId => _currentCategoryId;
  bool get isStudyMode => _isStudyMode;
  Map<String, dynamic>? get currentQuestion =>
      _currentQuestions.isNotEmpty &&
          _currentQuestionIndex < _currentQuestions.length
      ? _currentQuestions[_currentQuestionIndex]
      : null;

  int get totalQuestions => _currentQuestions.length;
  int get answeredQuestions =>
      _userAnswers.where((answer) => answer != -1).length;
  int get correctAnswers {
    int correct = 0;
    for (int i = 0; i < _currentQuestions.length; i++) {
      if (i < _userAnswers.length) {
        final answers =
            _currentQuestions[i]['answers'] as List<Map<String, dynamic>>;
        final correctAnswerIndex = answers.indexWhere(
          (answer) => answer['is_correct'] == 1,
        );
        if (_userAnswers[i] == correctAnswerIndex) {
          correct++;
        }
      }
    }
    return correct;
  }

  double get progress =>
      totalQuestions > 0 ? answeredQuestions / totalQuestions : 0.0;
  double get score =>
      totalQuestions > 0 ? (correctAnswers / totalQuestions) * 100 : 0.0;

  // XP System
  static const int maxXpPerSet = 100;
  int get xpEarned => QuizResult.calculateXp(score, maxXpPerSet);
  int get maxXp => maxXpPerSet;

  // Initialize quiz
  Future<void> startQuiz(
    int categoryId, {
    int questionCount = 10,
    int? setNumber,
    bool isStudyMode = false,
  }) async {
    try {
      _isStudyMode = isStudyMode;
      List<Map<String, dynamic>> questions;

      if (setNumber != null && (categoryId == 1 || categoryId == 2)) {
        // Use set-based questions for Unit 1 and Unit 2
        questions = await _questionService.getQuestionsBySet(
          categoryId,
          setNumber,
        );
      } else {
        // Use random questions for other categories or when no set is specified
        questions = await _questionService.getRandomQuestionsForQuiz(
          categoryId,
          questionCount,
        );
      }

      // For study mode, ensure consistent answer order
      if (_isStudyMode) {
        questions = await _prepareQuestionsForStudyMode(questions);
      }

      _currentQuestions = questions;
      _userAnswers = List.filled(_currentQuestions.length, -1);
      _currentQuestionIndex = 0;
      _currentCategoryId = categoryId;
      _currentSetNumber = setNumber ?? 1; // Save set number
      _quizStartTime = DateTime.now();
      _isQuizActive = true;

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }


  Future<List<Map<String, dynamic>>> _prepareQuestionsForStudyMode(
    List<Map<String, dynamic>> questions,
  ) async {
    final preparedQuestions = <Map<String, dynamic>>[];
    
    for (int i = 0; i < questions.length; i++) {
      final question = Map<String, dynamic>.from(questions[i]);
      final questionId = question['id'] as int;
     
      if (!_questionSeed.containsKey(questionId)) {
        _questionSeed[questionId] = questionId.hashCode; 
      }
      
      final seed = _questionSeed[questionId]!;
      final random = Random(seed);
      
      final answers = List<Map<String, dynamic>>.from(question['answers'] ?? []);
     
      final existingOrder = await _loadAnswerOrder(questionId);
      if (existingOrder != null && existingOrder.length == answers.length) {
        _questionAnswerOrder[questionId] = existingOrder;
      } else {

        if (!_questionAnswerOrder.containsKey(questionId)) {
          final answerIndices = List<int>.generate(answers.length, (index) => index);
          answerIndices.shuffle(random);
          _questionAnswerOrder[questionId] = answerIndices;
        
          await _saveAnswerOrder(questionId, answerIndices);
        }
      }
      
     
      final reorderedAnswers = <Map<String, dynamic>>[];
      final order = _questionAnswerOrder[questionId]!;
      
      for (int j = 0; j < order.length; j++) {
        reorderedAnswers.add(answers[order[j]]);
      }
      
      question['answers'] = reorderedAnswers;
      preparedQuestions.add(question);
    }
    
    return preparedQuestions;
  }

 
  Future<void> _saveAnswerOrder(int questionId, List<int> order) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = 'answer_order_$questionId';
      final orderJson = jsonEncode(order);
      await prefs.setString(key, orderJson);
    } catch (e) {
    
      debugPrint('Failed to save answer order: $e');
    }
  }


  Future<List<int>?> _loadAnswerOrder(int questionId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = 'answer_order_$questionId';
      final orderJson = prefs.getString(key);
      if (orderJson != null) {
        final orderList = jsonDecode(orderJson) as List;
        return orderList.cast<int>();
      }
    } catch (e) {

      debugPrint('Failed to load answer order: $e');
    }
    return null;
  }


  Future<void> clearStoredAnswerOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();
      final answerOrderKeys = keys.where((key) => key.startsWith('answer_order_'));
      for (final key in answerOrderKeys) {
        await prefs.remove(key);
      }
      _questionAnswerOrder.clear();
      _questionSeed.clear();
    } catch (e) {
      debugPrint('Failed to clear answer orders: $e');
    }
  }

  void debugAnswerOrder(int questionIndex) {
    if (questionIndex >= 0 && questionIndex < _currentQuestions.length) {
      final question = _currentQuestions[questionIndex];
      final questionId = question['id'] as int;
      final answers = question['answers'] as List<Map<String, dynamic>>;
      
      debugPrint('=== Debug Answer Order for Question $questionIndex (ID: $questionId) ===');
      debugPrint('Original answers:');
      for (int i = 0; i < answers.length; i++) {
        final answer = answers[i];
        final isCorrect = answer['is_correct'] == 1;
        debugPrint('  [$i]: ${answer['answer']} ${isCorrect ? '(CORRECT)' : ''}');
      }
      
      if (_questionAnswerOrder.containsKey(questionId)) {
        final order = _questionAnswerOrder[questionId]!;
        debugPrint('Shuffled order: $order');
        debugPrint('Shuffled answers:');
        for (int i = 0; i < order.length; i++) {
          final originalIndex = order[i];
          final answer = answers[originalIndex];
          final isCorrect = answer['is_correct'] == 1;
          debugPrint('  [$i] -> [$originalIndex]: ${answer['answer']} ${isCorrect ? '(CORRECT)' : ''}');
        }
      } else {
        debugPrint('No order stored for this question');
      }
      debugPrint('==========================================');
    }
  }


  int getOriginalAnswerIndex(int questionIndex, int shuffledIndex) {
    if (questionIndex >= 0 && questionIndex < _currentQuestions.length) {
      final question = _currentQuestions[questionIndex];
      final questionId = question['id'] as int;
      
      if (_questionAnswerOrder.containsKey(questionId)) {
        final order = _questionAnswerOrder[questionId]!;
        if (shuffledIndex >= 0 && shuffledIndex < order.length) {
          return order[shuffledIndex];
        }
      }
    }
    return shuffledIndex; 
  }

 
  int getShuffledAnswerIndex(int questionIndex, int originalIndex) {
    if (questionIndex >= 0 && questionIndex < _currentQuestions.length) {
      final question = _currentQuestions[questionIndex];
      final questionId = question['id'] as int;
      
      if (_questionAnswerOrder.containsKey(questionId)) {
        final order = _questionAnswerOrder[questionId]!;
        return order.indexOf(originalIndex);
      }
    }
    return originalIndex; 
  }

 
  void answerQuestion(int answerIndex) {
    if (_currentQuestionIndex < _userAnswers.length) {
      _userAnswers[_currentQuestionIndex] = answerIndex;
      notifyListeners();
    }
  }


  void nextQuestion() {
    if (_currentQuestionIndex < _currentQuestions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

 
  void goToQuestion(int index) {
    if (index >= 0 && index < _currentQuestions.length) {
      _currentQuestionIndex = index;
      notifyListeners();
    }
  }


  int? getUserAnswer(int questionIndex) {
    if (questionIndex >= 0 && questionIndex < _userAnswers.length) {
      return _userAnswers[questionIndex] == -1
          ? null
          : _userAnswers[questionIndex];
    }
    return null;
  }

  // Check if question is answered
  bool isQuestionAnswered(int questionIndex) {
    return questionIndex >= 0 &&
        questionIndex < _userAnswers.length &&
        _userAnswers[questionIndex] != -1;
  }

  // Check if answer is correct
  bool isAnswerCorrect(int questionIndex) {
    if (questionIndex >= 0 &&
        questionIndex < _currentQuestions.length &&
        questionIndex < _userAnswers.length) {
      final answers =
          _currentQuestions[questionIndex]['answers']
              as List<Map<String, dynamic>>;
      final correctAnswerIndex = answers.indexWhere(
        (answer) => answer['is_correct'] == 1,
      );
      return _userAnswers[questionIndex] == correctAnswerIndex;
    }
    return false;
  }

  // Finish quiz and save results
  Future<Map<String, dynamic>> finishQuiz(BuildContext context) async {
    if (!_isQuizActive || _quizStartTime == null) {
      throw Exception('Quiz is not active');
    }

    final timeTaken = DateTime.now().difference(_quizStartTime!);

    // Lưu kết quả vào database
    final resultId = await _questionService.saveQuizResult(
      categoryId: _currentCategoryId,
      totalQuestions: totalQuestions,
      correctAnswers: correctAnswers,
      score: score,
      timeTaken: timeTaken.inSeconds,
    );

    // Cập nhật tiến độ học tập
    await _questionService.updateUserProgress(
      _currentCategoryId,
      totalQuestions,
      correctAnswers,
    );

    // Lưu XP vào AppSettingsProvider
    final setNumber = _currentSetNumber; // Use the tracked set number

    await Provider.of<AppSettingsProvider>(
      context,
      listen: false,
    ).addXp(setNumber, xpEarned);

    final result = {
      'id': resultId,
      'categoryId': _currentCategoryId,
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'score': score,
      'timeTaken': timeTaken,
      'userAnswers': List.from(_userAnswers),
      'xpEarned': xpEarned,
      'maxXp': maxXp,
    };

    _isQuizActive = false;
    notifyListeners();

    return result;
  }

  // Reset quiz
  void resetQuiz() {
    _currentQuestions = [];
    _userAnswers = [];
    _currentQuestionIndex = 0;
    _quizStartTime = null;
    _isQuizActive = false;
    _currentCategoryId = 0;
    _isStudyMode = false;
    _questionAnswerOrder.clear();
    _questionSeed.clear();
    notifyListeners();
  }

  // Get quiz results from database
  Future<List<Map<String, dynamic>>> getQuizResults() async {
    return await _questionService.getQuizHistory();
  }

  Future<List<Map<String, dynamic>>> getQuizResultsByCategory(
    int categoryId,
  ) async {
    return await _questionService.getQuizHistoryByCategory(categoryId);
  }

  // Get user progress
  Future<Map<String, dynamic>?> getUserProgress(int categoryId) async {
    return await _questionService.getUserProgress(categoryId);
  }

  // Get statistics
  Future<Map<String, dynamic>> getStatistics() async {
    return await _questionService.getStatistics();
  }

  // Get categories
  Future<List<Map<String, dynamic>>> getCategories() async {
    return await _questionService.getAllCategories();
  }

  // Get questions by category
  Future<List<Map<String, dynamic>>> getQuestionsByCategory(
    int categoryId,
  ) async {
    return await _questionService.getQuestionsByCategory(categoryId);
  }

  // Search questions
  Future<List<Map<String, dynamic>>> searchQuestions(String searchText) async {
    return await _questionService.searchQuestions(searchText);
  }
}
