import 'package:virtual_chemistry_lab/models/chemical_model.dart';

class ChemistryEngine {
  // Mix two chemicals
  static String mixChemicals(ChemicalModel chemical1, ChemicalModel chemical2) {
    final key = '${chemical1.formula}_${chemical2.formula}';
    
    // Predefined reactions
    final reactions = {
      'HCl_NaOH': 'NaCl + H2O (Muối ăn và nước)',
      'H2SO4_NaOH': 'Na2SO4 + H2O (Natri sunfat và nước)',
      'HCl_Zn': 'ZnCl2 + H2 (Kẽm clorua và khí hydro)',
      'H2_O2': 'H2O (Nước)',
      'Na_H2O': 'NaOH + H2 (Natri hydroxit và khí hydro - Phản ứng mạnh!)',
    };

    return reactions[key] ?? 'Không có phản ứng xảy ra';
  }

  // Burn a chemical
  static String burnChemical(ChemicalModel chemical) {
    final burnReactions = {
      'C': 'CO2 (Khí carbon dioxide)',
      'H2': 'H2O (Nước)',
      'CH4': 'CO2 + H2O (Khí carbon dioxide và nước)',
      'C2H5OH': 'CO2 + H2O (Khí carbon dioxide và nước)',
      'S': 'SO2 (Khí sulfur dioxide)',
    };

    return burnReactions[chemical.formula] ?? 
           '${chemical.formula} + O2 → Sản phẩm cháy';
  }

  // Balance chemical equation
  static String balanceEquation(String equation) {
    // Simple balancing logic (can be expanded)
    final commonEquations = {
      'H2 + O2 → H2O': '2H2 + O2 → 2H2O',
      'N2 + H2 → NH3': 'N2 + 3H2 → 2NH3',
      'CH4 + O2 → CO2 + H2O': 'CH4 + 2O2 → CO2 + 2H2O',
      'Fe + O2 → Fe2O3': '4Fe + 3O2 → 2Fe2O3',
      'C + O2 → CO2': 'C + O2 → CO2',
    };

    return commonEquations[equation] ?? 'Phương trình chưa được cân bằng';
  }

  // Check if equation is balanced
  static bool isBalanced(String equation) {
    // Simple check (can be improved)
    final balanced = [
      '2H2 + O2 → 2H2O',
      'N2 + 3H2 → 2NH3',
      'CH4 + 2O2 → CO2 + 2H2O',
    ];
    
    return balanced.contains(equation);
  }

  // Get safety information
  static String getSafetyInfo(ChemicalModel chemical) {
    if (chemical.hazardLevel == 'high') {
      return '⚠️ NGUY HIỂM: ${chemical.name} là chất nguy hiểm. Cần bảo hộ đầy đủ!';
    } else if (chemical.hazardLevel == 'medium') {
      return '⚠️ CẢNH BÁO: ${chemical.name} cần thận trọng khi sử dụng.';
    }
    return '✓ AN TOÀN: ${chemical.name} tương đối an toàn.';
  }
}
