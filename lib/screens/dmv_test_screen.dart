import 'dart:math';
import 'dart:typed_data';
import 'package:dmv_test/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../models/category.dart';
import '../services/question_service.dart';
import 'dmv_exam_screen.dart';
import '../providers/app_settings_provider.dart';
import 'dart:io';

// Widget tạo hiệu ứng các ngôi sao xếp thành hình thực hành lái xe (ví dụ hình chữ U) bằng for lồng nhau
class StarField extends StatelessWidget {
  final double width;
  final double height;

  const StarField({super.key, this.width = double.infinity, this.height = 180});

  @override
  Widget build(BuildContext context) {
    final screenWidth = width == double.infinity
        ? MediaQuery.of(context).size.width
        : width;

    List<Widget> stars = [];

    // Cạnh trái chữ U
    for (int i = 0; i < 4; i++) {
      // i chạy từ 0 đến 3, chia đều chiều cao
      double x = 0.10;
      double y = 0.15 + i * 0.20;
      stars.add(_buildStar(x, y, screenWidth, height));
    }

    // Đáy chữ U
    for (int i = 0; i < 3; i++) {
      // i chạy từ 0 đến 2, chia đều chiều rộng đáy
      double x = 0.25 + i * 0.20;
      double y = 0.85 + (i == 1 ? 0.05 : 0.0); // điểm giữa thấp hơn một chút
      stars.add(_buildStar(x, y, screenWidth, height));
    }

    // Cạnh phải chữ U
    for (int i = 0; i < 4; i++) {
      double x = 0.80;
      double y = 0.75 - i * 0.20;
      stars.add(_buildStar(x, y, screenWidth, height));
    }

    // Trả về Stack chứa các ngôi sao
    return SizedBox(
      width: width,
      height: height,
      child: Stack(children: stars),
    );
  }

  // Hàm tạo 1 ngôi sao tại vị trí tỉ lệ x, y
  Widget _buildStar(double x, double y, double screenWidth, double height) {
    return Positioned(
      left: x * screenWidth,
      top: y * height,
      child: Icon(
        Icons.star_rounded,
        color: Colors.white.withOpacity(1.0),
        size: 22.0,
        shadows: [
          Shadow(color: Colors.blueAccent.withOpacity(0.3), blurRadius: 8),
        ],
      ),
    );
  }
}

class DMVTestScreen extends StatefulWidget {
  const DMVTestScreen({super.key});

  @override
  State<DMVTestScreen> createState() => _DMVTestScreenState();
}

class _DMVTestScreenState extends State<DMVTestScreen>
    with TickerProviderStateMixin {
  List<Map<String, dynamic>> _dmvTestSets = [];
  bool _isLoading = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _loadDMVTestSets();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadDMVTestSets() async {
    try {
      final questionService = QuestionService();
      final allCategories = await questionService.getAllCategories();
      setState(() {
        // Show all categories as DMV test options
        _dmvTestSets = allCategories.map((category) {
          // Ensure the category has the required fields for the UI
          return {
            'id': category['id'],
            'name': category['name'] ?? 'DMV Test ${category['id']}',
            'description':
                category['description'] ?? 'DMV written test questions',
            'total_questions': category['total_questions'] ?? 25,
            'unit_number': category['unit_number'] ?? 1,
          };
        }).toList();
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading DMV test sets: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181C2E),
      body: SafeArea(
        child: Stack(
          children: [
            // Gradient nền galaxy
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF232B4D), Color(0xFF181C2E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            // Tầng tinh tú
            const StarField(height: 180),
            // Nội dung chính
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Consumer<AppSettingsProvider>(
                    builder: (context, appSettings, child) {
                      final displayName =
                          appSettings.userName ??
                          appSettings.driverRank ??
                          'Driver';
                      final profileImage = appSettings.userProfileImage;
                      final level = appSettings.currentLevel ?? 1;
                      final totalScore = appSettings.totalScore;
                      final completedSets = appSettings.getCompletedSetsCount();
                      final totalXp = appSettings.totalXp;

                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF232B4D), Color(0xFF1A1A2E)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                // Avatar với GestureDetector
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const ProfileScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: const Color(0xFF4A90E2),
                                        width: 3,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF4A90E2).withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: _buildProfileImage(appSettings),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        displayName,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          fontFamily: 'Lato',
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.emoji_events,
                                            color: Colors.amberAccent,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Level $level',
                                            style: const TextStyle(
                                              color: Colors.amberAccent,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                              fontFamily: 'Lato',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Stats row
                            Row(
                              children: [
                                Expanded(
                                  child: _buildStatCard(
                                    'Total Score',
                                    '$totalScore',
                                    Icons.star,
                                    Colors.yellowAccent,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildStatCard(
                                    'Completed',
                                    '$completedSets',
                                    Icons.check_circle,
                                    Colors.greenAccent,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildStatCard(
                                    'Total XP',
                                    '$totalXp',
                                    Icons.trending_up,
                                    Colors.blueAccent,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  // Header section
                  Row(
                    children: [
                      Icon(
                        Icons.quiz,
                        color: const Color(0xFFB8C7FF),
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'DMV Practice Tests',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFB8C7FF),
                          fontFamily: 'Lato',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Choose a test set to practice and improve your driving knowledge',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                      fontFamily: 'Lato',
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Test sets
                  ...List.generate(_dmvTestSets.length, (index) {
                    final testSet = _dmvTestSets[index];
                    return _buildEnhancedTestCard(testSet, index);
                  }),
                  const SizedBox(height: 24),
                  _buildProgressCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              fontFamily: 'Lato',
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontFamily: 'Lato',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage(AppSettingsProvider appSettings) {
    // First try to show image from database
    if (appSettings.userProfileImageData != null &&
        appSettings.userProfileImageData!.isNotEmpty) {
      return ClipOval(
        child: Image.memory(
          Uint8List.fromList(appSettings.userProfileImageData!),
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.person, color: Colors.white, size: 32),
        ),
      );
    }

    // Fallback to file path or asset
    final profileImage = appSettings.userProfileImage;
    if (profileImage != null && profileImage != 'default') {
      return ClipOval(
        child: profileImage.startsWith('/')
            ? Image.file(
                File(profileImage),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.person, color: Colors.white, size: 32),
              )
            : Image.asset(
                profileImage,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.person, color: Colors.white, size: 32),
              ),
      );
    }
    return const Icon(Icons.person, color: Colors.white, size: 32);
  }

  Widget _buildEnhancedTestCard(Map<String, dynamic> testSet, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF232B4D), Color(0xFF1A1A2E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFF4A90E2).withOpacity(0.2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4A90E2).withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => _startTest(testSet),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF6366F1), Color(0xFF4A90E2)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF6366F1).withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'Lato',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  testSet['name'] as String,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFB8C7FF),
                                    fontFamily: 'Lato',
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  testSet['description'] as String? ?? '',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF6B7280),
                                    fontFamily: 'Lato',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.question_answer_outlined,
                                  size: 16,
                                  color: const Color(0xFF6366F1),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${testSet['total_questions'] ?? 0} Questions',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF6366F1),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Lato',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4A90E2),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: 'Lato',
                              ),
                            ),
                            onPressed: () => _startTest(testSet),
                            child: const Text('START TEST'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressCard() {
    return Consumer<AppSettingsProvider>(
      builder: (context, appSettings, child) {
        final completedSets = appSettings.getCompletedSetsCount();
        final totalSets = _dmvTestSets.length;
        final progress = totalSets > 0 ? completedSets / totalSets : 0.0;
        
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xFF6366F1), Color(0xFF4A90E2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6366F1).withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.trending_up,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Your Progress',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Lato',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$completedSets/$totalSets',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato',
                          ),
                        ),
                        const Text(
                          'Tests Completed',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontFamily: 'Lato',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${(progress * 100).toInt()}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lato',
                        ),
                      ),
                      const Text(
                        'Completion',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontFamily: 'Lato',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  minHeight: 8,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _startTest(Map<String, dynamic> testSet) async {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);

    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(color: Color(0xFF4A90E2)),
        ),
      );

      // Start the quiz
      await quizProvider.startQuiz(testSet['id'] as int, questionCount: 25);

      // Close loading indicator
      if (mounted) Navigator.pop(context);

      // Navigate to exam screen
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DMVExamScreen(
              testSetId: testSet['id'] as int,
              testTitle: testSet['name'] as String? ?? 'DMV Test',
              totalQuestions: testSet['total_questions'] as int? ?? 25,
              timeLimit: 30, // 30 minutes for DMV test
            ),
          ),
        );
      }
    } catch (e) {
      // Close loading indicator if still showing
      if (mounted) Navigator.pop(context);

      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error starting test: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
