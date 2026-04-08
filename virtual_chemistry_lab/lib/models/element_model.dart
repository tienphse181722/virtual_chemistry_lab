/// Element Model for Periodic Table
/// Quản lý thông tin nguyên tố hóa học
class ElementModel {
  final int atomicNumber;
  final String symbol;
  final String name;
  final String atomicMass;
  final String oxidationStates;
  final String category;
  final String description;

  ElementModel({
    required this.atomicNumber,
    required this.symbol,
    required this.name,
    required this.atomicMass,
    required this.oxidationStates,
    required this.category,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'atomicNumber': atomicNumber,
      'symbol': symbol,
      'name': name,
      'atomicMass': atomicMass,
      'oxidationStates': oxidationStates,
      'category': category,
      'description': description,
    };
  }

  factory ElementModel.fromMap(Map<String, dynamic> map) {
    return ElementModel(
      atomicNumber: map['atomicNumber'] is int 
          ? map['atomicNumber'] 
          : int.tryParse(map['atomicNumber'].toString()) ?? 0,
      symbol: map['symbol'] ?? '',
      name: map['name'] ?? '',
      atomicMass: map['atomicMass'] ?? '',
      oxidationStates: map['oxidationStates'] ?? '',
      category: map['category'] ?? '',
      description: map['description'] ?? '',
    );
  }

  // Get position in periodic table grid
  Map<String, int> getGridPosition() {
    // Period (row) based on atomic number
    int row = 0;
    if (atomicNumber <= 2) row = 0;
    else if (atomicNumber <= 10) row = 1;
    else if (atomicNumber <= 18) row = 2;
    else if (atomicNumber <= 36) row = 3;
    else if (atomicNumber <= 54) row = 4;
    else if (atomicNumber <= 86) row = 5;
    else row = 6;

    // Lanthanides (57-71) and Actinides (89-103) go to separate rows
    if (atomicNumber >= 58 && atomicNumber <= 71) {
      row = 8; // Lanthanides row
    } else if (atomicNumber >= 90 && atomicNumber <= 103) {
      row = 9; // Actinides row
    }

    // Group (column) - simplified positioning
    int col = 0;
    if (atomicNumber == 1) col = 0;
    else if (atomicNumber == 2) col = 17;
    else if ([3, 11, 19, 37, 55, 87].contains(atomicNumber)) col = 0;
    else if ([4, 12, 20, 38, 56, 88].contains(atomicNumber)) col = 1;
    else if (atomicNumber >= 21 && atomicNumber <= 30) col = atomicNumber - 19;
    else if (atomicNumber >= 39 && atomicNumber <= 48) col = atomicNumber - 37;
    else if (atomicNumber >= 72 && atomicNumber <= 80) col = atomicNumber - 69;
    else if (atomicNumber >= 104 && atomicNumber <= 112) col = atomicNumber - 101;
    else if ([5, 13, 31, 49, 81, 113].contains(atomicNumber)) col = 12;
    else if ([6, 14, 32, 50, 82, 114].contains(atomicNumber)) col = 13;
    else if ([7, 15, 33, 51, 83, 115].contains(atomicNumber)) col = 14;
    else if ([8, 16, 34, 52, 84, 116].contains(atomicNumber)) col = 15;
    else if ([9, 17, 35, 53, 85, 117].contains(atomicNumber)) col = 16;
    else if ([10, 18, 36, 54, 86, 118].contains(atomicNumber)) col = 17;
    else if (atomicNumber == 57 || atomicNumber == 89) col = 2;
    else if (atomicNumber >= 58 && atomicNumber <= 71) col = atomicNumber - 55;
    else if (atomicNumber >= 90 && atomicNumber <= 103) col = atomicNumber - 87;

    return {'row': row, 'col': col};
  }
}
