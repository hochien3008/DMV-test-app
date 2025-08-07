import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_settings_provider.dart';
import '../utils/color.dart';
import 'vehicle_type_selection_screen.dart';

class StateSelectionScreen extends StatefulWidget {
  const StateSelectionScreen({super.key});

  @override
  State<StateSelectionScreen> createState() => _StateSelectionScreenState();
}

class _StateSelectionScreenState extends State<StateSelectionScreen> {
  String? selectedState;
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _proceedToVehicleType() {
    if (selectedState != null) {
      // Save state to provider
      final appSettings = Provider.of<AppSettingsProvider>(
        context,
        listen: false,
      );
      appSettings.setSelectedState(selectedState!);

      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const VehicleTypeSelectionScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a state'),
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
                      Icons.location_on,
                      size: 48,
                      color: AppColors.textWhite,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Choose Your State',
                    style: TextStyle(
                      color: AppColors.textWhite,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Select the state where you want to get your license',
                    style: TextStyle(color: AppColors.textWhite, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: Column(
                children: [
                  // Search Box
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search states...',
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color(0xFF7F8C8D),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // States Grid
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: isSelected
                                        ? const Color(
                                            0xFF4A90E2,
                                          ).withOpacity(0.3)
                                        : Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                border: isSelected
                                    ? Border.all(
                                        color: const Color(0xFF4A90E2),
                                        width: 2,
                                      )
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
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return Container(
                                                width: 40,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: AppColors.primary
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    state['abbr']!,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors.primary,
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
                                          : const Color(0xFF2C3E50),
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
                  ),

                  // Continue Button
                  Padding(
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
                        onPressed: _proceedToVehicleType,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
