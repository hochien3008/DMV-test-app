import 'package:dmv_test/screens/dmv_test_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import 'results_screen.dart';
import 'dart:async';

class DMVExamScreen extends StatefulWidget {
  final int testSetId;
  final String testTitle;
  final int totalQuestions;
  final int timeLimit; // in minutes

  const DMVExamScreen({
    super.key,
    required this.testSetId,
    required this.testTitle,
    required this.totalQuestions,
    this.timeLimit = 30, // Default 30 minutes
  });

  @override
  State<DMVExamScreen> createState() => _DMVExamScreenState();
}

class _DMVExamScreenState extends State<DMVExamScreen>
    with TickerProviderStateMixin {
  Timer? _timer;
  int _remainingSeconds = 0;
  bool _isTimerActive = true;
  Set<int> _bookmarkedQuestions = {};
  bool _showReviewMode = false;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.timeLimit * 60;
    _startTimer();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _fadeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
        _finishExam();
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Color _getTimerColor() {
    if (_remainingSeconds > 600) return const Color(0xFF10B981); // Green
    if (_remainingSeconds > 300) return const Color(0xFFF59E0B); // Yellow
    return const Color(0xFFEF4444); // Red
  }

  void _toggleBookmark(int questionIndex) {
    setState(() {
      if (_bookmarkedQuestions.contains(questionIndex)) {
        _bookmarkedQuestions.remove(questionIndex);
      } else {
        _bookmarkedQuestions.add(questionIndex);
      }
    });
  }

  void _finishExam() async {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    try {
      final result = await quizProvider.finishQuiz(context);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsScreen(result: result),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error finishing exam: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        if (!quizProvider.isQuizActive) {
          return _buildLoadingScreen();
        }

        final currentQuestion = quizProvider.currentQuestion;
        if (currentQuestion == null) {
          return _buildLoadingScreen();
        }

        return Scaffold(
          backgroundColor: const Color(0xFF181C2E),
          body: SafeArea(
            child: Stack(
              children: [
                // Gradient galaxy background
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF232B4D), Color(0xFF181C2E)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                // Star field background
                const StarField(height: 180),
                // Main content
                Column(
                  children: [
                    // Header with timer and progress
                    _buildHeader(quizProvider),
                    // Question content
                    Expanded(
                      child: _buildQuestionContent(quizProvider, currentQuestion),
                    ),
                  ],
                ),
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomNavigation(quizProvider),
        );
      },
    );
  }

  Widget _buildHeader(QuizProvider quizProvider) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Top row with back button and timer
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF4A90E2).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => _showExitConfirmation(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.testTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 16),
              // Timer
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _remainingSeconds <= 300 ? _pulseAnimation.value : 1.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: _getTimerColor().withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _getTimerColor(),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.timer,
                            color: _getTimerColor(),
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _formatTime(_remainingSeconds),
                            style: TextStyle(
                              color: _getTimerColor(),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: 'Lato',
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Progress bar
          _buildProgressBar(quizProvider),
        ],
      ),
    );
  }

  Widget _buildProgressBar(QuizProvider quizProvider) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Question ${quizProvider.currentQuestionIndex + 1} of ${quizProvider.totalQuestions}',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontFamily: 'Lato',
              ),
            ),
            Text(
              '${(quizProvider.progress * 100).toInt()}%',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontFamily: 'Lato',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: quizProvider.progress,
            backgroundColor: Colors.white.withOpacity(0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4A90E2)),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionContent(QuizProvider quizProvider, Map<String, dynamic> question) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        color: const Color(0xFF232B4D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A90E2).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Q${quizProvider.currentQuestionIndex + 1}',
                      style: const TextStyle(
                        color: Color(0xFF4A90E2),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      _bookmarkedQuestions.contains(quizProvider.currentQuestionIndex)
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: _bookmarkedQuestions.contains(quizProvider.currentQuestionIndex)
                          ? Colors.amber
                          : Colors.white70,
                    ),
                    onPressed: () => _toggleBookmark(quizProvider.currentQuestionIndex),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Question text
              Text(
                question['question'] as String? ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Lato',
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              // Answer options
              ..._buildAnswerOptions(quizProvider, question),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAnswerOptions(QuizProvider quizProvider, Map<String, dynamic> question) {
    final answers = question['answers'] as List<Map<String, dynamic>>? ?? [];
    final userAnswer = quizProvider.userAnswers[quizProvider.currentQuestionIndex];
    
    return answers.asMap().entries.map((entry) {
      final index = entry.key;
      final answer = entry.value;
      final isSelected = userAnswer == index;
      
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            quizProvider.answerQuestion(index);
            setState(() {});
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected 
                  ? const Color(0xFF4A90E2).withOpacity(0.2)
                  : Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected 
                    ? const Color(0xFF4A90E2)
                    : Colors.white.withOpacity(0.1),
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected 
                        ? const Color(0xFF4A90E2)
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected 
                          ? const Color(0xFF4A90E2)
                          : Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16,
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    answer['answer'] as String? ?? '',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontSize: 16,
                      fontFamily: 'Lato',
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildBottomNavigation(QuizProvider quizProvider) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF232B4D),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Previous button
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              onPressed: quizProvider.currentQuestionIndex > 0
                  ? () {
                      quizProvider.previousQuestion();
                      setState(() {});
                    }
                  : null,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Previous',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Lato',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Next/Finish button
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A90E2),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              onPressed: () {
                if (quizProvider.currentQuestionIndex < quizProvider.totalQuestions - 1) {
                  quizProvider.nextQuestion();
                  setState(() {});
                } else {
                  _showFinishConfirmation();
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    quizProvider.currentQuestionIndex < quizProvider.totalQuestions - 1
                        ? 'Next'
                        : 'Finish',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Lato',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    quizProvider.currentQuestionIndex < quizProvider.totalQuestions - 1
                        ? Icons.arrow_forward
                        : Icons.check,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showExitConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF232B4D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Exit Exam?',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
        content: const Text(
          'Are you sure you want to exit? Your progress will be lost.',
          style: TextStyle(
            color: Colors.white70,
            fontFamily: 'Lato',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Color(0xFF4A90E2),
                fontFamily: 'Lato',
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text(
              'Exit',
              style: TextStyle(
                fontFamily: 'Lato',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFinishConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF232B4D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Finish Exam?',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
        content: const Text(
          'Are you sure you want to finish the exam? You cannot go back once submitted.',
          style: TextStyle(
            color: Colors.white70,
            fontFamily: 'Lato',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Review More',
              style: TextStyle(
                color: Color(0xFF4A90E2),
                fontFamily: 'Lato',
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A90E2),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              _finishExam();
            },
            child: const Text(
              'Finish',
              style: TextStyle(
                fontFamily: 'Lato',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFF181C2E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF232B4D),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const CircularProgressIndicator(
                    color: Color(0xFF4A90E2),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Loading Exam...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.testTitle,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontFamily: 'Lato',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
