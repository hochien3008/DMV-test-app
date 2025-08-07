import 'database_service.dart';

class QuestionService {
  final DatabaseService _databaseService = DatabaseService();

  // Get all categories
  Future<List<Map<String, dynamic>>> getAllCategories() async {
    return await _databaseService.getAllCategories();
  }

  // Get questions by category
  Future<List<Map<String, dynamic>>> getQuestionsByCategory(
    int categoryId,
  ) async {
    final questions = await _databaseService.getQuestionsByCategory(categoryId);
    final result = <Map<String, dynamic>>[];

    for (var question in questions) {
      // Create a mutable copy of the question map
      final questionCopy = Map<String, dynamic>.from(question);
      final answers = await _databaseService.getAnswersByQuestion(
        questionCopy['id'] as int,
      );
      questionCopy['answers'] = answers;
      result.add(questionCopy);
    }

    return result;
  }

  // Get random questions for quiz
  Future<List<Map<String, dynamic>>> getRandomQuestionsForQuiz(
    int categoryId,
    int limit,
  ) async {
    final questions = await _databaseService.getRandomQuestions(
      categoryId,
      limit,
    );
    final result = <Map<String, dynamic>>[];

    for (var question in questions) {
      // Create a mutable copy of the question map
      final questionCopy = Map<String, dynamic>.from(question);
      final answers = await _databaseService.getAnswersByQuestion(
        questionCopy['id'] as int,
      );
      questionCopy['answers'] = answers;
      result.add(questionCopy);
    }

    return result;
  }

  // Add new question with answers
  Future<int> addQuestion({
    required int categoryId,
    required String questionText,
    required List<Map<String, dynamic>> answers,
    String? explanation,
    String? imagePath,
    int difficultyLevel = 1,
    String questionType = 'multiple_choice',
  }) async {
    final questionId = await _databaseService.insertQuestion({
      'category_id': categoryId,
      'question_text': questionText,
      'question_type': questionType,
      'difficulty_level': difficultyLevel,
      'explanation': explanation,
      'image_path': imagePath,
      'is_active': 1,
    });

    // Add answers
    for (int i = 0; i < answers.length; i++) {
      await _databaseService.insertAnswer({
        'question_id': questionId,
        'answer_text': answers[i]['text'],
        'is_correct': answers[i]['is_correct'] ? 1 : 0,
        'order_index': i,
      });
    }

    return questionId;
  }

  // Update question
  Future<void> updateQuestion({
    required int questionId,
    required String questionText,
    required List<Map<String, dynamic>> answers,
    String? explanation,
    String? imagePath,
    int difficultyLevel = 1,
    String questionType = 'multiple_choice',
  }) async {
    await _databaseService.updateQuestion({
      'id': questionId,
      'question_text': questionText,
      'question_type': questionType,
      'difficulty_level': difficultyLevel,
      'explanation': explanation,
      'image_path': imagePath,
    });

    // Delete existing answers
    final existingAnswers = await _databaseService.getAnswersByQuestion(
      questionId,
    );
    for (var answer in existingAnswers) {
      await _databaseService.deleteAnswer(answer['id'] as int);
    }

    // Add new answers
    for (int i = 0; i < answers.length; i++) {
      await _databaseService.insertAnswer({
        'question_id': questionId,
        'answer_text': answers[i]['text'],
        'is_correct': answers[i]['is_correct'] ? 1 : 0,
        'order_index': i,
      });
    }
  }

  // Delete question
  Future<void> deleteQuestion(int questionId) async {
    // Delete answers first
    final answers = await _databaseService.getAnswersByQuestion(questionId);
    for (var answer in answers) {
      await _databaseService.deleteAnswer(answer['id'] as int);
    }

    // Delete question
    await _databaseService.deleteQuestion(questionId);
  }

  // Get user progress
  Future<Map<String, dynamic>?> getUserProgress(int categoryId) async {
    return await _databaseService.getUserProgress(categoryId);
  }

  // Update user progress
  Future<void> updateUserProgress(
    int categoryId,
    int questionsAnswered,
    int correctAnswers,
  ) async {
    await _databaseService.updateUserProgress(
      categoryId,
      questionsAnswered,
      correctAnswers,
    );
  }

  // Save quiz result
  Future<int> saveQuizResult({
    required int categoryId,
    required int totalQuestions,
    required int correctAnswers,
    required double score,
    int? timeTaken,
  }) async {
    return await _databaseService.saveQuizResult({
      'category_id': categoryId,
      'total_questions': totalQuestions,
      'correct_answers': correctAnswers,
      'score': score,
      'time_taken': timeTaken,
    });
  }

  // Get quiz history
  Future<List<Map<String, dynamic>>> getQuizHistory() async {
    return await _databaseService.getQuizHistory();
  }

  // Get quiz history by category
  Future<List<Map<String, dynamic>>> getQuizHistoryByCategory(
    int categoryId,
  ) async {
    return await _databaseService.getQuizHistoryByCategory(categoryId);
  }

  // Get question by ID
  Future<Map<String, dynamic>?> getQuestionById(int id) async {
    return await _databaseService.getQuestionById(id);
  }

  // Get answers by question ID
  Future<List<Map<String, dynamic>>> getAnswersByQuestion(
    int questionId,
  ) async {
    return await _databaseService.getAnswersByQuestion(questionId);
  }

  // Get question count by category
  Future<int> getQuestionCount(int categoryId) async {
    return await _databaseService.getQuestionCount(categoryId);
  }

  // Get average score by category
  Future<double> getAverageScore(int categoryId) async {
    return await _databaseService.getAverageScore(categoryId);
  }

  // Import questions from JSON
  Future<void> importQuestionsFromJson(
    List<Map<String, dynamic>> questionsData,
  ) async {
    await _databaseService.importQuestions(questionsData);
  }

  // Export questions to JSON
  Future<List<Map<String, dynamic>>> exportQuestionsToJson() async {
    return await _databaseService.exportQuestions();
  }

  // Create sample questions for testing
  Future<void> createSampleQuestions() async {
    final sampleQuestions = [
      {
        'category_id': 1,
        'question_text': 'What should you do when you see a red traffic light?',
        'question_type': 'multiple_choice',
        'difficulty_level': 1,
        'explanation':
            'Red light means stop. You must come to a complete stop before the intersection.',
        'answers': [
          {'text': 'Stop completely', 'is_correct': true},
          {'text': 'Slow down and proceed if no traffic', 'is_correct': false},
          {'text': 'Speed up to get through quickly', 'is_correct': false},
          {'text': 'Ignore it if you are in a hurry', 'is_correct': false},
        ],
      },
      {
        'category_id': 1,
        'question_text': 'What does a yellow traffic light mean?',
        'question_type': 'multiple_choice',
        'difficulty_level': 1,
        'explanation':
            'Yellow light means caution. Stop if it is safe to do so.',
        'answers': [
          {'text': 'Speed up to get through', 'is_correct': false},
          {'text': 'Stop if it is safe to do so', 'is_correct': true},
          {'text': 'Ignore it completely', 'is_correct': false},
          {'text': 'Turn right only', 'is_correct': false},
        ],
      },
      {
        'category_id': 2,
        'question_text': 'What does a stop sign mean?',
        'question_type': 'multiple_choice',
        'difficulty_level': 1,
        'explanation': 'Stop sign requires you to come to a complete stop.',
        'answers': [
          {'text': 'Slow down', 'is_correct': false},
          {'text': 'Come to a complete stop', 'is_correct': true},
          {'text': 'Speed up', 'is_correct': false},
          {'text': 'Turn around', 'is_correct': false},
        ],
      },
      {
        'category_id': 2,
        'question_text': 'What does a yield sign mean?',
        'question_type': 'multiple_choice',
        'difficulty_level': 1,
        'explanation': 'Yield sign means you must yield to other traffic.',
        'answers': [
          {'text': 'Stop completely', 'is_correct': false},
          {'text': 'Yield to other traffic', 'is_correct': true},
          {'text': 'Speed up', 'is_correct': false},
          {'text': 'Turn left only', 'is_correct': false},
        ],
      },
      {
        'category_id': 3,
        'question_text': 'What is defensive driving?',
        'question_type': 'multiple_choice',
        'difficulty_level': 2,
        'explanation':
            'Defensive driving means being aware of potential hazards and being prepared to react.',
        'answers': [
          {'text': 'Driving aggressively', 'is_correct': false},
          {'text': 'Being aware of potential hazards', 'is_correct': true},
          {'text': 'Ignoring traffic rules', 'is_correct': false},
          {'text': 'Driving as fast as possible', 'is_correct': false},
        ],
      },
    ];

    for (var questionData in sampleQuestions) {
      final answers = questionData['answers'] as List<Map<String, dynamic>>;
      questionData.remove('answers');

      await addQuestion(
        categoryId: questionData['category_id'] as int,
        questionText: questionData['question_text'] as String,
        answers: answers,
        explanation: questionData['explanation'] as String?,
        difficultyLevel: questionData['difficulty_level'] as int,
        questionType: questionData['question_type'] as String,
      );
    }
  }

  // Get questions with difficulty filter
  Future<List<Map<String, dynamic>>> getQuestionsByDifficulty(
    int categoryId,
    int difficultyLevel,
  ) async {
    final questions = await _databaseService.getQuestionsByCategory(categoryId);
    final filteredQuestions = questions
        .where((q) => q['difficulty_level'] == difficultyLevel)
        .toList();
    final result = <Map<String, dynamic>>[];

    for (var question in filteredQuestions) {
      // Create a mutable copy of the question map
      final questionCopy = Map<String, dynamic>.from(question);
      final answers = await _databaseService.getAnswersByQuestion(
        questionCopy['id'] as int,
      );
      questionCopy['answers'] = answers;
      result.add(questionCopy);
    }

    return result;
  }

  // Search questions by text
  Future<List<Map<String, dynamic>>> searchQuestions(String searchText) async {
    final db = await _databaseService.database;
    final questions = await db.rawQuery(
      '''
      SELECT * FROM questions 
      WHERE question_text LIKE ? AND is_active = 1
      ORDER BY id
    ''',
      ['%$searchText%'],
    );

    final result = <Map<String, dynamic>>[];
    for (var question in questions) {
      // Create a mutable copy of the question map
      final questionCopy = Map<String, dynamic>.from(question);
      final answers = await _databaseService.getAnswersByQuestion(
        questionCopy['id'] as int,
      );
      questionCopy['answers'] = answers;
      result.add(questionCopy);
    }

    return result;
  }

  // Get statistics
  Future<Map<String, dynamic>> getStatistics() async {
    final categories = await _databaseService.getAllCategories();
    final stats = <String, dynamic>{};

    for (var category in categories) {
      final categoryId = category['id'] as int;
      final questionCount = await _databaseService.getQuestionCount(categoryId);
      final averageScore = await _databaseService.getAverageScore(categoryId);
      final progress = await _databaseService.getUserProgress(categoryId);

      stats[category['name']] = {
        'question_count': questionCount,
        'average_score': averageScore,
        'progress': progress,
      };
    }

    return stats;
  }

  // Get questions by set number for Unit 1 (Rules of the Road) and Unit 2 (Traffic Control)
  Future<List<Map<String, dynamic>>> getQuestionsBySet(
    int categoryId,
    int setNumber,
  ) async {
    try {
      // Convert setNumber from 101-116 to 1-16 for Unit 2
      int actualSetNumber = setNumber;
      if (categoryId == 2 && setNumber >= 101 && setNumber <= 116) {
        actualSetNumber = setNumber - 100;

      }

      // Define set ranges for each unit based on actual question counts
      final setRanges = {
        1: {
          // Unit 1: Rules of the Road (based on actual question counts)
          1: [0, 2], // Set 1: 3 questions (Basics – Recognizing traffic laws)
          2: [3, 6], // Set 2: 4 questions (Basics – Intersections and turns)
          3: [7, 11], // Set 3: 5 questions (Easy – Stop, yield, park)
          4: [12, 17], // Set 4: 6 questions (Average - Speed & Signs)
          5: [
            18,
            23,
          ], // Set 5: 6 questions (Moderate – Dangerous & the law of reflexes)
          6: [
            24,
            30,
          ], // Set 6: 7 questions (Medium – Turning, changing lanes, priority lanes)
          7: [
            31,
            37,
          ], // Set 7: 7 questions (Difficult - Priority rules and reflexes)
          8: [
            38,
            45,
          ], // Set 8: 8 questions (Difficult – Real-life simulation situation)
          9: [
            46,
            53,
          ], // Set 9: 8 questions (Difficult - Understanding the law & application)
          10: [54, 59], // Set 10: 6 questions (Advanced Summary)
          11: [
            60,
            65,
          ], // Set 11: 6 questions (Simulation situations & test summary)
        },
        2: {
          // Unit 2: Traffic Control (based on actual question counts)
          1: [
            0,
            3,
          ], // Set 1: 4 questions (Recognizing signs in shape and color)
          2: [4, 7], // Set 2: 4 questions (Basic signs - Regulatory Signs)
          3: [8, 12], // Set 3: 5 questions (Warning Signs)
          4: [13, 17], // Set 4: 5 questions (Additional signs and regulations)
          5: [
            18,
            22,
          ], // Set 5: 5 questions (Road Markings – Simple and Practical)
          6: [23, 28], // Set 6: 6 questions (Traffic signals – Basic)
          7: [29, 35], // Set 7: 7 questions (Real traffic situations)
          8: [
            36,
            42,
          ], // Set 8: 7 questions (Construction site and temporary signs)
          9: [
            43,
            49,
          ], // Set 9: 7 questions (Electronic signs and electronic signs)
          10: [50, 56], // Set 10: 7 questions (Highway signs – Highway signs)
          11: [
            57,
            63,
          ], // Set 11: 7 questions (Advanced Intersection Situations)
          12: [64, 71], // Set 12: 8 questions (Special Warning Signs)
          13: [
            72,
            79,
          ], // Set 13: 8 questions (Strange situations, special auxiliary signs)
          14: [80, 89], // Set 14: 10 questions (Mixed and complex traffic)
          15: [90, 99], // Set 15: 10 questions (Advanced comprehensive review)
          16: [100, 109], // Set 16: 10 questions (Final review)
        },
        3: {
          // Unit 3: Defensive Driving (based on actual question counts)
          1: [0, 4], // Set 1: 5 questions (Keep your distance and observe)
          2: [5, 10], // Set 2: 6 questions (Identifying danger and reacting)
          3: [11, 16], // Set 3: 6 questions (Weather and special conditions)
          4: [
            17,
            23,
          ], // Set 4: 7 questions (Bad weather and handling situations)
          5: [24, 30], // Set 5: 7 questions (Collision prevention - simulation)
          6: [
            31,
            39,
          ], // Set 6: 9 questions (Defensive behavior – with other drivers)
          7: [40, 48], // Set 7: 9 questions (Advanced Summary)
        },
        4: {
          // Unit 4: Special Driving Situations (based on actual question counts)
          1: [
            0,
            4,
          ], // Set 1: 5 questions (Driving in rain, snow, slippery roads)
          2: [
            5,
            10,
          ], // Set 2: 6 questions (Driving at night and limited visibility)
          3: [
            11,
            16,
          ], // Set 3: 6 questions (Driving on steep hills and difficult terrain)
          4: [
            17,
            22,
          ], // Set 4: 6 questions (Driving on country roads, small roads)
          5: [23, 29], // Set 5: 7 questions (Driving in a crowded city)
          6: [
            30,
            36,
          ], // Set 6: 7 questions (Large vehicles - SUVs, trucks, trailers)
          7: [37, 42], // Set 7: 6 questions (Crossing the railway tracks)
          8: [43, 48], // Set 8: 6 questions (Turning, reversing and parking)
          9: [49, 55], // Set 9: 7 questions (Combining unusual situations)
          10: [56, 63], // Set 10: 8 questions (Advanced Summary & Simulation)
        },
        5: {
          // Unit 5: Sharing the Road (based on actual question counts)
          1: [0, 4], // Set 1: 5 questions (Pedestrians – Yield Rules)
          2: [
            5,
            10,
          ], // Set 2: 6 questions (Bicycles and motorbikes – Safe distance)
          3: [
            11,
            16,
          ], // Set 3: 6 questions (Buses, trucks – Driving around large vehicles)
          4: [
            17,
            22,
          ], // Set 4: 6 questions (Emergency Vehicles – Correct Handling)
          5: [
            23,
            28,
          ], // Set 5: 6 questions (Near Schools and Residential Areas)
          6: [29, 34], // Set 6: 6 questions (Polite behavior and yielding)
          7: [35, 40], // Set 7: 6 questions (Advanced synthesis & simulation)
        },
        6: {
          // Unit 6: Alcohol and Drugs (based on actual question counts)
          1: [
            0,
            4,
          ], // Set 1: 5 questions (Basics – Alcohol Concentrations and Effects)
          2: [
            5,
            10,
          ], // Set 2: 6 questions (Drugs and effects similar to alcohol)
          3: [11, 17], // Set 3: 7 questions (Laws and legal consequences)
          4: [
            18,
            25,
          ], // Set 4: 8 questions (Simulation scenarios – Behavioral judgment)
        },
      };

      // Get the range for this set
      final range = setRanges[categoryId]?[actualSetNumber];
      if (range == null) {
        throw Exception(
          'Invalid category or set number: categoryId=$categoryId, setNumber=$setNumber, actualSetNumber=$actualSetNumber',
        );
      }

      final startIndex = range[0];
      final endIndex = range[1];

      // Get all questions for this category
      final allQuestions = await getQuestionsByCategory(categoryId);
      if (allQuestions.isEmpty) {
  
        return [];
      }



      // Extract questions for this specific set
      final setQuestions = <Map<String, dynamic>>[];
      for (int i = startIndex; i <= endIndex && i < allQuestions.length; i++) {
        try {
          final question = Map<String, dynamic>.from(allQuestions[i]);
          setQuestions.add(question);
        } catch (e) {
          // Skip this question if there's an error
          continue;
        }
      }



      return setQuestions;
    } catch (e) {
      throw Exception('Error getting questions for set: $e');
    }
  }
}
