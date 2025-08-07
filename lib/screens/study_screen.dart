import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../services/question_service.dart';
import 'quiz_screen.dart';
import 'dart:math' as math;

class StudyScreen extends StatefulWidget {
  const StudyScreen({super.key});

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen>
    with TickerProviderStateMixin {
  List<Map<String, dynamic>> _questionSets = [];
  bool _isLoading = true;
  late AnimationController _starsController;
  late Animation<double> _starsAnimation;

  @override
  void initState() {
    super.initState();
    _loadQuestionSets();

    // Stars twinkling animation
    _starsController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _starsAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _starsController, curve: Curves.easeInOut),
    );
    _starsController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _starsController.dispose();
    super.dispose();
  }

  Future<void> _loadQuestionSets() async {
    try {
      final questionService = QuestionService();
      final questions = await questionService.getQuestionsByCategory(
        1,
      ); // Unit 1

      // Group questions into sets based on the new structure
      final sets = [
        {
          'name': 'Set 1: Basics – Recognizing traffic laws',
          'description': '3 questions about basic traffic laws',
          'questionCount': 3,
          'difficulty': 'Easy',
          'color': Colors.green,
          'icon': Icons.traffic,
        },
        {
          'name': 'Set 2: Basics – Intersections and turns',
          'description': '4 questions about intersections and turning',
          'questionCount': 4,
          'difficulty': 'Easy',
          'color': Colors.blue,
          'icon': Icons.turn_right,
        },
        {
          'name': 'Set 3: Easy – Stop, yield, park',
          'description': '5 questions about stopping, yielding, and parking',
          'questionCount': 5,
          'difficulty': 'Easy',
          'color': Colors.orange,
          'icon': Icons.stop,
        },
        {
          'name': 'Set 4: Average - Speed & Signs',
          'description': '6 questions about speed limits and traffic signs',
          'questionCount': 6,
          'difficulty': 'Medium',
          'color': Colors.purple,
          'icon': Icons.speed,
        },
        {
          'name': 'Set 5: Moderate – Dangerous & the law of reflexes',
          'description': '6 questions about dangerous situations and reflexes',
          'questionCount': 6,
          'difficulty': 'Medium',
          'color': Colors.red,
          'icon': Icons.warning,
        },
        {
          'name': 'Set 6: Medium – Turning, changing lanes, priority lanes',
          'description': '7 questions about lane changes and priority',
          'questionCount': 7,
          'difficulty': 'Medium',
          'color': Colors.indigo,
          'icon': Icons.swap_horiz,
        },
        {
          'name': 'Set 7: Difficult - Priority rules and reflexes',
          'description': '7 questions about priority rules and reflexes',
          'questionCount': 7,
          'difficulty': 'Hard',
          'color': Colors.deepPurple,
          'icon': Icons.priority_high,
        },
        {
          'name': 'Set 8: Difficult – Real-life simulation situation',
          'description': '8 questions about real-life driving situations',
          'questionCount': 8,
          'difficulty': 'Hard',
          'color': Colors.teal,
          'icon': Icons.drive_eta,
        },
        {
          'name': 'Set 9: Difficult - Understanding the law & application',
          'description': '8 questions about understanding and applying laws',
          'questionCount': 8,
          'difficulty': 'Hard',
          'color': Colors.cyan,
          'icon': Icons.gavel,
        },
        {
          'name': 'Set 10: Advanced Summary',
          'description': '6 questions for advanced summary',
          'questionCount': 6,
          'difficulty': 'Expert',
          'color': Colors.amber,
          'icon': Icons.star,
        },
        {
          'name': 'Set 11: Simulation situations & test summary',
          'description': '6 questions for final test preparation',
          'questionCount': 6,
          'difficulty': 'Expert',
          'color': Colors.pink,
          'icon': Icons.psychology,
        },
      ];

      setState(() {
        _questionSets = sets;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A0A0A), // Deep space black
              Color(0xFF1A1A2E), // Navy blue
              Color(0xFF16213E), // Dark blue
            ],
          ),
        ),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF4A90E2),
                  backgroundColor: Color(0xFF1A1A2E),
                ),
              )
            : Stack(
                children: [
                  // Animated stars background
                  _buildStarsBackground(),

                  // Main content
                  SafeArea(
                    child: Column(
                      children: [
                        // Header
                        _buildHeader(),

                        // Question Sets Grid
                        Expanded(child: _buildQuestionSetsGrid()),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildStarsBackground() {
    return AnimatedBuilder(
      animation: _starsAnimation,
      builder: (context, child) {
        return CustomPaint(
          painter: StarsPainter(_starsAnimation.value),
          size: Size.infinite,
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A90E2).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF4A90E2).withOpacity(0.4),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.school,
                  color: Color(0xFF4A90E2),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'UNIT 1: RULES OF THE ROAD',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Master the fundamentals of safe driving',
                      style: TextStyle(color: Color(0xFFB0B0B0), fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E).withOpacity(0.8),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF4A90E2).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: const Color(0xFF4A90E2),
                  size: 20,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Complete each set to unlock the next. Each star represents a set of questions designed to build your knowledge progressively.',
                    style: TextStyle(color: Color(0xFFB0B0B0), fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionSetsGrid() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: _questionSets.length,
        itemBuilder: (context, index) {
          final set = _questionSets[index];
          return _buildQuestionSetCard(set, index);
        },
      ),
    );
  }

  Widget _buildQuestionSetCard(Map<String, dynamic> set, int index) {
    final isUnlocked =
        index == 0 || index <= 3; // First 4 sets unlocked initially

    return GestureDetector(
      onTap: isUnlocked ? () => _startQuestionSet(index + 1) : null,
      child: Container(
        decoration: BoxDecoration(
          color: isUnlocked
              ? set['color'].withOpacity(0.2)
              : Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isUnlocked
                ? set['color'].withOpacity(0.6)
                : Colors.grey.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: isUnlocked
              ? [
                  BoxShadow(
                    color: set['color'].withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Star Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isUnlocked
                      ? set['color'].withOpacity(0.3)
                      : Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isUnlocked ? set['icon'] : Icons.lock,
                  color: isUnlocked ? set['color'] : Colors.grey,
                  size: 32,
                ),
              ),
              const SizedBox(height: 12),

              // Set Name
              Text(
                set['name'],
                style: TextStyle(
                  color: isUnlocked ? Colors.white : Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              // Question Count
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isUnlocked
                      ? set['color'].withOpacity(0.3)
                      : Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${set['questionCount']} questions',
                  style: TextStyle(
                    color: isUnlocked ? set['color'] : Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Difficulty
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _getDifficultyColor(
                    set['difficulty'],
                  ).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  set['difficulty'],
                  style: TextStyle(
                    color: _getDifficultyColor(set['difficulty']),
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Easy':
        return Colors.green;
      case 'Medium':
        return Colors.orange;
      case 'Hard':
        return Colors.red;
      case 'Expert':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  void _startQuestionSet(int setNumber) {
    // Navigate to quiz screen with specific set
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizScreen(
          categoryId: 1,
          questionSet: setNumber,
          isStudyMode: true,
        ),
      ),
    );
  }
}

// Stars background painter
class StarsPainter extends CustomPainter {
  final double animationValue;

  StarsPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3 * animationValue)
      ..style = PaintingStyle.fill;

    final random = math.Random(42); // Fixed seed for consistent stars

    for (int i = 0; i < 50; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 2 + 1;

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
