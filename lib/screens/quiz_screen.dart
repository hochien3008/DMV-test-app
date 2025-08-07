import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../models/question.dart';
import '../utils/color.dart';
import 'results_screen.dart';
import 'dart:math' as math;

class QuizScreen extends StatefulWidget {
  final int? categoryId;
  final int? questionSet;
  final bool? isStudyMode;

  const QuizScreen({
    super.key,
    this.categoryId,
    this.questionSet,
    this.isStudyMode,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  bool _showExplanation = false;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _pulseController;
  late AnimationController _starsController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _starsAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
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
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _starsAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _starsController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
    _slideController.forward();
    _pulseController.repeat(reverse: true);
    _starsController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
    _starsController.dispose();
    super.dispose();
  }

  String _getSetTitle(int setNumber) {
    final setTitles = {
      1: 'Set 1: Basics – Recognizing traffic laws',
      2: 'Set 2: Basics – Intersections and turns',
      3: 'Set 3: Easy – Stop, yield, park',
      4: 'Set 4: Average - Speed & Signs',
      5: 'Set 5: Moderate – Dangerous & the law of reflexes',
      6: 'Set 6: Medium – Turning, changing lanes, priority lanes',
      7: 'Set 7: Difficult - Priority rules and reflexes',
      8: 'Set 8: Difficult – Real-life simulation situation',
      9: 'Set 9: Difficult - Understanding the law & application',
      10: 'Set 10: Advanced Summary',
      11: 'Set 11: Simulation situations & test summary',
    };
    return setTitles[setNumber] ?? 'Question Set $setNumber';
  }

  Color _getSetColor(int setNumber) {
    // Sử dụng màu chủ đạo đồng bộ với HomeScreen
    return const Color(0xFF4A90E2); // Primary blue color from HomeScreen
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        if (!quizProvider.isQuizActive) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.quiz_outlined,
                    size: 80,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No active quiz',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please start a quiz from the home screen.',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final currentQuestion = quizProvider.currentQuestion;
        if (currentQuestion == null) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 80, color: AppColors.error),
                  const SizedBox(height: 16),
                  Text(
                    'No questions available',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final setNumber = widget.questionSet ?? 1;
        final setColor = _getSetColor(setNumber);
        final setTitle = _getSetTitle(setNumber);

        return Scaffold(
          backgroundColor: const Color(
            0xFF0A0A0A,
          ), // Deep space black background
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
                  child: Column(
                    children: [
                      // Custom App Bar
                      _buildCustomAppBar(quizProvider, setColor, setTitle),

                      // Progress Section
                      _buildProgressSection(quizProvider, setColor),

                      // Question Content
                      Expanded(
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: _buildQuestionContent(
                              quizProvider,
                              setColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCustomAppBar(
    QuizProvider quizProvider,
    Color setColor,
    String setTitle,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Back button
          Container(
            decoration: BoxDecoration(
              color: AppColors.overlayMedium,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowMedium,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textWhite),
              onPressed: () => _showExitDialog(context),
            ),
          ),

          const SizedBox(width: 16),

          // Set info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'UNIT 1: RULES OF THE ROAD',
                  style: TextStyle(
                    color: AppColors.background,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  setTitle,
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Question counter
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.overlayMedium,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowMedium,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  '${quizProvider.currentQuestionIndex + 1}/${quizProvider.totalQuestions}',
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${quizProvider.xpEarned} XP',
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

     
          if (quizProvider.isStudyMode) ...[
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.blue.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: IconButton(
                icon: const Icon(Icons.bug_report, color: Colors.blue, size: 20),
                onPressed: () => _debugAnswerOrder(quizProvider),
                tooltip: 'Debug Answer Order',
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProgressSection(QuizProvider quizProvider, Color setColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          // Progress bar
          Container(
            height: 12, // Tăng chiều cao
            decoration: BoxDecoration(
              color: AppColors.overlayDark, // Tăng độ đậm của background
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowMedium,
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: quizProvider.progress,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.textWhite, // Màu trắng đậm
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(
                        0xFF4A90E2,
                      ).withOpacity(0.6), // Tăng độ đậm của shadow
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Progress text
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress',
                style: TextStyle(
                  color: AppColors.textWhite, // Tăng độ đậm của text
                  fontSize: 14, // Tăng font size
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${(quizProvider.progress * 100).toInt()}%',
                style: const TextStyle(
                  color: AppColors.textWhite, // Tăng độ đậm của text
                  fontWeight: FontWeight.bold,
                  fontSize: 14, // Tăng font size
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionContent(QuizProvider quizProvider, Color setColor) {
    final currentQuestion = quizProvider.currentQuestion!;
    final answers = currentQuestion['answers'] as List<Map<String, dynamic>>;
    final selectedAnswer =
        quizProvider.userAnswers[quizProvider.currentQuestionIndex];

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(
          0xFF1A1A2E,
        ), // Navy blue background matching HomeScreen
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(
              0xFF4A90E2,
            ).withOpacity(0.3), // Consistent blue shadow
            blurRadius: 24,
            spreadRadius: 8,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Question header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(
                0xFF4A90E2,
              ).withOpacity(0.1), // Light blue overlay
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Row(
              children: [
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4A90E2), // Consistent blue
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF4A90E2,
                              ).withOpacity(0.4), // Consistent blue shadow
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.quiz,
                          color: AppColors.textWhite,
                          size: 24,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'Question',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Bright white text
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Question text
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              currentQuestion['question_text'] as String,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white, // Bright white text for better readability
                height: 1.5,
              ),
            ),
          ),

          // Answer options
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: answers.length,
              itemBuilder: (context, index) {
                final answer = answers[index];
                final isSelected = selectedAnswer == index;
                final isCorrect = answer['is_correct'] == 1;
                final showResult = selectedAnswer != -1;

                Color answerColor = const Color(
                  0xFF16213E,
                ); // Dark blue background
                Color borderColor = const Color(
                  0xFF4A90E2,
                ).withOpacity(0.5); // Brighter blue border
                Color textColor =
                    Colors.white; // Bright white text for dark theme

                if (showResult) {
                  if (isCorrect) {
                    answerColor = AppColors.success.withOpacity(0.1);
                    borderColor = AppColors.success;
                    textColor = AppColors.success;
                  } else if (isSelected && !isCorrect) {
                    answerColor = AppColors.error.withOpacity(0.1);
                    borderColor = AppColors.error;
                    textColor = AppColors.error;
                  }
                } else if (isSelected) {
                  answerColor = const Color(
                    0xFF4A90E2,
                  ).withOpacity(0.1); // Consistent blue
                  borderColor = const Color(0xFF4A90E2); // Consistent blue
                  textColor = const Color(0xFF4A90E2); // Consistent blue
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: selectedAnswer == -1
                          ? () => quizProvider.answerQuestion(index)
                          : null,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: answerColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: borderColor, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: borderColor.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Answer letter
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: showResult && isCorrect
                                    ? AppColors.success
                                    : isSelected
                                    ? const Color(0xFF4A90E2) // Consistent blue
                                    : AppColors.borderMedium,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        (showResult && isCorrect
                                                ? AppColors.success
                                                : isSelected
                                                ? const Color(
                                                    0xFF4A90E2,
                                                  ) // Consistent blue
                                                : AppColors.borderMedium)
                                            .withOpacity(0.3),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  String.fromCharCode(65 + index), // A, B, C, D
                                  style: TextStyle(
                                    color: showResult && isCorrect || isSelected
                                        ? AppColors.textWhite
                                        : Colors.white, // Bright white text
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 20),

                            // Answer text
                            Expanded(
                              child: Text(
                                answer['answer_text'] as String,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: textColor,
                                  fontWeight:
                                      isSelected || (showResult && isCorrect)
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                  height: 1.4,
                                ),
                              ),
                            ),

                            // Result icon
                            if (showResult)
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: isCorrect
                                      ? AppColors.success.withOpacity(0.1)
                                      : isSelected
                                      ? AppColors.error.withOpacity(0.1)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  isCorrect
                                      ? Icons.check_circle
                                      : isSelected
                                      ? Icons.cancel
                                      : null,
                                  color: isCorrect
                                      ? AppColors.success
                                      : isSelected
                                      ? AppColors.error
                                      : null,
                                  size: 24,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Navigation buttons
          _buildNavigationButtons(quizProvider, setColor),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons(QuizProvider quizProvider, Color setColor) {
    final isLastQuestion =
        quizProvider.currentQuestionIndex == quizProvider.totalQuestions - 1;
    final hasAnswered =
        quizProvider.userAnswers[quizProvider.currentQuestionIndex] != -1;

    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          // Previous button
          if (quizProvider.currentQuestionIndex > 0)
            Expanded(
              child: ElevatedButton(
                onPressed: () => quizProvider.previousQuestion(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFF16213E,
                  ), // Dark blue background
                  foregroundColor: AppColors.textWhite,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  shadowColor: AppColors.shadowMedium,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Previous',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),

          if (quizProvider.currentQuestionIndex > 0) const SizedBox(width: 16),

          // Next/Finish button
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: hasAnswered
                  ? (isLastQuestion
                        ? () => _finishQuiz(context, quizProvider)
                        : () => quizProvider.nextQuestion())
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: hasAnswered
                    ? const Color(0xFF4A90E2)
                    : const Color(0xFF0A0A0A), // Dark background for disabled
                foregroundColor: hasAnswered
                    ? AppColors.textWhite
                    : const Color(0xFF666666), // Gray text for disabled
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: hasAnswered ? 8 : 2,
                shadowColor: hasAnswered
                    ? const Color(0xFF4A90E2).withOpacity(0.4)
                    : AppColors.shadowLight,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLastQuestion ? 'Finish Quiz' : 'Next',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  if (!isLastQuestion) ...[
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, size: 20),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _finishQuiz(BuildContext context, QuizProvider quizProvider) async {
    try {
      final result = await quizProvider.finishQuiz(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ResultsScreen(result: result)),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error finishing quiz: $e')));
    }
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E), // Navy blue background
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Exit Quiz?',
          style: TextStyle(
            color: Colors.white, // White text for dark theme
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Are you sure you want to exit? Your progress will be lost.',
          style: TextStyle(color: const Color(0xFFCCCCCC)), // Light gray text
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Exit', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  // Debug method to test answer order consistency
  void _debugAnswerOrder(QuizProvider quizProvider) {
    if (quizProvider.isStudyMode) {
      quizProvider.debugAnswerOrder(quizProvider.currentQuestionIndex);
      
      // Show debug info in a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Debug info logged for question ${quizProvider.currentQuestionIndex + 1}',
            style: const TextStyle(fontSize: 12),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.blue,
        ),
      );
    }
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

    final random = math.Random(42); // Fixed seed for consistent stars

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
