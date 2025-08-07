import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../services/database_service.dart';
import '../services/question_service.dart';
import 'question_loader.dart';

class DatabaseHelper {
  static final DatabaseService _databaseService = DatabaseService();
  static final QuestionService _questionService = QuestionService();

  // Khởi tạo database và load dữ liệu mẫu
  static Future<void> initializeDatabase() async {
    try {
  
      await _databaseService.database; // Ensure DB is created
      

      final categories = await _questionService.getAllCategories();
      

      // Check if there are any questions in the database
      final questions = await _questionService.getQuestionsByCategory(1);
      

      if (categories.isEmpty || questions.isEmpty) {
        
        // Only load sample data if DB is empty or has no questions
        await QuestionLoader.loadSampleQuestions(); // Updated to use QuestionLoader
        
      } else {
        
      }
    } catch (e) {
      
      rethrow;
    }
  }

  // Xóa database cũ và tạo lại
  static Future<void> resetDatabase() async {
    try {
      String path = join(await getDatabasesPath(), 'dmv_test.db');
      await deleteDatabase(path);
      
      await initializeDatabase();
      
    } catch (e) {
      
    }
  }

  // Demo các chức năng database
  static Future<void> demoDatabaseFunctions() async {
    try {
      // Demo các chức năng database
      // 1. Lấy tất cả categories
      final categories = await _questionService.getAllCategories();

      // 2. Lấy câu hỏi theo category
      if (categories.isNotEmpty) {
        await _questionService.getQuestionsByCategory(1);
      }

      // 3. Tạo quiz ngẫu nhiên
      await _questionService.getRandomQuestionsForQuiz(1, 5);

      // 4. Thống kê
      await _questionService.getStatistics();
    } catch (e) {
      // Demo error
    }
  }

  // Export dữ liệu
  static Future<void> exportData() async {
    try {
      final questions = await _questionService.exportQuestionsToJson();
      // Có thể lưu vào file JSON
      // final jsonString = jsonEncode(questions);
      // await File('exported_questions.json').writeAsString(jsonString);
    } catch (e) {
      // Export error
    }
  }

  // Import dữ liệu
  static Future<void> importData() async {
    try {
      // Có thể import từ file JSON
      // final jsonString = await File('exported_questions.json').readAsString();
      // final questions = jsonDecode(jsonString) as List;
      // await _questionService.importQuestionsFromJson(questions);

    } catch (e) {
      // Import error
    }
  }

  // Xóa tất cả dữ liệu
  static Future<void> clearAllData() async {
    try {
      final db = await _databaseService.database;
      await db.delete('quiz_results');
      await db.delete('user_progress');
      await db.delete('answers');
      await db.delete('questions');
      await db.delete('categories');

    } catch (e) {
      // Clear data error
    }
  }

  // Backup database
  static Future<void> backupDatabase() async {
    try {
      // Có thể copy file database
      // final sourcePath = join(await getDatabasesPath(), 'dmv_test.db');
      // final backupPath = join(await getDatabasesPath(), 'dmv_test_backup.db');
      // await File(sourcePath).copy(backupPath);

    } catch (e) {
      // Backup error
    }
  }
}
