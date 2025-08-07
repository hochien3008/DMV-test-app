import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../utils/color.dart';
import 'dart:math' as math;
import '../providers/app_settings_provider.dart';

class ResultsScreen extends StatefulWidget {
  final Map<String, dynamic>? result;

  const ResultsScreen({super.key, this.result});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _starsController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _starsAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _starsController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
    _starsAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _starsController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
    _slideController.forward();
    _starsController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _starsController.dispose();
    super.dispose();
  }

  String _getPerformanceMessage(int score) {
    if (score >= 90) {
      return 'Excellent! You completed the test perfectly! 🌟';
    } else if (score >= 80) {
      return 'Great! You have a very good understanding of the concepts! 👍';
    } else if (score >= 70) {
      return 'Good! You have grasped most of the knowledge! 📚';
    } else if (score >= 60) {
      return 'Passed! You need to review a bit more! 📖';
    } else {
      return 'Needs improvement! Study again and try again! 💪';
    }
  }

  String _getPerformanceLevel(int score) {
    if (score >= 90) return 'Excellent';
    if (score >= 80) return 'Great';
    if (score >= 70) return 'Good';
    if (score >= 60) return 'Passed';
    return 'Needs Improvement';
  }

  Color _getPerformanceColor(int score) {
    if (score >= 90) return Colors.amber;
    if (score >= 80) return Colors.green;
    if (score >= 70) return Colors.blue;
    if (score >= 60) return Colors.orange;
    return Colors.red;
  }

  IconData _getPerformanceIcon(int score) {
    if (score >= 90) return Icons.star;
    if (score >= 80) return Icons.thumb_up;
    if (score >= 70) return Icons.school;
    if (score >= 60) return Icons.book;
    return Icons.trending_up;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.result == null) {
      return _buildEmptyState();
    }

    final totalQuestions = widget.result!['totalQuestions'] as int? ?? 0;
    final correctAnswers = widget.result!['correctAnswers'] as int? ?? 0;
    final score = (widget.result!['score'] as double? ?? 0.0).toInt();
    final categoryId = widget.result!['categoryId'] as int? ?? 1;
    final xpEarned = widget.result!['xpEarned'] as int? ?? 0;
    final maxXp = widget.result!['maxXp'] as int? ?? 100;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Stack(
        children: [
          // Animated stars background
          AnimatedBuilder(
            animation: _starsAnimation,
            builder: (context, child) {
              return CustomPaint(
                painter: StarsPainter(_starsAnimation.value),
                size: Size.infinite,
              );
            },
          ),

          // Main content
          Container(
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
            child: SafeArea(
              child: SingleChildScrollView(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      children: [
                        // Header
                        _buildHeader(),

                        // Score Card
                        _buildScoreCard(
                          score,
                          totalQuestions,
                          correctAnswers,
                          xpEarned,
                          maxXp,
                        ),

                        // Performance Analysis
                        _buildPerformanceAnalysis(score),

                        // Action Buttons
                        _buildActionButtons(),

                        // Bottom padding to prevent overflow
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF4A90E2).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'Quiz Results',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCard(
    int score,
    int totalQuestions,
    int correctAnswers,
    int xpEarned,
    int maxXp,
  ) {
    final performanceColor = _getPerformanceColor(score);
    final performanceIcon = _getPerformanceIcon(score);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: performanceColor.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          // Score Circle
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  performanceColor.withOpacity(0.8),
                  performanceColor.withOpacity(0.6),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: performanceColor.withOpacity(0.4),
                  blurRadius: 15,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(performanceIcon, color: Colors.white, size: 28),
                  const SizedBox(height: 6),
                  Text(
                    '$score%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // XP Display
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.amber.withOpacity(0.5),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      'XP Earned: $xpEarned / $maxXp',
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Consumer<AppSettingsProvider>(
                  builder: (context, appSettings, child) {
                    return Text(
                      'Total Profile XP: ${appSettings.totalXp}',
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Score Details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildScoreDetail('Correct', correctAnswers, Colors.green),
              _buildScoreDetail(
                'Wrong',
                totalQuestions - correctAnswers,
                Colors.red,
              ),
              _buildScoreDetail(
                'Total',
                totalQuestions,
                const Color(0xFF4A90E2),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScoreDetail(String label, int value, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$value',
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildPerformanceAnalysis(int score) {
    final performanceLevel = _getPerformanceLevel(score);
    final performanceMessage = _getPerformanceMessage(score);
    final performanceColor = _getPerformanceColor(score);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: performanceColor.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.analytics, color: performanceColor, size: 24),
              const SizedBox(width: 12),
              Text(
                'Performance Analysis',
                style: TextStyle(
                  color: performanceColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Performance Level
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: performanceColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              performanceLevel,
              style: TextStyle(
                color: performanceColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Performance Message
          Text(
            performanceMessage,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 16),

          // Level Up Notification
          Consumer<AppSettingsProvider>(
            builder: (context, appSettings, child) {
              if (appSettings.isLevelUp) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.amber.withOpacity(0.3),
                        Colors.orange.withOpacity(0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.amber.withOpacity(0.5)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '🎉 LEVEL UP!',
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'You are now ${appSettings.driverRank}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),

          // Recommendations
          _buildRecommendations(score),
        ],
      ),
    );
  }

  Widget _buildRecommendations(int score) {
    List<String> recommendations = [];

    if (score < 60) {
      recommendations = [
        '• Review all basic knowledge',
        '• Do more practice exercises',
        '• Review questions you got wrong',
      ];
    } else if (score < 80) {
      recommendations = [
        '• Focus on weaker topics',
        '• Do more quizzes to improve',
        '• Read traffic rules carefully',
      ];
    } else {
      recommendations = [
        '• Maintain current knowledge',
        '• Challenge yourself with harder questions',
        '• Share knowledge with others',
      ];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recommendations:',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...recommendations.map(
          (rec) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              rec,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          // Retry Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                // TODO: Start new quiz
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retake Quiz'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A90E2),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Home Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              icon: const Icon(Icons.home),
              label: const Text('Back to Home'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16213E),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A0A0A), Color(0xFF1A1A2E), Color(0xFF16213E)],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.quiz_outlined, size: 80, color: Colors.white70),
              SizedBox(height: 16),
              Text(
                'No Results Found',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Complete the quiz to see results',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
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
      ..color = Colors.white.withOpacity(0.3 + (0.2 * animationValue))
      ..style = PaintingStyle.fill;

    final random = math.Random(42);

    for (int i = 0; i < 100; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = 1 + (random.nextDouble() * 2);

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(StarsPainter oldDelegate) => true;
}
