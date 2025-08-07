import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF4A90E2);
  static const Color primaryLight = Color(0xFF7BB3F0);
  static const Color primaryDark = Color(0xFF2E5C8A);

  // Secondary Colors
  static const Color secondary = Color(0xFF7BB3F0);
  static const Color secondaryLight = Color(0xFFA8C8F0);
  static const Color secondaryDark = Color(0xFF5A8BC0);

  // Background Colors
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Colors.white;
  static const Color cardBackground = Colors.white;

  // Text Colors
  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF7F8C8D);
  static const Color textLight = Color(0xFFBDC3C7);
  static const Color textWhite = Colors.white;

  // Status Colors
  static const Color success = Color(0xFF27AE60);
  static const Color warning = Color(0xFFF39C12);
  static const Color error = Color(0xFFE74C3C);
  static const Color info = Color(0xFF3498DB);

  // Vehicle Type Colors
  static const Color carColor = Color(0xFF4A90E2);
  static const Color motorcycleColor = Color(0xFFE74C3C);
  static const Color cdlColor = Color(0xFFF39C12);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primary, primaryLight],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [secondary, secondaryLight],
  );

  // Shadow Colors
  static Color shadowLight = Colors.black.withOpacity(0.05);
  static Color shadowMedium = Colors.black.withOpacity(0.1);
  static Color shadowDark = Colors.black.withOpacity(0.2);
  static Color primaryShadow = primary.withOpacity(0.3);

  // Border Colors
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color borderMedium = Color(0xFFD1D5DB);
  static const Color borderDark = Color(0xFF9CA3AF);

  // Overlay Colors
  static Color overlayLight = Colors.white.withOpacity(0.1);
  static Color overlayMedium = Colors.white.withOpacity(0.2);
  static Color overlayDark = Colors.white.withOpacity(0.3);

  // Selection Colors
  static Color selectionBackground = primary.withOpacity(0.1);
  static Color selectionBorder = primary;

  // Disabled Colors
  static const Color disabled = Color(0xFFE5E7EB);
  static const Color disabledText = Color(0xFF9CA3AF);

  // Material Color Scheme
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF4A90E2,
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(0xFF4A90E2), // Primary
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
  );

  // Helper methods
  static Color getVehicleColor(String vehicleType) {
    switch (vehicleType.toUpperCase()) {
      case 'CAR':
        return carColor;
      case 'MOTORCYCLE':
        return motorcycleColor;
      case 'CDL':
        return cdlColor;
      default:
        return primary;
    }
  }

  static ColorScheme getColorScheme({bool isDark = false}) {
    return ColorScheme.fromSeed(
      seedColor: primary,
      brightness: isDark ? Brightness.dark : Brightness.light,
      background: isDark ? const Color(0xFF1A1A1A) : background,
      surface: isDark ? const Color(0xFF2A2A2A) : surface,
      primary: primary,
      secondary: secondary,
      onBackground: isDark ? Colors.white : textPrimary,
      onSurface: isDark ? Colors.white : textPrimary,
    );
  }

  static BoxShadow getShadow({
    Color? color,
    double blurRadius = 10,
    Offset offset = const Offset(0, 2),
  }) {
    return BoxShadow(
      color: color ?? shadowLight,
      blurRadius: blurRadius,
      offset: offset,
    );
  }

  static BoxShadow getPrimaryShadow({
    double blurRadius = 10,
    Offset offset = const Offset(0, 4),
  }) {
    return BoxShadow(
      color: primaryShadow,
      blurRadius: blurRadius,
      offset: offset,
    );
  }
}
