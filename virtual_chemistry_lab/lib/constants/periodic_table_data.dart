import 'package:flutter/material.dart';

/// Constants for Periodic Table
/// Only contains color mapping for categories
/// Element data is loaded from Firebase/JSON via ElementCacheService
class PeriodicTableData {
  static Color getColorForCategory(String category) {
    switch (category) {
      case 'Kim loại kiềm':
        return const Color(0xFFFFD54F);
      case 'Kim loại':
        return const Color(0xFF81D4FA);
      case 'Phi kim':
        return const Color(0xFFE57373);
      case 'Á kim':
        return const Color(0xFFCE93D8);
      case 'Khí hiếm':
        return const Color(0xFFFFF176);
      case 'Halogen':
        return const Color(0xFFF48FB1);
      case 'Đất hiếm':
        return const Color(0xFFFFAB91);
      case 'Actini':
        return const Color(0xFFBCAAA4);
      default:
        return const Color(0xFF81D4FA);
    }
  }
}
