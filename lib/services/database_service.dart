import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'dmv_test.db');
    return await openDatabase(
      path,
      version: 5,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Bảng categories (đơn vị học tập)
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT,
        unit_number INTEGER NOT NULL,
        total_questions INTEGER DEFAULT 0,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Bảng questions (câu hỏi)
    await db.execute('''
      CREATE TABLE questions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_id INTEGER NOT NULL,
        question_text TEXT NOT NULL,
        question_type TEXT DEFAULT 'multiple_choice',
        difficulty_level INTEGER DEFAULT 1,
        explanation TEXT,
        image_path TEXT,
        is_active BOOLEAN DEFAULT 1,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (category_id) REFERENCES categories (id)
      )
    ''');

    // Bảng answers (đáp án)
    await db.execute('''
      CREATE TABLE answers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question_id INTEGER NOT NULL,
        answer_text TEXT NOT NULL,
        is_correct BOOLEAN DEFAULT 0,
        order_index INTEGER DEFAULT 0,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (question_id) REFERENCES questions (id)
      )
    ''');

    // Bảng user_progress (tiến độ học tập)
    await db.execute('''
      CREATE TABLE user_progress (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_id INTEGER NOT NULL,
        questions_answered INTEGER DEFAULT 0,
        correct_answers INTEGER DEFAULT 0,
        last_attempted TIMESTAMP,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (category_id) REFERENCES categories (id)
      )
    ''');

    // Bảng quiz_results (kết quả bài thi)
    await db.execute('''
      CREATE TABLE quiz_results (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_id INTEGER,
        total_questions INTEGER NOT NULL,
        correct_answers INTEGER NOT NULL,
        score REAL NOT NULL,
        time_taken INTEGER,
        completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (category_id) REFERENCES categories (id)
      )
    ''');

    // Bảng users (thông tin người dùng)
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        profile_image_path TEXT,
        selected_state TEXT,
        selected_license_type TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Bảng profile_images (lưu hình ảnh dưới dạng BLOB)
    await db.execute('''
      CREATE TABLE profile_images (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        image_data BLOB NOT NULL,
        image_type TEXT DEFAULT 'image/png',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users (id)
      )
    ''');

    // Insert default categories
    await _insertDefaultCategories(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Fix quiz_results table column name
      try {
        // Check if the column exists
        final columns = await db.query('quiz_results', limit: 1);
        if (columns.isNotEmpty) {
          // If table has data, we need to recreate it
          await db.execute('DROP TABLE IF EXISTS quiz_results');
          await db.execute('''
            CREATE TABLE quiz_results (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              category_id INTEGER,
              total_questions INTEGER NOT NULL,
              correct_answers INTEGER NOT NULL,
              score REAL NOT NULL,
              time_taken INTEGER,
              completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
              FOREIGN KEY (category_id) REFERENCES categories (id)
            )
          ''');
        }
      } catch (e) {
        // If table doesn't exist, create it
        await db.execute('''
          CREATE TABLE quiz_results (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            category_id INTEGER,
            total_questions INTEGER NOT NULL,
            correct_answers INTEGER NOT NULL,
            score REAL NOT NULL,
            time_taken INTEGER,
            completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (category_id) REFERENCES categories (id)
          )
        ''');
      }
    }

    if (oldVersion < 3) {
      // Add users table
      await db.execute('''
        CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          profile_image_path TEXT,
          selected_state TEXT,
          selected_license_type TEXT,
          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // Add profile_images table
      await db.execute('''
        CREATE TABLE profile_images (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER NOT NULL,
          image_data BLOB NOT NULL,
          image_type TEXT DEFAULT 'image/png',
          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (user_id) REFERENCES users (id)
        )
      ''');
    }

    if (oldVersion < 4) {
      // Update users table to use profile_image_path instead of profile_image
      try {
        await db.execute(
          'ALTER TABLE users RENAME COLUMN profile_image TO profile_image_path',
        );
      } catch (e) {
        // Column might already be renamed or not exist
      }
    }
  }

  Future<void> _insertDefaultCategories(Database db) async {
    final categories = [
      {
        'name': 'Rules of the Road',
        'description': 'Basic traffic rules and regulations',
        'unit_number': 1,
        'total_questions': 11,
      },
      {
        'name': 'Traffic Control',
        'description': 'Traffic signals, signs, and control devices',
        'unit_number': 2,
        'total_questions': 16,
      },
      {
        'name': 'Defensive Driving',
        'description': 'Safe driving techniques and hazard awareness',
        'unit_number': 3,
        'total_questions': 7,
      },
      {
        'name': 'Special Driving Situations',
        'description': 'Emergency situations and special conditions',
        'unit_number': 4,
        'total_questions': 10,
      },
      {
        'name': 'Sharing the Road',
        'description': 'Interacting with other road users',
        'unit_number': 5,
        'total_questions': 7,
      },
      {
        'name': 'Alcohol and Drugs',
        'description': 'DUI laws and substance abuse awareness',
        'unit_number': 6,
        'total_questions': 4,
      },
    ];

    for (var category in categories) {
      await db.insert('categories', category);
    }
  }

  // CRUD Operations for Categories
  Future<List<Map<String, dynamic>>> getAllCategories() async {
    final db = await database;
    return await db.query('categories', orderBy: 'unit_number');
  }

  Future<Map<String, dynamic>?> getCategoryById(int id) async {
    final db = await database;
    final results = await db.query(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<int> insertCategory(Map<String, dynamic> category) async {
    final db = await database;
    return await db.insert('categories', category);
  }

  Future<int> updateCategory(Map<String, dynamic> category) async {
    final db = await database;
    return await db.update(
      'categories',
      category,
      where: 'id = ?',
      whereArgs: [category['id']],
    );
  }

  Future<int> deleteCategory(int id) async {
    final db = await database;
    return await db.delete('categories', where: 'id = ?', whereArgs: [id]);
  }

  // CRUD Operations for Questions
  Future<List<Map<String, dynamic>>> getQuestionsByCategory(
    int categoryId,
  ) async {
    final db = await database;
    return await db.query(
      'questions',
      where: 'category_id = ? AND is_active = 1',
      whereArgs: [categoryId],
      orderBy: 'id',
    );
  }

  Future<List<Map<String, dynamic>>> getRandomQuestions(
    int categoryId,
    int limit,
  ) async {
    final db = await database;
    return await db.rawQuery(
      '''
      SELECT * FROM questions 
      WHERE category_id = ? AND is_active = 1 
      ORDER BY RANDOM() 
      LIMIT ?
    ''',
      [categoryId, limit],
    );
  }

  Future<Map<String, dynamic>?> getQuestionById(int id) async {
    final db = await database;
    final results = await db.query(
      'questions',
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<int> insertQuestion(Map<String, dynamic> question) async {
    final db = await database;
    return await db.insert('questions', question);
  }

  Future<int> updateQuestion(Map<String, dynamic> question) async {
    final db = await database;
    return await db.update(
      'questions',
      question,
      where: 'id = ?',
      whereArgs: [question['id']],
    );
  }

  Future<int> deleteQuestion(int id) async {
    final db = await database;
    return await db.delete('questions', where: 'id = ?', whereArgs: [id]);
  }

  // CRUD Operations for Answers
  Future<List<Map<String, dynamic>>> getAnswersByQuestion(
    int questionId,
  ) async {
    final db = await database;
    return await db.query(
      'answers',
      where: 'question_id = ?',
      whereArgs: [questionId],
      orderBy: 'order_index',
    );
  }

  Future<int> insertAnswer(Map<String, dynamic> answer) async {
    final db = await database;
    return await db.insert('answers', answer);
  }

  Future<int> updateAnswer(Map<String, dynamic> answer) async {
    final db = await database;
    return await db.update(
      'answers',
      answer,
      where: 'id = ?',
      whereArgs: [answer['id']],
    );
  }

  Future<int> deleteAnswer(int id) async {
    final db = await database;
    return await db.delete('answers', where: 'id = ?', whereArgs: [id]);
  }

  // User Progress Operations
  Future<Map<String, dynamic>?> getUserProgress(int categoryId) async {
    final db = await database;
    final results = await db.query(
      'user_progress',
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<void> updateUserProgress(
    int categoryId,
    int questionsAnswered,
    int correctAnswers,
  ) async {
    final db = await database;
    final progress = await getUserProgress(categoryId);

    if (progress != null) {
      await db.update(
        'user_progress',
        {
          'questions_answered':
              progress['questions_answered'] + questionsAnswered,
          'correct_answers': progress['correct_answers'] + correctAnswers,
          'last_attempted': DateTime.now().toIso8601String(),
        },
        where: 'category_id = ?',
        whereArgs: [categoryId],
      );
    } else {
      await db.insert('user_progress', {
        'category_id': categoryId,
        'questions_answered': questionsAnswered,
        'correct_answers': correctAnswers,
        'last_attempted': DateTime.now().toIso8601String(),
      });
    }
  }

  // Quiz Results Operations
  Future<int> saveQuizResult(Map<String, dynamic> result) async {
    final db = await database;
    return await db.insert('quiz_results', result);
  }

  Future<List<Map<String, dynamic>>> getQuizHistory() async {
    final db = await database;
    return await db.query(
      'quiz_results',
      orderBy: 'completed_at DESC',
      limit: 50,
    );
  }

  Future<List<Map<String, dynamic>>> getQuizHistoryByCategory(
    int categoryId,
  ) async {
    final db = await database;
    return await db.query(
      'quiz_results',
      where: 'category_id = ?',
      whereArgs: [categoryId],
      orderBy: 'completed_at DESC',
    );
  }

  // Utility Methods
  Future<int> getQuestionCount(int categoryId) async {
    final db = await database;
    final result = await db.rawQuery(
      '''
      SELECT COUNT(*) as count FROM questions 
      WHERE category_id = ? AND is_active = 1
    ''',
      [categoryId],
    );
    return result.first['count'] as int;
  }

  Future<double> getAverageScore(int categoryId) async {
    final db = await database;
    final result = await db.rawQuery(
      '''
      SELECT AVG(score) as avg_score FROM quiz_results 
      WHERE category_id = ?
    ''',
      [categoryId],
    );
    return (result.first['avg_score'] as double?) ?? 0.0;
  }

  // Import/Export Methods
  Future<void> importQuestions(List<Map<String, dynamic>> questions) async {
    final db = await database;
    await db.transaction((txn) async {
      for (var question in questions) {
        final questionId = await txn.insert('questions', question);

        // Insert answers if provided
        if (question['answers'] != null) {
          for (var answer in question['answers']) {
            answer['question_id'] = questionId;
            await txn.insert('answers', answer);
          }
        }
      }
    });
  }

  Future<List<Map<String, dynamic>>> exportQuestions() async {
    final db = await database;
    final questions = await db.query('questions');
    final result = <Map<String, dynamic>>[];

    for (var question in questions) {
      final answers = await getAnswersByQuestion(question['id'] as int);
      question['answers'] = answers;
      result.add(question);
    }

    return result;
  }

  // CRUD Operations for Users
  Future<Map<String, dynamic>?> getCurrentUser() async {
    final db = await database;
    final results = await db.query(
      'users',
      orderBy: 'created_at DESC',
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<int> createUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert('users', user);
  }

  Future<int> updateUser(Map<String, dynamic> user) async {
    final db = await database;
    user['updated_at'] = DateTime.now().toIso8601String();
    return await db.update(
      'users',
      user,
      where: 'id = ?',
      whereArgs: [user['id']],
    );
  }

  Future<int> updateUserProfile(
    int userId,
    Map<String, dynamic> profile,
  ) async {
    final db = await database;
    profile['updated_at'] = DateTime.now().toIso8601String();
    return await db.update(
      'users',
      profile,
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  Future<void> saveUserOnboarding({
    required String name,
    String? profileImagePath,
    required String selectedState,
    required String selectedLicenseType,
  }) async {
    final db = await database;

    // Check if user already exists
    final existingUser = await getCurrentUser();

    if (existingUser != null) {
      // Update existing user
      await updateUserProfile(existingUser['id'], {
        'name': name,
        'profile_image_path': profileImagePath,
        'selected_state': selectedState,
        'selected_license_type': selectedLicenseType,
      });

      // Save profile image to database if provided
      if (profileImagePath != null && profileImagePath.isNotEmpty) {
        await _saveProfileImageToDatabase(existingUser['id'], profileImagePath);
      }
    } else {
      // Create new user
      final userId = await createUser({
        'name': name,
        'profile_image_path': profileImagePath,
        'selected_state': selectedState,
        'selected_license_type': selectedLicenseType,
      });

      // Save profile image to database if provided
      if (profileImagePath != null && profileImagePath.isNotEmpty) {
        await _saveProfileImageToDatabase(userId, profileImagePath);
      }
    }
  }

  Future<void> _saveProfileImageToDatabase(int userId, String imagePath) async {
    try {
      final db = await database;
      final File imageFile = File(imagePath);

      if (await imageFile.exists()) {
        final List<int> imageBytes = await imageFile.readAsBytes();

        // Delete existing profile image for this user
        await db.delete(
          'profile_images',
          where: 'user_id = ?',
          whereArgs: [userId],
        );

        // Insert new profile image
        await db.insert('profile_images', {
          'user_id': userId,
          'image_data': imageBytes,
          'image_type': 'image/png',
        });
      } else {}
    } catch (e) {}
  }

  Future<List<int>?> getProfileImageFromDatabase(int userId) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> results = await db.query(
        'profile_images',
        where: 'user_id = ?',
        whereArgs: [userId],
        orderBy: 'created_at DESC',
        limit: 1,
      );

      if (results.isNotEmpty) {
        final imageData = results.first['image_data'] as List<int>;

        return imageData;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  // Close database
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
