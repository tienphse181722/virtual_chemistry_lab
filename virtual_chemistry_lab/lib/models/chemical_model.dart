/// Chemical Model
/// Quản lý thông tin hóa chất
class ChemicalModel {
  final String id;
  final String name;
  final String formula;
  final String description;
  final String imageUrl;
  final String hazardLevel; // 'low', 'medium', 'high'
  final String state; // 'solid', 'liquid', 'gas'
  final String color;

  ChemicalModel({
    required this.id,
    required this.name,
    required this.formula,
    required this.description,
    required this.imageUrl,
    this.hazardLevel = 'low',
    this.state = 'solid',
    this.color = 'white',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'formula': formula,
      'description': description,
      'imageUrl': imageUrl,
      'hazardLevel': hazardLevel,
      'state': state,
      'color': color,
    };
  }

  factory ChemicalModel.fromMap(Map<String, dynamic> map) {
    return ChemicalModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      formula: map['formula'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      hazardLevel: map['hazardLevel'] ?? 'low',
      state: map['state'] ?? 'solid',
      color: map['color'] ?? 'white',
    );
  }
}

