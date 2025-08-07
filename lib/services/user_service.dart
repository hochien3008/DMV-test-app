import '../services/database_service.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  final DatabaseService _databaseService = DatabaseService();

  // Get current user
  Future<Map<String, dynamic>?> getCurrentUser() async {
    return await _databaseService.getCurrentUser();
  }

  // Save user onboarding data
  Future<void> saveOnboardingData({
    required String name,
    String? profileImage,
    required String selectedState,
    required String selectedLicenseType,
  }) async {
    await _databaseService.saveUserOnboarding(
      name: name,
      profileImagePath: profileImage,
      selectedState: selectedState,
      selectedLicenseType: selectedLicenseType,
    );
  }

  // Update user profile
  Future<void> updateProfile({
    required int userId,
    String? name,
    String? profileImage,
    String? selectedState,
    String? selectedLicenseType,
  }) async {
    final updates = <String, dynamic>{};

    if (name != null) updates['name'] = name;
    if (profileImage != null) updates['profile_image_path'] = profileImage;
    if (selectedState != null) updates['selected_state'] = selectedState;
    if (selectedLicenseType != null)
      updates['selected_license_type'] = selectedLicenseType;

    await _databaseService.updateUserProfile(userId, updates);
  }

  // Check if user has completed onboarding
  Future<bool> hasCompletedOnboarding() async {
    final user = await getCurrentUser();

    if (user == null) {
      return false;
    }

    final hasName =
        user['name'] != null && user['name'].toString().trim().isNotEmpty;
    final hasState =
        user['selected_state'] != null &&
        user['selected_state'].toString().trim().isNotEmpty;
    final hasLicenseType =
        user['selected_license_type'] != null &&
        user['selected_license_type'].toString().trim().isNotEmpty;

    return hasName && hasState && hasLicenseType;
  }

  // Get user statistics
  Future<Map<String, dynamic>> getUserStatistics() async {
    final user = await getCurrentUser();
    if (user == null) {
      return {
        'total_quizzes': 0,
        'average_score': 0.0,
        'study_time': 0,
        'completed_sets': 0,
      };
    }

    // TODO: Implement actual statistics calculation
    return {
      'total_quizzes': 0,
      'average_score': 0.0,
      'study_time': 0,
      'completed_sets': 0,
    };
  }

  // Delete user data
  Future<void> deleteUserData() async {
    final db = await _databaseService.database;
    await db.delete('users');
  }
}
