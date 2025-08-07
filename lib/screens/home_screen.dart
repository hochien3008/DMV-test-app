import 'package:dmv_test/screens/profile_screen.dart';
import 'package:dmv_test/screens/settings_screeen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:typed_data';
import '../providers/app_settings_provider.dart';
import '../providers/quiz_provider.dart';
import '../utils/color.dart';
import '../services/question_service.dart';
import 'quiz_screen.dart';
import 'results_screen.dart';
import 'statistics_screen.dart';
import 'favorites_screen.dart';
import 'search_screen.dart';
import 'faq_screen.dart';
import 'manual_screen.dart';
import 'traffic_signs_screen.dart';
import 'profile_screen.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  List<Map<String, dynamic>> _categories = [];
  bool _isLoading = true;
  int _completedQuizzes = 0;
  int _playerLevel = 1;
  int _experience = 0;
  int _maxExperience = 100;
  String _pilotRank = 'Rookie Driver';
  late AnimationController _starsController;
  late AnimationController _missionController;
  late AnimationController _pulseController;
  late Animation<double> _starsAnimation;
  late Animation<double> _missionAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadCategories();
    _loadCompletedQuizzes();
    _calculatePlayerStats();

    // Initialize animations
    _starsController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _missionController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _starsAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _starsController, curve: Curves.easeInOut),
    );
    _missionAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _missionController, curve: Curves.easeInOut),
    );
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _starsController.repeat(reverse: true);
    _missionController.repeat(reverse: true);
    _pulseController.repeat(reverse: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Recalculate player stats when dependencies change (e.g., returning from quiz)
    // Add a small delay to ensure XP is saved
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _calculatePlayerStats();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _starsController.dispose();
    _missionController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _loadCategories() async {
    try {
      final questionService = QuestionService();
      final categories = await questionService.getAllCategories();
      setState(() {
        _categories = categories;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadCompletedQuizzes() async {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final results = await quizProvider.getQuizResults();
    setState(() {
      _completedQuizzes = results.length;
    });
  }

  void _calculatePlayerStats() {
    // Calculate player level based on unit completion
    final appSettings = Provider.of<AppSettingsProvider>(
      context,
      listen: false,
    );

    // Check if Unit 1 is completed
    bool unit1Completed = true;
    for (int i = 1; i <= 11; i++) {
      final setXp = appSettings.getSetXp(i) ?? 0;
      if (setXp < 100) {
        unit1Completed = false;
        break;
      }
    }

    // Check if Unit 2 is completed
    bool unit2Completed = true;
    for (int i = 101; i <= 116; i++) {
      final setXp = appSettings.getSetXp(i) ?? 0;
      if (setXp < 100) {
        unit2Completed = false;
        break;
      }
    }

    // Check if Unit 3 is completed
    bool unit3Completed = true;
    for (int i = 201; i <= 207; i++) {
      final setXp = appSettings.getSetXp(i) ?? 0;
      if (setXp < 100) {
        unit3Completed = false;
        break;
      }
    }

    // Calculate level based on completed units
    if (unit3Completed) {
      _playerLevel = 4; // Unit 4 unlocked
    } else if (unit2Completed) {
      _playerLevel = 3; // Unit 3 unlocked
    } else if (unit1Completed) {
      _playerLevel = 2; // Unit 2 unlocked
    } else {
      _playerLevel = 1; // Only Unit 1 available
    }

    // Calculate experience based on total XP
    final totalXp = appSettings.totalXp;
    _experience = totalXp % 100;
    _maxExperience = 100;

    // Update pilot rank based on level
    if (_playerLevel >= 10) {
      _pilotRank = 'Space Captain';
    } else if (_playerLevel >= 7) {
      _pilotRank = 'Senior Pilot';
    } else if (_playerLevel >= 4) {
      _pilotRank = 'Experienced Driver';
    } else if (_playerLevel >= 2) {
      _pilotRank = 'Trainee Pilot';
    } else {
      _pilotRank = 'Rookie Driver';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
          ),
        ),
        child: Stack(
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
            SafeArea(
              child: Column(
                children: [
                  // Profile Section
                  _buildPilotHeader(),

                  // Mission Objective
                  _buildMissionObjective(),

                  // Units Section
                  Expanded(child: _buildProgressionMap()),
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

  Widget _buildPilotHeader() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            // Pilot Avatar
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4A90E2), Color(0xFF7B68EE)],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4A90E2).withOpacity(0.5),
                    blurRadius: 15,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Consumer<AppSettingsProvider>(
                builder: (context, appSettings, child) {
                  // First try to show image from database
                  if (appSettings.userProfileImageData != null &&
                      appSettings.userProfileImageData!.isNotEmpty) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.memory(
                        Uint8List.fromList(appSettings.userProfileImageData!),
                        width: 52,
                        height: 52,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.face,
                            color: Colors.white,
                            size: 52,
                          );
                        },
                      ),
                    );
                  }

                  // Fallback to file path or asset
                  if (appSettings.userProfileImage != null &&
                      appSettings.userProfileImage != 'default') {
                    // Check if it's a file path
                    if (appSettings.userProfileImage!.startsWith('/')) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          File(appSettings.userProfileImage!),
                          width: 52,
                          height: 52,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.face,
                              color: Colors.white,
                              size: 52,
                            );
                          },
                        ),
                      );
                    } else {
                      // Asset image
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          appSettings.userProfileImage!,
                          width: 52,
                          height: 52,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.face,
                              color: Colors.white,
                              size: 52,
                            );
                          },
                        ),
                      );
                    }
                  }
                  return const Icon(Icons.face, color: Colors.white, size: 52);
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<AppSettingsProvider>(
                    builder: (context, appSettings, child) {
                      final displayName =
                          appSettings.userName ?? appSettings.driverRank;
                      return Text(
                        displayName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      );
                    },
                  ),
                  Consumer<AppSettingsProvider>(
                    builder: (context, appSettings, child) {
                      return Text(
                        'Level ${appSettings.currentLevel} • XP: ${appSettings.currentLevelXp}/100',
                        style: const TextStyle(
                          color: Color(0xFFB0B0B0),
                          fontSize: 14,
                        ),
                      );
                    },
                  ),
                  Consumer<AppSettingsProvider>(
                    builder: (context, appSettings, child) {
                      final potentialXp = appSettings.getPotentialXp();
                      if (potentialXp > 0) {
                        return Text(
                          'Total: ${appSettings.totalXp} XP • +${potentialXp} potential',
                          style: const TextStyle(
                            color: Color(0xFF4A90E2),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
            // Profile Button
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A90E2).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF4A90E2).withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.settings,
                  color: Color(0xFF4A90E2),
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissionObjective() {
    return AnimatedBuilder(
      animation: _missionAnimation,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(
                  0xFF4A90E2,
                ).withOpacity(0.3 + (_missionAnimation.value * 0.2)),
                const Color(
                  0xFF7B68EE,
                ).withOpacity(0.2 + (_missionAnimation.value * 0.1)),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF4A90E2).withOpacity(0.6),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4A90E2).withOpacity(0.4),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A90E2).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.school,
                      color: Colors.amber,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Learning Mission',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Complete levels to unlock advanced challenges',
                style: TextStyle(color: Color(0xFFB0B0B0), fontSize: 14),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildAchievementBadge(
                      'Perfect Score',
                      Icons.star,
                      Colors.amber,
                    ),
                    const SizedBox(width: 8),
                    _buildAchievementBadge(
                      'Speed Runner',
                      Icons.timer,
                      Colors.green,
                    ),
                    const SizedBox(width: 8),
                    _buildAchievementBadge(
                      'Knowledge',
                      Icons.psychology,
                      Colors.purple,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAchievementBadge(String title, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.6), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 12),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressionMap() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Unit constellations in vertical layout
            _buildUnitConstellations(),
          ],
        ),
      ),
    );
  }

  Widget _buildUnitConstellations() {
    final units = [
      {
        'name': 'Rules of the Road',
        'stars': 11,
        'color': const Color(0xFF4A90E2),
      },
      {
        'name': 'Traffic Control',
        'stars': 16,
        'color': const Color(0xFFE74C3C),
      },
      {
        'name': 'Defensive Driving',
        'stars': 7,
        'color': const Color(0xFF27AE60),
      },
      {
        'name': 'Special Driving Situations',
        'stars': 10,
        'color': const Color(0xFFF39C12),
      },
      {
        'name': 'Sharing the Road',
        'stars': 7,
        'color': const Color(0xFF9B59B6),
      },
      {
        'name': 'Alcohol and Drugs',
        'stars': 4,
        'color': const Color(0xFFE67E22),
      },
    ];

    return Column(
      children: units.asMap().entries.map((entry) {
        final unitIndex = entry.key;
        final unit = entry.value;
        final isUnlocked = unitIndex < _playerLevel;
        final isCurrent = unitIndex == _playerLevel - 1;

        return _buildUnitConstellation(
          unitIndex,
          unit['name'] as String,
          unit['stars'] as int,
          unit['color'] as Color,
          isUnlocked,
          isCurrent,
        );
      }).toList(),
    );
  }

  Widget _buildUnitConstellation(
    int unitIndex,
    String unitName,
    int starCount,
    Color unitColor,
    bool isUnlocked,
    bool isCurrent,
  ) {
    final positions = _getUnitStarPositions(unitIndex, starCount);

    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      child: Column(
        children: [
          // Unit title
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Text(
              'UNIT ${unitIndex + 1}',
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            unitName,
            style: TextStyle(
              color: isUnlocked ? Colors.white : Colors.grey.shade600,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),

          // Unit separator line with dynamic spacing
          Container(
            margin: EdgeInsets.only(
              top: 15,
              bottom: unitIndex < 5
                  ? 25
                  : 15, // More space between units (5 is the last unit index)
            ),
            height: 1,
            color: Colors.grey.shade700,
          ),

          // Centered frame container for constellation
          Center(
            child: Container(
              width: 320, // Fixed width for the frame
              constraints: BoxConstraints(
                minHeight: _getUnitHeight(
                  unitIndex,
                  starCount,
                ), // Exact height needed
                maxHeight:
                    _getUnitHeight(unitIndex, starCount) + 20, // Small buffer
              ),
              decoration: BoxDecoration(
                // Removed border and background for invisible frame
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                ), // Add padding for negative Y coordinates and bottom spacing
                child: Stack(
                  children: [
                    // Draw constellation lines
                    CustomPaint(
                      painter: UnitConstellationPainter(
                        positions: positions,
                        unitIndex: unitIndex,
                        appSettings: Provider.of<AppSettingsProvider>(
                          context,
                          listen: false,
                        ),
                        unitColor: unitColor,
                      ),
                      size: Size(
                        280,
                        _getUnitHeight(unitIndex, starCount),
                      ), // Dynamic height based on content
                    ),

                    // Stars in this unit
                    ...positions.asMap().entries.map((entry) {
                      final starIndex = entry.key;
                      final position = entry.value;
                      final starId = unitIndex * 100 + starIndex + 1;

                      return Positioned(
                        left: position.dx,
                        top: position.dy,
                        child: Consumer<AppSettingsProvider>(
                          builder: (context, appSettings, child) {
                            final isStarUnlocked = appSettings.isSetUnlocked(
                              starId,
                            );

                            // Special debug for Set 101

                            final isStarCurrent =
                                starId == appSettings.getNextSetForXp();
                            final isStarLocked = !isStarUnlocked;

                            return _buildStarNode(
                              starId,
                              unitColor,
                              isStarUnlocked,
                              isStarCurrent,
                              isStarLocked,
                              unitIndex,
                            );
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _getUnitHeight(int unitIndex, int starCount) {
    // Calculate height based on actual star positions
    final positions = _getUnitStarPositions(unitIndex, starCount);
    if (positions.isEmpty) return 150.0;

    // Find the minimum and maximum Y coordinates
    double minY = positions.first.dy;
    double maxY = positions.first.dy;

    for (final position in positions) {
      if (position.dy < minY) minY = position.dy;
      if (position.dy > maxY) maxY = position.dy;
    }

    // Add padding for star size and spacing
    final actualHeight = maxY - minY;
    final padding = 50.0; // Reduced padding for star size and margins

    return actualHeight + padding;
  }

  List<Offset> _getUnitStarPositions(int unitIndex, int starCount) {
    // Create organic, flowing patterns within the frame
    switch (unitIndex) {
      case 0: // Rules of the Road - 11 stars (flowing path)
        return [
          const Offset(10, 40), // 1 - start
          const Offset(100, 0), // 2 - curve up
          const Offset(190, 50), // 3 - curve down
          const Offset(260, 70), // 4 - continue
          const Offset(190, 120), // 5 - back
          const Offset(90, 120), // 6 - flow
          const Offset(30, 160), // 7 - left
          const Offset(70, 220), // 8 - down
          const Offset(150, 250), // 9 - right
          const Offset(220, 190), // 10 - up
          const Offset(230, 270), // 11 - end
        ];
      case 1: // Traffic Control - 16 stars (organic spread)
        return [
          const Offset(140, 0), // 1 - center top
          const Offset(80, 70), // 2 - left
          const Offset(200, 70), // 3 - right
          const Offset(30, 140), // 4 - far left
          const Offset(250, 140), // 5 - far right
          const Offset(100, 210), // 6 - left center
          const Offset(180, 210), // 7 - right center
          const Offset(140, 280), // 8 - center
          const Offset(50, 350), // 9 - left down
          const Offset(240, 350), // 10 - right down
          const Offset(100, 420), // 11 - left center down
          const Offset(180, 420), // 12 - right center down
          const Offset(30, 490), // 13 - far left down
          const Offset(250, 490), // 14 - far right down
          const Offset(100, 560), // 15 - left bottom
          const Offset(180, 560), // 16 - right bottom
        ];
      case 2: // Defensive Driving - 7 stars (curved path)
        return [
          const Offset(140, 0), // 1 - start
          const Offset(50, 70), // 2 - curve left
          const Offset(230, 70), // 3 - curve right
          const Offset(80, 140), // 4 - back left
          const Offset(200, 140), // 5 - back right
          const Offset(30, 220), // 6 - far left
          const Offset(250, 220), // 7 - far right
        ];
      case 3: // Special Driving Situations - 10 stars (winding path)
        return [
          const Offset(140, 0), // 1 - start
          const Offset(50, 70), // 2 - left
          const Offset(230, 70), // 3 - right
          const Offset(90, 140), // 4 - back left
          const Offset(190, 140), // 5 - back right
          const Offset(30, 210), // 6 - far left
          const Offset(250, 210), // 7 - far right
          const Offset(60, 280), // 8 - left down
          const Offset(220, 280), // 9 - right down
          const Offset(140, 350), // 10 - center end
        ];
      case 4: // Sharing the Road - 7 stars (spiral)
        return [
          const Offset(140, 0), // 1 - center
          const Offset(50, 70), // 2 - left
          const Offset(230, 70), // 3 - right
          const Offset(80, 140), // 4 - back left
          const Offset(190, 140), // 5 - back right
          const Offset(40, 210), // 6 - far left
          const Offset(240, 210), // 7 - far right
        ];
      case 5: // Alcohol and Drugs - 4 stars (diamond)
        return [
          const Offset(140, 0), // 1 - top
          const Offset(80, 70), // 2 - left
          const Offset(200, 70), // 3 - right
          const Offset(140, 140), // 4 - bottom
        ];
      default:
        return List.generate(starCount, (index) => Offset(60 + index * 60, 40));
    }
  }

  Widget _buildStarNode(
    int starId,
    Color unitColor,
    bool isUnlocked,
    bool isCurrent,
    bool isLocked,
    int unitIndex,
  ) {
    return Consumer<AppSettingsProvider>(
      builder: (context, appSettings, child) {
        final isActuallyUnlocked = appSettings.isSetUnlocked(starId);
        final hasCompleted = appSettings.hasCompletedSet(starId);

        // Check if this star should have pulse animation
        final shouldPulse = isActuallyUnlocked && !hasCompleted;

        Color starColor;
        Color glowColor;
        double size;

        if (isActuallyUnlocked) {
          starColor = unitColor;
          glowColor = unitColor.withOpacity(0.6);
          size = shouldPulse ? 57 : 50; // Larger for pulsing stars
        } else if (isCurrent) {
          starColor = unitColor;
          glowColor = unitColor.withOpacity(0.8);
          size = 57; // Larger for current star
        } else {
          starColor = Colors.grey.shade600;
          glowColor = Colors.grey.shade500;
          size = 45;
        }

        return AnimatedBuilder(
          animation: (isCurrent || shouldPulse)
              ? _pulseAnimation
              : const AlwaysStoppedAnimation(1.0),
          builder: (context, child) {
            return Transform.scale(
              scale: (isCurrent || shouldPulse) ? _pulseAnimation.value : 1.0,
              child: GestureDetector(
                onTap: isActuallyUnlocked ? () => _startStar(starId) : null,
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: starColor,
                    boxShadow: [
                      BoxShadow(
                        color: glowColor.withOpacity(0.6),
                        blurRadius: (isCurrent || shouldPulse) ? 15 : 8,
                        spreadRadius: (isCurrent || shouldPulse) ? 5 : 2,
                      ),
                      if (isCurrent || shouldPulse)
                        BoxShadow(
                          color: unitColor.withOpacity(0.4),
                          blurRadius: 25,
                          spreadRadius: 8,
                        ),
                    ],
                    gradient: RadialGradient(
                      colors: [
                        starColor,
                        starColor.withOpacity(0.8),
                        starColor.withOpacity(0.6),
                      ],
                      stops: const [0.0, 0.7, 1.0],
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Star icon
                      Center(
                        child: Icon(
                          Icons.star,
                          color: Colors.white,
                          size: size * 0.6,
                        ),
                      ),

                      // Star number
                      Positioned(
                        bottom: -4,
                        right: -4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            // Show simple numbers for units other than Unit 1
                            unitIndex == 0
                                ? '$starId'
                                : '${(starId % 100) == 0 ? 100 : starId % 100}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      // Lock icon for locked sets
                      if (!isActuallyUnlocked)
                        Positioned(
                          top: -4,
                          left: -4,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.8),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),

                      // XP display for completed sets
                      if (isActuallyUnlocked && hasCompleted)
                        Positioned(
                          top: -4,
                          left: -4,
                          child: Consumer<AppSettingsProvider>(
                            builder: (context, appSettings, child) {
                              final xp = appSettings.getSetXp(starId) ?? 0;
                              if (xp > 0 && xp < 100) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.amber.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    '$xp XP',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),

                      // Completion indicator - REMOVED
                      // No more checkmark for completed sets
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildProgressBar() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF4A90E2).withOpacity(0.4),
            const Color(0xFF7B68EE).withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF4A90E2).withOpacity(0.6),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A90E2).withOpacity(0.4),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A90E2).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.trending_up,
                  color: Colors.amber,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Learning Progress',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$_completedQuizzes tests completed',
                      style: const TextStyle(
                        color: Color(0xFFB0B0B0),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A90E2).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF4A90E2).withOpacity(0.6),
                    width: 1,
                  ),
                ),
                child: Text(
                  'Level $_playerLevel',
                  style: const TextStyle(
                    color: Color(0xFF4A90E2),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: _experience / _maxExperience,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4A90E2), Color(0xFF7B68EE)],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startStar(int starId) {
    final appSettings = Provider.of<AppSettingsProvider>(
      context,
      listen: false,
    );
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);

    // Check if the star is unlocked
    if (!appSettings.isSetUnlocked(starId)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Complete the previous set to unlock this one!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Determine which unit this star belongs to
    final unitIndex = (starId - 1) ~/ 100;
    final setNumber = starId; // Use the full starId as setNumber

    try {
      if (unitIndex == 0) {
        // Unit 1: Rules of the Road (Sets 1-11)
        quizProvider.startQuiz(1, setNumber: setNumber, isStudyMode: true);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuizScreen()),
        );
      } else if (unitIndex == 1) {
        // Unit 2: Traffic Control (Sets 101-116)
        quizProvider.startQuiz(2, setNumber: setNumber, isStudyMode: true);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuizScreen()),
        );
      } else {
        // Other units: use random quiz for now
        quizProvider.startQuiz(unitIndex + 1, questionCount: 10, isStudyMode: true);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuizScreen()),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error starting quiz: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class StarsPainter extends CustomPainter {
  final double animationValue;

  StarsPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final random = math.Random(42); // Fixed seed for consistent stars

    for (int i = 0; i < 50; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 2 + 1;
      final opacity = random.nextDouble() * 0.5 + 0.2;

      paint.color = Colors.white.withOpacity(
        opacity * (0.5 + 0.5 * math.sin(animationValue * 2 * math.pi + i)),
      );

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class UnitConstellationPainter extends CustomPainter {
  final List<Offset> positions;
  final int unitIndex;
  final AppSettingsProvider appSettings;
  final Color unitColor;

  UnitConstellationPainter({
    required this.positions,
    required this.unitIndex,
    required this.appSettings,
    required this.unitColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw connections between stars in the unit
    for (int i = 0; i < positions.length - 1; i++) {
      final start = positions[i];
      final end = positions[i + 1];

      // Calculate connection status based on completed sets
      // For Unit 1: set numbers 1-11, for Unit 2: set numbers 101-116, etc.
      final currentSetNumber = unitIndex == 0
          ? (i + 1)
          : (unitIndex * 100 + i + 1);
      final nextSetNumber = unitIndex == 0
          ? (i + 2)
          : (unitIndex * 100 + i + 2);

      // Check if current set is completed (has 100 XP) and unlocked
      final currentSetXp = appSettings.getSetXp(currentSetNumber) ?? 0;
      final nextSetXp = appSettings.getSetXp(nextSetNumber) ?? 0;
      final isCurrentSetUnlocked = appSettings.isSetUnlocked(currentSetNumber);
      final isNextSetUnlocked = appSettings.isSetUnlocked(nextSetNumber);

      // Show completed connections for all units
      final isCurrentSetCompleted = currentSetXp >= 100 && isCurrentSetUnlocked;
      final isNextSetCompleted = nextSetXp >= 100 && isNextSetUnlocked;

      // Check if current set is unlocked but not completed (in progress)
      final isCurrentSetInProgress =
          currentSetXp > 0 && currentSetXp < 100 && isCurrentSetUnlocked;

      // Connection is completed if current set is completed and unlocked
      // This will show the line from completed set to next set
      final isCompleted = isCurrentSetCompleted;

      // Next unlock is when current is completed but next is not (and next exists)
      final isNextUnlock =
          isCurrentSetCompleted &&
          !isNextSetCompleted &&
          nextSetNumber <= positions.length;

      // In progress connection (unlocked but not completed)
      final isInProgress = isCurrentSetInProgress;

      // Adjust start and end points to connect to star centers
      // Star size is 40-52px, so center offset is 20-26px
      final starSize = 26.0; // Use the largest star size for safety
      final startCenter = Offset(start.dx + starSize, start.dy + starSize);
      final endCenter = Offset(end.dx + starSize, end.dy + starSize);

      _drawConstellationLine(
        canvas,
        startCenter,
        endCenter,
        isCompleted,
        isNextUnlock,
        isInProgress,
      );
    }
  }

  void _drawConstellationLine(
    Canvas canvas,
    Offset start,
    Offset end,
    bool isCompleted,
    bool isNextUnlock,
    bool isInProgress,
  ) {
    final distance = (end - start).distance;

    if (isCompleted) {
      // Completed path - bright white line with glow (thinner)
      final mainPaint = Paint()
        ..color = Colors.white.withOpacity(0.9)
        ..strokeWidth =
            1 // Reduced from 6
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      final glowPaint = Paint()
        ..color = unitColor.withOpacity(0.5)
        ..strokeWidth =
            10 // Reduced from 15
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      // Draw glow first
      canvas.drawLine(start, end, glowPaint);
      // Draw main line
      canvas.drawLine(start, end, mainPaint);

      // Add sparkle effects
      _addSparkles(canvas, start, end, distance);
    } else if (isNextUnlock) {
      // Next unlock path - animated dashed line (thinner)
      final dashPaint = Paint()
        ..color = Colors.white.withOpacity(0.7)
        ..strokeWidth =
            2.5 // Reduced from 3.5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      final dashLength = 8.0;
      final dashSpace = 6.0;
      final direction = (end - start) / distance;
      var currentPos = start;

      while ((currentPos - start).distance < distance) {
        final dashEnd = currentPos + direction * dashLength;
        canvas.drawLine(currentPos, dashEnd, dashPaint);
        currentPos = dashEnd + direction * dashSpace;
      }

      // Add subtle glow for next unlock path
      final nextGlowPaint = Paint()
        ..color = const Color(0xFFF39C12).withOpacity(0.3)
        ..strokeWidth =
            6 // Reduced from 8
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(start, end, nextGlowPaint);
    } else if (isInProgress) {
      // In progress path - dashed line with blue color (thinner)
      final inProgressPaint = Paint()
        ..color = const Color(0xFF4A90E2).withOpacity(0.7)
        ..strokeWidth =
            2.5 // Thinner line
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      final dashLength = 6.0; // Shorter dashes
      final dashSpace = 4.0; // Shorter spaces
      final direction = (end - start) / distance;
      var currentPos = start;

      while ((currentPos - start).distance < distance) {
        final dashEnd = currentPos + direction * dashLength;
        canvas.drawLine(currentPos, dashEnd, inProgressPaint);
        currentPos = dashEnd + direction * dashSpace;
      }

      // Add subtle glow for in-progress path
      final inProgressGlowPaint = Paint()
        ..color = const Color(0xFF4A90E2).withOpacity(0.2)
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(start, end, inProgressGlowPaint);
    } else {
      // Locked path - very faint dashed line (thinner)
      final lockedPaint = Paint()
        ..color = Colors.white.withOpacity(0.2)
        ..strokeWidth =
            1.5 // Reduced from 2.5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      final dashLength = 4.0;
      final dashSpace = 8.0;
      final direction = (end - start) / distance;
      var currentPos = start;

      while ((currentPos - start).distance < distance) {
        final dashEnd = currentPos + direction * dashLength;
        canvas.drawLine(currentPos, dashEnd, lockedPaint);
        currentPos = dashEnd + direction * dashSpace;
      }
    }
  }

  void _addSparkles(Canvas canvas, Offset start, Offset end, double distance) {
    final sparklePaint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    final random = math.Random(42); // Fixed seed for consistent sparkles

    // Add sparkles along the line
    for (int i = 0; i < 3; i++) {
      final t = random.nextDouble();
      final sparklePos = start + (end - start) * t;

      // Small sparkle
      canvas.drawCircle(sparklePos, 1.5, sparklePaint);

      // Add a few smaller sparkles around
      for (int j = 0; j < 2; j++) {
        final offset = Offset(
          (random.nextDouble() - 0.5) * 8,
          (random.nextDouble() - 0.5) * 8,
        );
        canvas.drawCircle(sparklePos + offset, 0.8, sparklePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
