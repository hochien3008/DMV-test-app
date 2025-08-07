import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../providers/app_settings_provider.dart';
import '../utils/color.dart';
import '../services/user_service.dart';
import 'main_screen.dart';
import 'dart:math' as math;

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  int _currentStep = 0;
  String? selectedState;
  String? selectedVehicleType;
  String? userName;
  String? userProfileImage;
  File? _selectedImageFile;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String searchQuery = '';

  late AnimationController _starsController;
  late AnimationController _slideController;
  late AnimationController _pulseController;
  late Animation<double> _starsAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _pulseAnimation;
  late PageController _pageController;

  // Danh sách các bang của Mỹ với file cờ thật
  final List<Map<String, String>> states = [
    {'name': 'Alabama', 'abbr': 'AL', 'flag': 'assets/icons/al.png'},
    {'name': 'Alaska', 'abbr': 'AK', 'flag': 'assets/icons/ak.png'},
    {'name': 'Arizona', 'abbr': 'AZ', 'flag': 'assets/icons/az.png'},
    {'name': 'Arkansas', 'abbr': 'AR', 'flag': 'assets/icons/ar.png'},
    {'name': 'California', 'abbr': 'CA', 'flag': 'assets/icons/ca.png'},
    {'name': 'Colorado', 'abbr': 'CO', 'flag': 'assets/icons/co.png'},
    {'name': 'Connecticut', 'abbr': 'CT', 'flag': 'assets/icons/ct.png'},
    {'name': 'Delaware', 'abbr': 'DE', 'flag': 'assets/icons/de.png'},
    {
      'name': 'District of Columbia',
      'abbr': 'DC',
      'flag': 'assets/icons/di.png',
    },
    {'name': 'Florida', 'abbr': 'FL', 'flag': 'assets/icons/fl.png'},
    {'name': 'Georgia', 'abbr': 'GA', 'flag': 'assets/icons/ga.png'},
    {'name': 'Hawaii', 'abbr': 'HI', 'flag': 'assets/icons/hi.png'},
    {'name': 'Idaho', 'abbr': 'ID', 'flag': 'assets/icons/id.png'},
    {'name': 'Illinois', 'abbr': 'IL', 'flag': 'assets/icons/il.png'},
    {'name': 'Indiana', 'abbr': 'IN', 'flag': 'assets/icons/in.png'},
    {'name': 'Iowa', 'abbr': 'IA', 'flag': 'assets/icons/ia.png'},
    {'name': 'Kansas', 'abbr': 'KS', 'flag': 'assets/icons/ks.png'},
    {'name': 'Kentucky', 'abbr': 'KY', 'flag': 'assets/icons/ky.png'},
    {'name': 'Louisiana', 'abbr': 'LA', 'flag': 'assets/icons/la.png'},
    {'name': 'Maine', 'abbr': 'ME', 'flag': 'assets/icons/me.png'},
    {'name': 'Maryland', 'abbr': 'MD', 'flag': 'assets/icons/md.png'},
    {'name': 'Massachusetts', 'abbr': 'MA', 'flag': 'assets/icons/ma.png'},
    {'name': 'Michigan', 'abbr': 'MI', 'flag': 'assets/icons/mi.png'},
    {'name': 'Minnesota', 'abbr': 'MN', 'flag': 'assets/icons/mn.png'},
    {'name': 'Mississippi', 'abbr': 'MS', 'flag': 'assets/icons/ms.png'},
    {'name': 'Missouri', 'abbr': 'MO', 'flag': 'assets/icons/mo.png'},
    {'name': 'Montana', 'abbr': 'MT', 'flag': 'assets/icons/mt.png'},
    {'name': 'Nebraska', 'abbr': 'NE', 'flag': 'assets/icons/ne.png'},
    {'name': 'Nevada', 'abbr': 'NV', 'flag': 'assets/icons/nv.png'},
    {'name': 'New Hampshire', 'abbr': 'NH', 'flag': 'assets/icons/nh.png'},
    {'name': 'New Jersey', 'abbr': 'NJ', 'flag': 'assets/icons/nj.png'},
    {'name': 'New Mexico', 'abbr': 'NM', 'flag': 'assets/icons/nm.png'},
    {'name': 'New York', 'abbr': 'NY', 'flag': 'assets/icons/ny.png'},
    {'name': 'North Carolina', 'abbr': 'NC', 'flag': 'assets/icons/nc.png'},
    {'name': 'North Dakota', 'abbr': 'ND', 'flag': 'assets/icons/nd.png'},
    {'name': 'Ohio', 'abbr': 'OH', 'flag': 'assets/icons/oh.png'},
    {'name': 'Oklahoma', 'abbr': 'OK', 'flag': 'assets/icons/ok.png'},
    {'name': 'Oregon', 'abbr': 'OR', 'flag': 'assets/icons/or.png'},
    {'name': 'Pennsylvania', 'abbr': 'PA', 'flag': 'assets/icons/pa.png'},
    {'name': 'Rhode Island', 'abbr': 'RI', 'flag': 'assets/icons/ri.png'},
    {'name': 'South Carolina', 'abbr': 'SC', 'flag': 'assets/icons/sc.png'},
    {'name': 'South Dakota', 'abbr': 'SD', 'flag': 'assets/icons/sd.png'},
    {'name': 'Tennessee', 'abbr': 'TN', 'flag': 'assets/icons/tn.png'},
    {'name': 'Texas', 'abbr': 'TX', 'flag': 'assets/icons/tx.png'},
    {'name': 'Utah', 'abbr': 'UT', 'flag': 'assets/icons/ut.png'},
    {'name': 'Vermont', 'abbr': 'VT', 'flag': 'assets/icons/vt.png'},
    {'name': 'Virginia', 'abbr': 'VA', 'flag': 'assets/icons/va.png'},
    {'name': 'Washington', 'abbr': 'WA', 'flag': 'assets/icons/wa.png'},
    {'name': 'West Virginia', 'abbr': 'WV', 'flag': 'assets/icons/wv.png'},
    {'name': 'Wisconsin', 'abbr': 'WI', 'flag': 'assets/icons/wi.png'},
    {'name': 'Wyoming', 'abbr': 'WY', 'flag': 'assets/icons/wy.png'},
  ];

  // Danh sách loại phương tiện với icon đẹp
  final List<Map<String, dynamic>> vehicleTypes = [
    {
      'name': 'Car',
      'code': 'CAR',
      'icon': Icons.directions_car,
      'description': 'Regular passenger vehicle',
      'color': AppColors.carColor,
    },
    {
      'name': 'Motorcycle',
      'code': 'MOTORCYCLE',
      'icon': Icons.motorcycle,
      'description': 'Two-wheeled vehicle',
      'color': AppColors.motorcycleColor,
    },
    {
      'name': 'CDL',
      'code': 'CDL',
      'icon': Icons.local_shipping,
      'description': 'Commercial Driver License',
      'color': AppColors.cdlColor,
    },
  ];

  List<Map<String, String>> get filteredStates {
    if (searchQuery.isEmpty) {
      return states;
    }
    return states.where((state) {
      return state['name']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          state['abbr']!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  void initState() {
    super.initState();

    // Initialize animations
    _starsController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _starsAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _starsController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeInOut),
    );
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _starsController.repeat(reverse: true);
    _pulseController.repeat(reverse: true);

    // Initialize PageController
    _pageController = PageController(initialPage: _currentStep);
  }

  @override
  void dispose() {
    _starsController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
    _pageController.dispose();
    _searchController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _showMessageDialog(
    String title,
    String message, {
    bool isError = false,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          title,
          style: TextStyle(
            color: isError ? Colors.red : Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'OK',
              style: TextStyle(
                color: Color(0xFF4A90E2),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _nextStep() {
    if (_currentStep == 0 && (userName == null || userName!.trim().isEmpty)) {
      _showMessageDialog(
        'Profile Setup Required',
        'Please enter your name to continue with the setup process.',
        isError: false,
      );
      return;
    }

    if (_currentStep == 1 && selectedState == null) {
      _showMessageDialog(
        'State Selection Required',
        'Please select your state to customize your learning experience.',
        isError: false,
      );
      return;
    }

    if (_currentStep == 2 && selectedVehicleType == null) {
      _showMessageDialog(
        'Vehicle Type Required',
        'Please select your vehicle type to personalize your study materials.',
        isError: false,
      );
      return;
    }

    if (_currentStep < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      // Create a new instance of ImagePicker
      final picker = ImagePicker();

      // Pick image directly without permission check first
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectedImageFile = File(image.path);
          userProfileImage = image.path; // Store the file path
        });
      }
    } catch (e) {
      // Handle specific errors
      String errorMessage = 'Unable to access image picker';
      String errorTitle = 'Image Selection Issue';

      if (e.toString().contains('permission')) {
        errorTitle = 'Camera/Photo Permission Required';
        errorMessage =
            'Please allow camera and photo library access in your device settings to select a profile picture.';
      } else if (e.toString().contains('MissingPluginException')) {
        errorTitle = 'Image Picker Unavailable';
        errorMessage =
            'The image picker is currently unavailable. Please try again or restart the app.';
      } else if (e.toString().contains('User cancelled')) {
        // User cancelled, don't show error
        return;
      } else if (e.toString().contains('No image selected')) {
        // No image selected, don't show error
        return;
      }

      _showMessageDialog(errorTitle, errorMessage, isError: false);
    }
  }

  void _showImagePickerDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Choose Image Source',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFF4A90E2)),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.photo_library,
                color: Color(0xFF4A90E2),
              ),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.close, color: Colors.grey),
              title: const Text('Cancel'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _completeOnboarding() async {
    try {
      // Save settings to provider
      final appSettings = Provider.of<AppSettingsProvider>(
        context,
        listen: false,
      );
      appSettings.setSelectedState(selectedState!);
      appSettings.setSelectedLicenseType(selectedVehicleType!);
      appSettings.setUserName(userName!);
      if (userProfileImage != null) {
        appSettings.setUserProfileImage(userProfileImage!);
      }

      // Save to SQLite database
      final userService = UserService();
      await userService.saveOnboardingData(
        name: userName!,
        profileImage: userProfileImage,
        selectedState: selectedState!,
        selectedLicenseType: selectedVehicleType!,
      );

      // Force reload user data in provider
      await appSettings.reloadUserFromDatabase();

      Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MainScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
        (route) => false, // Remove all previous routes
      );
    } catch (e) {
      // Show error message
      _showMessageDialog(
        'Notice',
        'Unable to save user data. Please try again.',
        isError: false,
      );
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
                  // Progress indicator
                  _buildProgressIndicator(),

                  // Content with PageView
                  Expanded(
                    child: GestureDetector(
                      onHorizontalDragEnd: (details) {
                        if (details.primaryVelocity! > 0) {
                          // Swipe right - go to previous page
                          if (_currentStep > 0) {
                            _previousStep();
                          }
                        } else if (details.primaryVelocity! < 0) {
                          // Swipe left - go to next page
                          if (_currentStep < 3) {
                            _nextStep();
                          }
                        }
                      },
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentStep = index;
                          });
                        },
                        children: [
                          _buildProfileSetup(),
                          _buildStateSelection(),
                          _buildVehicleTypeSelection(),
                          _buildFinalStep(),
                        ],
                      ),
                    ),
                  ),

                  // Navigation buttons
                  _buildNavigationButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Step indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              final isActive = index == _currentStep;
              final isCompleted = index < _currentStep;

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: isActive ? _pulseAnimation.value : 1.0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isCompleted
                              ? const Color(0xFF4A90E2)
                              : isActive
                              ? const Color(0xFF4A90E2)
                              : Colors.grey.shade600,
                          boxShadow: isActive
                              ? [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF4A90E2,
                                    ).withOpacity(0.6),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                  ),
                                ]
                              : null,
                        ),
                        child: isCompleted
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 8,
                              )
                            : null,
                      ),
                    );
                  },
                ),
              );
            }),
          ),
          const SizedBox(height: 16),

          // Step titles
          Text(
            _getStepTitle(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            _getStepDescription(),
            style: const TextStyle(color: Color(0xFFB0B0B0), fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Welcome!';
      case 1:
        return 'Choose Your State';
      case 2:
        return 'Select Vehicle Type';
      case 3:
        return 'Ready to Start';
      default:
        return '';
    }
  }

  String _getStepDescription() {
    switch (_currentStep) {
      case 0:
        return 'Tell us about yourself to personalize your experience';
      case 1:
        return 'Select the state where you want to get your license';
      case 2:
        return 'Choose the type of vehicle you want to drive';
      case 3:
        return 'Your personalized learning journey is ready';
      default:
        return '';
    }
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildProfileSetup();
      case 1:
        return _buildStateSelection();
      case 2:
        return _buildVehicleTypeSelection();
      case 3:
        return _buildFinalStep();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildProfileSetup() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Profile Image Section
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF4A90E2), Color(0xFF7B68EE)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4A90E2).withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: GestureDetector(
              onTap: _showImagePickerDialog,
              child: Stack(
                children: [
                  if (_selectedImageFile != null)
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(_selectedImageFile!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  else if (userProfileImage != null &&
                      userProfileImage != 'default')
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(userProfileImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  else
                    Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4A90E2),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Name Input Section
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF4A90E2).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: TextField(
              controller: _nameController,
              onChanged: (value) {
                setState(() {
                  userName = value;
                });
              },
              style: const TextStyle(color: Colors.white, fontSize: 18),
              decoration: InputDecoration(
                hintText: 'Enter your name',
                hintStyle: const TextStyle(color: Color(0xFF7F8C8D)),
                prefixIcon: const Icon(Icons.person, color: Color(0xFF4A90E2)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Optional: Add more profile fields here
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: Color(0xFF4A90E2), size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Profile image is optional. You can add one later in settings.',
                    style: TextStyle(color: Color(0xFFB0B0B0), fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStateSelection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Search Box
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF4A90E2).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search states...',
                hintStyle: const TextStyle(color: Color(0xFF7F8C8D)),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF7F8C8D)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // States Grid
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: filteredStates.length,
              itemBuilder: (context, index) {
                final state = filteredStates[index];
                final isSelected = selectedState == state['abbr'];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedState = state['abbr'];
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: isSelected
                          ? Border.all(color: const Color(0xFF4A90E2), width: 2)
                          : Border.all(
                              color: Colors.white.withOpacity(0.1),
                              width: 1,
                            ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: const Color(0xFF4A90E2).withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Flag image
                        Container(
                          width: 40,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.asset(
                              state['flag']!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 40,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF4A90E2,
                                    ).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Center(
                                    child: Text(
                                      state['abbr']!,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF4A90E2),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // State name
                        Text(
                          state['name']!,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? const Color(0xFF4A90E2)
                                : Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        // State abbreviation
                        Text(
                          state['abbr']!,
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected
                                ? const Color(0xFF4A90E2)
                                : const Color(0xFF7F8C8D),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleTypeSelection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Vehicle Types
          ...vehicleTypes.map((vehicleType) {
            final isSelected = selectedVehicleType == vehicleType['code'];

            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedVehicleType = vehicleType['code'];
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: isSelected
                        ? Border.all(color: vehicleType['color'], width: 3)
                        : Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: vehicleType['color'].withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      // Icon container
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? vehicleType['color']
                              : vehicleType['color'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          vehicleType['icon'],
                          color: isSelected
                              ? Colors.white
                              : vehicleType['color'],
                          size: 40,
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Text content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              vehicleType['name'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? vehicleType['color']
                                    : Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              vehicleType['description'],
                              style: TextStyle(
                                fontSize: 14,
                                color: isSelected
                                    ? vehicleType['color'].withOpacity(0.8)
                                    : const Color(0xFF7F8C8D),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildFinalStep() {
    // Check if all required fields are filled
    bool isComplete =
        userName != null &&
        userName!.trim().isNotEmpty &&
        selectedState != null &&
        selectedVehicleType != null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Dynamic icon based on completion status
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isComplete
                          ? [const Color(0xFF4A90E2), const Color(0xFF7B68EE)]
                          : [const Color(0xFFFF6B6B), const Color(0xFFFF8E53)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color:
                            (isComplete
                                    ? const Color(0xFF4A90E2)
                                    : const Color(0xFFFF6B6B))
                                .withOpacity(0.4),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Icon(
                    isComplete ? Icons.check : Icons.info_outline,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 40),

          // Summary
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF4A90E2).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Your Setup',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Profile info
                Row(
                  children: [
                    const Icon(
                      Icons.person,
                      color: Color(0xFF4A90E2),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Name: $userName',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // State info
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Color(0xFF4A90E2),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        selectedState != null
                            ? 'State: ${states.firstWhere((s) => s['abbr'] == selectedState, orElse: () => {'name': 'Not selected'})['name']}'
                            : 'State: Not selected',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Vehicle type info
                Row(
                  children: [
                    Icon(
                      selectedVehicleType != null
                          ? vehicleTypes.firstWhere(
                              (v) => v['code'] == selectedVehicleType,
                              orElse: () => {
                                'icon': Icons.directions_car,
                                'color': Colors.grey,
                              },
                            )['icon']
                          : Icons.directions_car,
                      color: selectedVehicleType != null
                          ? vehicleTypes.firstWhere(
                              (v) => v['code'] == selectedVehicleType,
                              orElse: () => {
                                'icon': Icons.directions_car,
                                'color': Colors.grey,
                              },
                            )['color']
                          : Colors.grey,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        selectedVehicleType != null
                            ? 'Vehicle: ${vehicleTypes.firstWhere((v) => v['code'] == selectedVehicleType, orElse: () => {'name': 'Not selected'})['name']}'
                            : 'Vehicle: Not selected',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // Dynamic message based on completion status
          Text(
            isComplete
                ? 'Welcome to your personalized learning journey!'
                : 'Please complete your setup to continue',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            isComplete
                ? 'Start exploring the stars and unlock your driving potential'
                : 'Swipe back to fill in missing information',
            style: const TextStyle(color: Color(0xFFB0B0B0), fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    // Only show navigation buttons on the final step
    if (_currentStep != 3) {
      return const SizedBox.shrink();
    }

    // Check if all required fields are filled
    bool isComplete =
        userName != null &&
        userName!.trim().isNotEmpty &&
        selectedState != null &&
        selectedVehicleType != null;

    // Only show button if setup is complete
    if (!isComplete) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4A90E2), Color(0xFF7BB3F0)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4A90E2).withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: _completeOnboarding,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'Start Learning',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
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
