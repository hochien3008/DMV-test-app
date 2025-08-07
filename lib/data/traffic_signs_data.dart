// Import tất cả các file biển báo
import 'warning_signs.dart';
import 'regulatory_signs.dart';
import 'info_signs.dart';
import 'freeway_signs.dart';
import 'tourist_signs.dart';

// Hàm để lấy tất cả biển báo
List<Map<String, String>> getAllTrafficSigns() {
  return [
    ...warningSigns,
    ...regulatorySigns,
    ...infoSigns,
    ...freewaySigns,
    ...touristSigns,
  ];
}

// Hàm để lọc biển báo theo category
List<Map<String, String>> getTrafficSignsByCategory(String category) {
  switch (category) {
    case 'Warning':
      return warningSigns;
    case 'Regulatory':
      return regulatorySigns;
    case 'Information':
      return infoSigns;
    case 'Freeway':
      return freewaySigns;
    case 'Tourist':
      return touristSigns;
    default:
      return getAllTrafficSigns();
  }
}

// Hàm để tìm kiếm biển báo
List<Map<String, String>> searchTrafficSigns(String query, String category) {
  List<Map<String, String>> signs = getTrafficSignsByCategory(category);

  if (query.isEmpty) {
    return signs;
  }

  return signs.where((sign) {
    final name = sign['name']?.toLowerCase() ?? '';
    final description = sign['description']?.toLowerCase() ?? '';
    final code = sign['code']?.toLowerCase() ?? '';
    final searchQuery = query.toLowerCase();

    return name.contains(searchQuery) ||
        description.contains(searchQuery) ||
        code.contains(searchQuery);
  }).toList();
}

// Hàm để lấy danh sách categories
List<String> getTrafficSignCategories() {
  return ['All', 'Warning', 'Regulatory', 'Information', 'Freeway', 'Tourist'];
}

// Hàm để lấy số lượng biển báo theo category
Map<String, int> getTrafficSignsCount() {
  return {
    'Warning': warningSigns.length,
    'Regulatory': regulatorySigns.length,
    'Information': infoSigns.length,
    'Freeway': freewaySigns.length,
    'Tourist': touristSigns.length,
    'All': getAllTrafficSigns().length,
  };
}
