import 'package:dmv_test/services/database_service.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/user_service.dart';

class AppSettingsProvider with ChangeNotifier {
  bool _isDarkMode = true;
  String _selectedLanguage = 'en';
  int _totalXp = 0;
  Map<int, int> _setXp = {}; // Track XP for each set
  String? _selectedState;
  String? _selectedLicenseType;
  String? _userName;
  String? _userProfileImage;
  List<int>? _userProfileImageData;

  bool get isDarkMode => _isDarkMode;
  String get selectedLanguage => _selectedLanguage;
  int get totalXp => _totalXp;
  Map<int, int> get setXp => _setXp;
  String? get selectedState => _selectedState;
  String? get selectedLicenseType => _selectedLicenseType;
  String? get userName => _userName;
  String? get userProfileImage => _userProfileImage;
  List<int>? get userProfileImageData => _userProfileImageData;
  int get currentLevel => (_totalXp ~/ 100) + 1;
  int? getSetXp(int setNumber) => _setXp[setNumber];

  // Level System
  int get currentLevelXp => _totalXp % 100;
  int get xpToNextLevel => 100 - currentLevelXp;
  bool get isLevelUp => currentLevelXp == 0 && _totalXp > 0;

  // Driver Rank System
  String get driverRank {
    if (currentLevel >= 20) return 'Master Driver';
    if (currentLevel >= 15) return 'Expert Driver';
    if (currentLevel >= 10) return 'Advanced Driver';
    if (currentLevel >= 5) return 'Intermediate Driver';
    if (currentLevel >= 2) return 'Novice Driver';
    return 'Rookie Driver';
  }

  // Set Unlocking System
  bool isSetUnlocked(int setNumber) {
    if (setNumber <= 1) {
      return true; // Set 1 is always unlocked
    }
    if (setNumber <= 11) {
      // Unit 1 sets: unlock based on previous set completion with 100 XP
      final previousSetXp = _setXp[setNumber - 1] ?? 0;
      final previousSetCompleted =
          previousSetXp >= 100; // Must have 100 XP (100%)
      return previousSetCompleted;
    }
    if (setNumber >= 101 && setNumber <= 116) {
      // Unit 2 sets: unlock based on Unit 1 completion + previous set completion
      final unit1Completed = _isUnit1Completed();
      if (setNumber == 101) {
        // Set 1 of Unit 2: unlock when Unit 1 is completed
        return unit1Completed;
      }
      // Other Unit 2 sets: unlock based on previous set completion + Unit 1 completed
      final previousSetXp = _setXp[setNumber - 1] ?? 0;
      final previousSetCompleted = previousSetXp >= 100;

      return unit1Completed && previousSetCompleted;
    }
    if (setNumber >= 201 && setNumber <= 207) {
      // Unit 3 sets: unlock based on Unit 2 completion + previous set completion
      final unit2Completed = _isUnit2Completed();
      if (setNumber == 201) {
        // Set 1 of Unit 3: unlock when Unit 2 is completed
        return unit2Completed;
      }
      // Other Unit 3 sets: unlock based on previous set completion + Unit 2 completed
      final previousSetXp = _setXp[setNumber - 1] ?? 0;
      final previousSetCompleted = previousSetXp >= 100;
      return unit2Completed && previousSetCompleted;
    }
    if (setNumber >= 301 && setNumber <= 310) {
      // Unit 4 sets: unlock based on Unit 3 completion + previous set completion
      final unit3Completed = _isUnit3Completed();
      if (setNumber == 301) {
        // Set 1 of Unit 4: unlock when Unit 3 is completed
        return unit3Completed;
      }
      // Other Unit 4 sets: unlock based on previous set completion + Unit 3 completed
      final previousSetXp = _setXp[setNumber - 1] ?? 0;
      final previousSetCompleted = previousSetXp >= 100;
      return unit3Completed && previousSetCompleted;
    }
    if (setNumber >= 401 && setNumber <= 407) {
      // Unit 5 sets: unlock based on Unit 4 completion + previous set completion
      final unit4Completed = _isUnit4Completed();
      if (setNumber == 401) {
        // Set 1 of Unit 5: unlock when Unit 4 is completed
        return unit4Completed;
      }
      // Other Unit 5 sets: unlock based on previous set completion + Unit 4 completed
      final previousSetXp = _setXp[setNumber - 1] ?? 0;
      final previousSetCompleted = previousSetXp >= 100;
      return unit4Completed && previousSetCompleted;
    }
    // Other units: remain locked for now
    return false;
  }

  bool _isUnit1Completed() {
    // Check if all Unit 1 sets (1-11) are completed with 100 XP
    for (int i = 1; i <= 11; i++) {
      final setXp = _setXp[i] ?? 0;
      if (setXp < 100) {
        return false;
      }
    }
    return true;
  }

  bool _isUnit2Completed() {
    // Check if all Unit 2 sets (101-116) are completed with 100 XP
    for (int i = 101; i <= 116; i++) {
      final setXp = _setXp[i] ?? 0;
      if (setXp < 100) {
        return false;
      }
    }
    return true;
  }

  bool _isUnit3Completed() {
    // Check if all Unit 3 sets (201-207) are completed with 100 XP
    for (int i = 201; i <= 207; i++) {
      final setXp = _setXp[i] ?? 0;
      if (setXp < 100) {
        return false;
      }
    }
    return true;
  }

  bool _isUnit4Completed() {
    // Check if all Unit 4 sets (301-310) are completed with 100 XP
    for (int i = 301; i <= 310; i++) {
      final setXp = _setXp[i] ?? 0;
      if (setXp < 100) {
        return false;
      }
    }
    return true;
  }

  bool _isUnit5Completed() {
    // Check if all Unit 5 sets (401-407) are completed with 100 XP
    for (int i = 401; i <= 407; i++) {
      final setXp = _setXp[i] ?? 0;
      if (setXp < 100) {
        return false;
      }
    }
    return true;
  }

  int _getRequiredLevelForSet(int setNumber) {
    if (setNumber <= 11) return 1; // Unit 1 sets
    if (setNumber >= 101 && setNumber <= 116)
      return 2; // Unit 2 sets (unlock when Unit 1 completed)
    if (setNumber >= 201 && setNumber <= 207) return 3; // Unit 3 sets (future)
    if (setNumber >= 301 && setNumber <= 310) return 4; // Unit 4 sets (future)
    if (setNumber >= 401 && setNumber <= 407) return 5; // Unit 5 sets (future)
    return 6; // Unit 6+ sets (future)
  }

  int getNextUnlockableSet() {
    // Check Unit 1 sets (1-11)
    for (int i = 1; i <= 11; i++) {
      if (!isSetUnlocked(i)) {
        return i;
      }
    }
    // Check Unit 2 sets (101-116)
    for (int i = 101; i <= 116; i++) {
      if (!isSetUnlocked(i)) {
        return i;
      }
    }
    // Check other units (future)
    for (int i = 201; i <= 500; i++) {
      if (!isSetUnlocked(i)) {
        return i;
      }
    }
    return -1; // All sets unlocked
  }

  AppSettingsProvider() {
    _loadSettings();
    _loadUserFromDatabase();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? true;
    _selectedLanguage = prefs.getString('selectedLanguage') ?? 'en';
    _totalXp = prefs.getInt('totalXp') ?? 0;
    _selectedState = prefs.getString('selectedState');
    _selectedLicenseType = prefs.getString('selectedLicenseType');
    _userName = prefs.getString('userName');
    _userProfileImage = prefs.getString('userProfileImage');

    // Load set XP
    final setXpKeys = prefs.getKeys().where((key) => key.startsWith('setXp_'));
    for (final key in setXpKeys) {
      final setNumber = int.parse(key.split('_')[1]);
      final xp = prefs.getInt(key) ?? 0;
      _setXp[setNumber] = xp;
    }

    notifyListeners();
  }

  Future<void> _loadUserFromDatabase() async {
    try {
      final userService = UserService();
      final user = await userService.getCurrentUser();

      if (user != null) {
        _userName = user['name'] as String?;
        _userProfileImage = user['profile_image_path'] as String?;
        _selectedState = user['selected_state'] as String?;
        _selectedLicenseType = user['selected_license_type'] as String?;

        // Load profile image data from database
        if (user['id'] != null) {
          final databaseService = DatabaseService();
          _userProfileImageData = await databaseService
              .getProfileImageFromDatabase(user['id']);
        }

        // Update SharedPreferences with database values
        final prefs = await SharedPreferences.getInstance();
        if (_userName != null) {
          await prefs.setString('userName', _userName!);
        }
        if (_userProfileImage != null) {
          await prefs.setString('userProfileImage', _userProfileImage!);
        }
        if (_selectedState != null) {
          await prefs.setString('selectedState', _selectedState!);
        }
        if (_selectedLicenseType != null) {
          await prefs.setString('selectedLicenseType', _selectedLicenseType!);
        }

        notifyListeners();
      } else {
        // No user found in database
      }
    } catch (e) {
      // Handle database error silently
      print('Error loading user from database: $e');
    }
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    await prefs.setString('selectedLanguage', _selectedLanguage);
    await prefs.setInt('totalXp', _totalXp);
    if (_selectedState != null) {
      await prefs.setString('selectedState', _selectedState!);
    }
    if (_selectedLicenseType != null) {
      await prefs.setString('selectedLicenseType', _selectedLicenseType!);
    }
    if (_userName != null) {
      await prefs.setString('userName', _userName!);
    }
    if (_userProfileImage != null) {
      await prefs.setString('userProfileImage', _userProfileImage!);
    }

    // Save set XP
    for (final entry in _setXp.entries) {
      await prefs.setInt('setXp_${entry.key}', entry.value);
    }
  }

  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    await _saveSettings();
    notifyListeners();
  }

  Future<void> setLanguage(String language) async {
    _selectedLanguage = language;
    await _saveSettings();
    notifyListeners();
  }

  void setSelectedState(String state) {
    _selectedState = state;
    _saveSettings();
    notifyListeners();
  }

  void setSelectedLicenseType(String licenseType) {
    _selectedLicenseType = licenseType;
    _saveSettings();
    notifyListeners();
  }

  void setUserName(String name) {
    _userName = name;
    _saveSettings();
    notifyListeners();
  }

  void setUserProfileImage(String imagePath) {
    _userProfileImage = imagePath;
    _saveSettings();
    notifyListeners();
  }

  // Force reload user data from database
  Future<void> reloadUserFromDatabase() async {
    await _loadUserFromDatabase();
  }

  void setSelectedLanguage(String languageCode) {
    // For now, we'll just save the language code
    // In a real app, you might want to implement actual language switching
    _saveSettings();
    notifyListeners();
  }

  void clearSettings() {
    _selectedState = null;
    _selectedLicenseType = null;
    _saveSettings();
    notifyListeners();
  }

  bool get isSettingsComplete =>
      _selectedState != null && _selectedLicenseType != null;

  int get totalScore {
    // Calculate total score from all completed sets
    int total = 0;
    for (final entry in _setXp.entries) {
      if (entry.value >= 100) { // Only count completed sets
        total += entry.value;
      }
    }
    return total;
  }

  Future<void> addXp(int setNumber, int xpEarned) async {
    final previousLevel = currentLevel;
    final previousRank = driverRank;

    // Update set XP (keep the highest score)
    final currentSetXp = _setXp[setNumber] ?? 0;

    if (xpEarned > currentSetXp) {
      _setXp[setNumber] = xpEarned;
    }

    // Calculate total XP from all sets (max 100 XP per set)
    int newTotalXp = 0;
    for (final entry in _setXp.entries) {
      newTotalXp += entry.value; // Each set contributes its XP to total
    }

    // Update total XP
    _totalXp = newTotalXp;

    await _saveSettings();
    notifyListeners();
  }

  bool hasCompletedSet(int setNumber) {
    final setXp = _setXp[setNumber] ?? 0;
    return setXp >= 100; // Completed if 100 XP or more
  }

  int getCompletedSetsCount() {
    return _setXp.values.where((xp) => xp >= 100).length;
  }

  // Get XP breakdown information
  Map<String, dynamic> getXpBreakdown() {
    final breakdown = <String, dynamic>{
      'totalXp': _totalXp,
      'currentLevel': currentLevel,
      'currentLevelXp': currentLevelXp,
      'xpToNextLevel': xpToNextLevel,
      'driverRank': driverRank,
      'completedSets': getCompletedSetsCount(),
      'sets': <Map<String, dynamic>>[],
    };

    // Add information for each set
    for (int i = 1; i <= 50; i++) {
      final setXp = _setXp[i] ?? 0;
      final isUnlocked = isSetUnlocked(i);
      final hasCompleted = hasCompletedSet(i);

      breakdown['sets'].add({
        'setNumber': i,
        'xp': setXp,
        'isUnlocked': isUnlocked,
        'hasCompleted': hasCompleted,
        'maxXp': 100,
      });
    }

    return breakdown;
  }

  // Get next set to complete for XP
  int? getNextSetForXp() {
    for (int i = 1; i <= 50; i++) {
      if (isSetUnlocked(i) && !hasCompletedSet(i)) {
        return i;
      }
    }
    return null; // All unlocked sets completed
  }

  // Get potential XP from remaining sets
  int getPotentialXp() {
    int potential = 0;
    for (int i = 1; i <= 50; i++) {
      if (isSetUnlocked(i) && !hasCompletedSet(i)) {
        final currentXp = _setXp[i] ?? 0;
        potential += (100 - currentXp); // Remaining XP for this set
      }
    }
    return potential;
  }

  Future<void> updateUserProfile({
    required String name,
    String? profileImage,
  }) async {
    // Lưu vào database
    final db = DatabaseService();
    final user = await db.getCurrentUser();
    if (user != null) {
      await db.updateUserProfile(user['id'], {
        'name': name,
        'profile_image_path': profileImage,
      });
    }
    // Cập nhật provider
    _userName = name;
    _userProfileImage = profileImage;
    notifyListeners();
  }
}
