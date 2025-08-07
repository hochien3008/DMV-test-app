import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_settings_provider.dart';
import '../utils/color.dart';
import 'main_screen.dart';

class VehicleTypeSelectionScreen extends StatefulWidget {
  const VehicleTypeSelectionScreen({super.key});

  @override
  State<VehicleTypeSelectionScreen> createState() =>
      _VehicleTypeSelectionScreenState();
}

class _VehicleTypeSelectionScreenState
    extends State<VehicleTypeSelectionScreen> {
  String? selectedVehicleType;

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

  void _proceedToApp() {
    if (selectedVehicleType != null) {
      // Save vehicle type to provider
      final appSettings = Provider.of<AppSettingsProvider>(
        context,
        listen: false,
      );
      appSettings.setSelectedLicenseType(selectedVehicleType!);

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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a vehicle type'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.drive_eta,
                      size: 48,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Choose Vehicle Type',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Select the type of vehicle you want to drive',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Vehicle Types Grid
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Car
                          _buildVehicleCard(vehicleTypes[0]),
                          const SizedBox(height: 20),
                          // Motorcycle
                          _buildVehicleCard(vehicleTypes[1]),
                          const SizedBox(height: 20),
                          // CDL
                          _buildVehicleCard(vehicleTypes[2]),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Continue Button
                    Container(
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
                        onPressed: _proceedToApp,
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
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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
      ),
    );
  }

  Widget _buildVehicleCard(Map<String, dynamic> vehicleType) {
    final isSelected = selectedVehicleType == vehicleType['code'];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedVehicleType = vehicleType['code'];
        });
      },
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? vehicleType['color'].withOpacity(0.3)
                  : Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
          border: isSelected
              ? Border.all(color: vehicleType['color'], width: 3)
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
                color: isSelected ? Colors.white : vehicleType['color'],
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
                          : const Color(0xFF2C3E50),
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
    );
  }
}
