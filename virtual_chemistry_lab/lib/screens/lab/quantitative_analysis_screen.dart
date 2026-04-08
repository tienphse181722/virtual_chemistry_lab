import 'package:flutter/material.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';

class QuantitativeAnalysisScreen extends StatefulWidget {
  const QuantitativeAnalysisScreen({super.key});

  @override
  State<QuantitativeAnalysisScreen> createState() => _QuantitativeAnalysisScreenState();
}

class _QuantitativeAnalysisScreenState extends State<QuantitativeAnalysisScreen> with TickerProviderStateMixin {
  String? _selectedAnalyte;
  String? _selectedTitrant;
  double _volumeAdded = 0.0;
  bool _showResult = false;
  Map<String, dynamic>? _result;
  late AnimationController _dropController;
  late AnimationController _colorController;

  @override
  void initState() {
    super.initState();
    _dropController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _colorController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _dropController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  // Danh sách chất cần phân tích (20 chất)
  final List<Map<String, dynamic>> _analytes = [
    // Axit mạnh
    {
      'id': 'HCl',
      'name': 'Axit HCl',
      'formula': 'HCl',
      'concentration': 0.1,
      'color': Color(0xFFFFCDD2),
      'icon': Icons.water_drop,
      'type': 'strong_acid',
    },
    {
      'id': 'H2SO4',
      'name': 'Axit H₂SO₄',
      'formula': 'H₂SO₄',
      'concentration': 0.1,
      'color': Color(0xFFFFF9C4),
      'icon': Icons.water_drop,
      'type': 'strong_acid',
    },
    {
      'id': 'HNO3',
      'name': 'Axit HNO₃',
      'formula': 'HNO₃',
      'concentration': 0.1,
      'color': Color(0xFFFFE0B2),
      'icon': Icons.water_drop,
      'type': 'strong_acid',
    },
    {
      'id': 'HBr',
      'name': 'Axit HBr',
      'formula': 'HBr',
      'concentration': 0.1,
      'color': Color(0xFFFFCCBC),
      'icon': Icons.water_drop,
      'type': 'strong_acid',
    },
    {
      'id': 'HClO4',
      'name': 'Axit HClO₄',
      'formula': 'HClO₄',
      'concentration': 0.1,
      'color': Color(0xFFFFE0B2),
      'icon': Icons.water_drop,
      'type': 'strong_acid',
    },
    // Axit yếu
    {
      'id': 'CH3COOH',
      'name': 'Axit axetic',
      'formula': 'CH₃COOH',
      'concentration': 0.1,
      'color': Color(0xFFF5F5F5),
      'icon': Icons.water_drop,
      'type': 'weak_acid',
    },
    {
      'id': 'HCOOH',
      'name': 'Axit formic',
      'formula': 'HCOOH',
      'concentration': 0.1,
      'color': Color(0xFFFFF3E0),
      'icon': Icons.water_drop,
      'type': 'weak_acid',
    },
    {
      'id': 'H3PO4',
      'name': 'Axit photphoric',
      'formula': 'H₃PO₄',
      'concentration': 0.1,
      'color': Color(0xFFE0F2F1),
      'icon': Icons.water_drop,
      'type': 'weak_acid',
    },
    {
      'id': 'H2CO3',
      'name': 'Axit cacbonic',
      'formula': 'H₂CO₃',
      'concentration': 0.1,
      'color': Color(0xFFE1F5FE),
      'icon': Icons.water_drop,
      'type': 'weak_acid',
    },
    {
      'id': 'C6H5COOH',
      'name': 'Axit benzoic',
      'formula': 'C₆H₅COOH',
      'concentration': 0.1,
      'color': Color(0xFFFFF8E1),
      'icon': Icons.water_drop,
      'type': 'weak_acid',
    },
    // Bazơ mạnh
    {
      'id': 'NaOH',
      'name': 'Bazơ NaOH',
      'formula': 'NaOH',
      'concentration': 0.1,
      'color': Color(0xFFE1F5FE),
      'icon': Icons.water_drop,
      'type': 'strong_base',
    },
    {
      'id': 'KOH',
      'name': 'Bazơ KOH',
      'formula': 'KOH',
      'concentration': 0.1,
      'color': Color(0xFFE8F5E9),
      'icon': Icons.water_drop,
      'type': 'strong_base',
    },
    {
      'id': 'Ba(OH)2',
      'name': 'Bazơ Ba(OH)₂',
      'formula': 'Ba(OH)₂',
      'concentration': 0.1,
      'color': Color(0xFFFFF9C4),
      'icon': Icons.water_drop,
      'type': 'strong_base',
    },
    {
      'id': 'Ca(OH)2',
      'name': 'Bazơ Ca(OH)₂',
      'formula': 'Ca(OH)₂',
      'concentration': 0.1,
      'color': Color(0xFFFFF8E1),
      'icon': Icons.water_drop,
      'type': 'strong_base',
    },
    {
      'id': 'LiOH',
      'name': 'Bazơ LiOH',
      'formula': 'LiOH',
      'concentration': 0.1,
      'color': Color(0xFFE3F2FD),
      'icon': Icons.water_drop,
      'type': 'strong_base',
    },
    // Bazơ yếu
    {
      'id': 'NH3',
      'name': 'Bazơ NH₃',
      'formula': 'NH₃',
      'concentration': 0.1,
      'color': Color(0xFFC8E6C9),
      'icon': Icons.water_drop,
      'type': 'weak_base',
    },
    {
      'id': 'CH3NH2',
      'name': 'Metylamin',
      'formula': 'CH₃NH₂',
      'concentration': 0.1,
      'color': Color(0xFFB2DFDB),
      'icon': Icons.water_drop,
      'type': 'weak_base',
    },
    {
      'id': 'C5H5N',
      'name': 'Pyridin',
      'formula': 'C₅H₅N',
      'concentration': 0.1,
      'color': Color(0xFFB2EBF2),
      'icon': Icons.water_drop,
      'type': 'weak_base',
    },
    {
      'id': 'C6H5NH2',
      'name': 'Anilin',
      'formula': 'C₆H₅NH₂',
      'concentration': 0.1,
      'color': Color(0xFFD1C4E9),
      'icon': Icons.water_drop,
      'type': 'weak_base',
    },
    {
      'id': '(CH3)2NH',
      'name': 'Đimetylamin',
      'formula': '(CH₃)₂NH',
      'concentration': 0.1,
      'color': Color(0xFFC5CAE9),
      'icon': Icons.water_drop,
      'type': 'weak_base',
    },
  ];

  // Danh sách thuốc thử chuẩn độ (8 thuốc thử)
  final List<Map<String, dynamic>> _titrants = [
    {
      'id': 'NaOH_standard',
      'name': 'NaOH chuẩn',
      'formula': 'NaOH 0.1M',
      'concentration': 0.1,
      'color': Color(0xFFE1F5FE),
      'icon': Icons.science,
      'type': 'strong_base',
    },
    {
      'id': 'HCl_standard',
      'name': 'HCl chuẩn',
      'formula': 'HCl 0.1M',
      'concentration': 0.1,
      'color': Color(0xFFFFCDD2),
      'icon': Icons.science,
      'type': 'strong_acid',
    },
    {
      'id': 'KOH_standard',
      'name': 'KOH chuẩn',
      'formula': 'KOH 0.1M',
      'concentration': 0.1,
      'color': Color(0xFFE8F5E9),
      'icon': Icons.science,
      'type': 'strong_base',
    },
    {
      'id': 'H2SO4_standard',
      'name': 'H₂SO₄ chuẩn',
      'formula': 'H₂SO₄ 0.1M',
      'concentration': 0.1,
      'color': Color(0xFFFFF9C4),
      'icon': Icons.science,
      'type': 'strong_acid',
    },
    {
      'id': 'HNO3_standard',
      'name': 'HNO₃ chuẩn',
      'formula': 'HNO₃ 0.1M',
      'concentration': 0.1,
      'color': Color(0xFFFFE0B2),
      'icon': Icons.science,
      'type': 'strong_acid',
    },
    {
      'id': 'Ba(OH)2_standard',
      'name': 'Ba(OH)₂ chuẩn',
      'formula': 'Ba(OH)₂ 0.1M',
      'concentration': 0.1,
      'color': Color(0xFFFFF9C4),
      'icon': Icons.science,
      'type': 'strong_base',
    },
    {
      'id': 'Ca(OH)2_standard',
      'name': 'Ca(OH)₂ chuẩn',
      'formula': 'Ca(OH)₂ 0.1M',
      'concentration': 0.1,
      'color': Color(0xFFFFF8E1),
      'icon': Icons.science,
      'type': 'strong_base',
    },
    {
      'id': 'NH3_standard',
      'name': 'NH₃ chuẩn',
      'formula': 'NH₃ 0.1M',
      'concentration': 0.1,
      'color': Color(0xFFC8E6C9),
      'icon': Icons.science,
      'type': 'weak_base',
    },
  ];

  Map<String, dynamic> _getTitrationResult(String analyte, String titrant, double volume) {
    // Lấy thông tin chất
    final analyteData = _analytes.firstWhere((a) => a['id'] == analyte);
    final titrantData = _titrants.firstWhere((t) => t['id'] == titrant);
    
    // Kiểm tra tính hợp lệ của chuẩn độ
    String analyteType = analyteData['type'];
    String titrantType = titrantData['type'];
    
    // Chỉ chuẩn độ được khi axit-bazơ ngược nhau
    bool isValidTitration = (analyteType.contains('acid') && titrantType.contains('base')) ||
                           (analyteType.contains('base') && titrantType.contains('acid'));
    
    if (!isValidTitration) {
      return {
        'solutionColor': Colors.grey.shade300,
        'phenomenon': 'Không thể chuẩn độ: ${analyteData['formula']} và ${titrantData['formula']} không phản ứng với nhau',
        'calculation': 'Chuẩn độ axit-bazơ yêu cầu một chất là axit và một chất là bazơ.',
        'isEquivalence': false,
        'equivalenceVolume': 0,
        'calculatedConcentration': 0,
        'actualConcentration': 0,
      };
    }
    
    // Tính toán điểm tương đương
    double equivalenceVolume = 10.0; // mL - thể tích tương đương
    
    // Điều chỉnh cho H2SO4 (2 H+) và Ba(OH)2 (2 OH-)
    if (analyteData['id'] == 'H2SO4' || titrantData['id'] == 'H2SO4_standard') {
      equivalenceVolume = 5.0; // Cần ít hơn vì có 2 H+
    }
    if (analyteData['id'] == 'Ba(OH)2') {
      equivalenceVolume = 5.0; // Cần ít hơn vì có 2 OH-
    }
    if (analyteData['id'] == 'H3PO4') {
      equivalenceVolume = 30.0; // Cần nhiều hơn vì có 3 H+
    }
    
    bool isNearEquivalence = (volume - equivalenceVolume).abs() < 0.5;
    bool isPastEquivalence = volume > equivalenceVolume;
    
    Color solutionColor;
    String phenomenon;
    String calculation;
    
    if (volume < equivalenceVolume - 0.5) {
      solutionColor = analyteData['color'];
      phenomenon = 'Dung dịch chưa đổi màu, chưa đạt điểm tương đương';
    } else if (isNearEquivalence) {
      solutionColor = Color(0xFFFFB6C1);
      phenomenon = 'Dung dịch chuyển màu hồng nhạt - Đạt điểm tương đương!';
    } else {
      solutionColor = Color(0xFFFF69B4);
      phenomenon = 'Dung dịch chuyển màu hồng đậm - Đã qua điểm tương đương';
    }
    
    // Tính toán nồng độ
    double calculatedConcentration = (titrantData['concentration'] * volume) / 10.0;
    
    // Điều chỉnh cho axit/bazơ đa chức
    if (analyteData['id'] == 'H2SO4') {
      calculatedConcentration = calculatedConcentration / 2;
    }
    if (analyteData['id'] == 'Ba(OH)2') {
      calculatedConcentration = calculatedConcentration / 2;
    }
    if (analyteData['id'] == 'H3PO4') {
      calculatedConcentration = calculatedConcentration / 3;
    }
    
    // Phương trình phản ứng
    String equation = _getReactionEquation(analyteData['id'], titrantData['id']);
    
    calculation = '''
Phương trình: $equation

Công thức: C₁V₁ = C₂V₂

Với:
• C₁ (${titrantData['formula']}): ${titrantData['concentration']} M
• V₁ (thể tích đã thêm): ${volume.toStringAsFixed(1)} mL
• V₂ (thể tích mẫu): 10.0 mL

Nồng độ ${analyteData['formula']}:
C₂ = (C₁ × V₁) / V₂
C₂ = (${titrantData['concentration']} × ${volume.toStringAsFixed(1)}) / 10.0
C₂ = ${calculatedConcentration.toStringAsFixed(3)} M

Nồng độ thực tế: ${analyteData['concentration']} M
Sai số: ${((calculatedConcentration - analyteData['concentration']).abs() / analyteData['concentration'] * 100).toStringAsFixed(1)}%
''';
    
    return {
      'solutionColor': solutionColor,
      'phenomenon': phenomenon,
      'calculation': calculation,
      'isEquivalence': isNearEquivalence,
      'equivalenceVolume': equivalenceVolume,
      'calculatedConcentration': calculatedConcentration,
      'actualConcentration': analyteData['concentration'],
    };
  }

  String _getReactionEquation(String analyteId, String titrantId) {
    // Tự động tạo phương trình dựa trên loại axit/bazơ
    final analyteData = _analytes.firstWhere((a) => a['id'] == analyteId);
    final titrantData = _titrants.firstWhere((t) => t['id'] == titrantId);
    
    String analyteType = analyteData['type'];
    String titrantType = titrantData['type'];
    
    // Kiểm tra tính hợp lệ
    if (!((analyteType.contains('acid') && titrantType.contains('base')) ||
          (analyteType.contains('base') && titrantType.contains('acid')))) {
      return 'Không phản ứng';
    }
    
    // Tạo phương trình tự động
    String analyteFormula = analyteId;
    String titrantFormula = titrantId.replaceAll('_standard', '');
    
    // Các phương trình cụ thể
    final specificEquations = {
      // Axit mạnh + Bazơ mạnh
      'HCl_NaOH': 'HCl + NaOH → NaCl + H₂O',
      'HCl_KOH': 'HCl + KOH → KCl + H₂O',
      'HCl_Ba(OH)2': '2HCl + Ba(OH)₂ → BaCl₂ + 2H₂O',
      'HCl_Ca(OH)2': '2HCl + Ca(OH)₂ → CaCl₂ + 2H₂O',
      'HCl_LiOH': 'HCl + LiOH → LiCl + H₂O',
      
      'H2SO4_NaOH': 'H₂SO₄ + 2NaOH → Na₂SO₄ + 2H₂O',
      'H2SO4_KOH': 'H₂SO₄ + 2KOH → K₂SO₄ + 2H₂O',
      'H2SO4_Ba(OH)2': 'H₂SO₄ + Ba(OH)₂ → BaSO₄↓ + 2H₂O',
      'H2SO4_Ca(OH)2': 'H₂SO₄ + Ca(OH)₂ → CaSO₄↓ + 2H₂O',
      'H2SO4_LiOH': 'H₂SO₄ + 2LiOH → Li₂SO₄ + 2H₂O',
      
      'HNO3_NaOH': 'HNO₃ + NaOH → NaNO₃ + H₂O',
      'HNO3_KOH': 'HNO₃ + KOH → KNO₃ + H₂O',
      'HNO3_Ba(OH)2': '2HNO₃ + Ba(OH)₂ → Ba(NO₃)₂ + 2H₂O',
      'HNO3_Ca(OH)2': '2HNO₃ + Ca(OH)₂ → Ca(NO₃)₂ + 2H₂O',
      'HNO3_LiOH': 'HNO₃ + LiOH → LiNO₃ + H₂O',
      
      'HBr_NaOH': 'HBr + NaOH → NaBr + H₂O',
      'HBr_KOH': 'HBr + KOH → KBr + H₂O',
      'HBr_Ba(OH)2': '2HBr + Ba(OH)₂ → BaBr₂ + 2H₂O',
      'HBr_Ca(OH)2': '2HBr + Ca(OH)₂ → CaBr₂ + 2H₂O',
      
      'HClO4_NaOH': 'HClO₄ + NaOH → NaClO₄ + H₂O',
      'HClO4_KOH': 'HClO₄ + KOH → KClO₄ + H₂O',
      'HClO4_Ba(OH)2': '2HClO₄ + Ba(OH)₂ → Ba(ClO₄)₂ + 2H₂O',
      
      // Axit yếu + Bazơ mạnh
      'CH3COOH_NaOH': 'CH₃COOH + NaOH → CH₃COONa + H₂O',
      'CH3COOH_KOH': 'CH₃COOH + KOH → CH₃COOK + H₂O',
      'CH3COOH_Ba(OH)2': '2CH₃COOH + Ba(OH)₂ → (CH₃COO)₂Ba + 2H₂O',
      'CH3COOH_Ca(OH)2': '2CH₃COOH + Ca(OH)₂ → (CH₃COO)₂Ca + 2H₂O',
      
      'HCOOH_NaOH': 'HCOOH + NaOH → HCOONa + H₂O',
      'HCOOH_KOH': 'HCOOH + KOH → HCOOK + H₂O',
      'HCOOH_Ba(OH)2': '2HCOOH + Ba(OH)₂ → (HCOO)₂Ba + 2H₂O',
      
      'H3PO4_NaOH': 'H₃PO₄ + 3NaOH → Na₃PO₄ + 3H₂O',
      'H3PO4_KOH': 'H₃PO₄ + 3KOH → K₃PO₄ + 3H₂O',
      'H3PO4_Ba(OH)2': '2H₃PO₄ + 3Ba(OH)₂ → Ba₃(PO₄)₂↓ + 6H₂O',
      
      'H2CO3_NaOH': 'H₂CO₃ + 2NaOH → Na₂CO₃ + 2H₂O',
      'H2CO3_KOH': 'H₂CO₃ + 2KOH → K₂CO₃ + 2H₂O',
      
      'C6H5COOH_NaOH': 'C₆H₅COOH + NaOH → C₆H₅COONa + H₂O',
      'C6H5COOH_KOH': 'C₆H₅COOH + KOH → C₆H₅COOK + H₂O',
      
      // Bazơ mạnh + Axit mạnh
      'NaOH_HCl': 'NaOH + HCl → NaCl + H₂O',
      'NaOH_H2SO4': '2NaOH + H₂SO₄ → Na₂SO₄ + 2H₂O',
      'NaOH_HNO3': 'NaOH + HNO₃ → NaNO₃ + H₂O',
      'NaOH_HBr': 'NaOH + HBr → NaBr + H₂O',
      'NaOH_HClO4': 'NaOH + HClO₄ → NaClO₄ + H₂O',
      
      'KOH_HCl': 'KOH + HCl → KCl + H₂O',
      'KOH_H2SO4': '2KOH + H₂SO₄ → K₂SO₄ + 2H₂O',
      'KOH_HNO3': 'KOH + HNO₃ → KNO₃ + H₂O',
      'KOH_HBr': 'KOH + HBr → KBr + H₂O',
      
      'Ba(OH)2_HCl': 'Ba(OH)₂ + 2HCl → BaCl₂ + 2H₂O',
      'Ba(OH)2_H2SO4': 'Ba(OH)₂ + H₂SO₄ → BaSO₄↓ + 2H₂O',
      'Ba(OH)2_HNO3': 'Ba(OH)₂ + 2HNO₃ → Ba(NO₃)₂ + 2H₂O',
      
      'Ca(OH)2_HCl': 'Ca(OH)₂ + 2HCl → CaCl₂ + 2H₂O',
      'Ca(OH)2_H2SO4': 'Ca(OH)₂ + H₂SO₄ → CaSO₄↓ + 2H₂O',
      'Ca(OH)2_HNO3': 'Ca(OH)₂ + 2HNO₃ → Ca(NO₃)₂ + 2H₂O',
      
      'LiOH_HCl': 'LiOH + HCl → LiCl + H₂O',
      'LiOH_H2SO4': '2LiOH + H₂SO₄ → Li₂SO₄ + 2H₂O',
      'LiOH_HNO3': 'LiOH + HNO₃ → LiNO₃ + H₂O',
      
      // Bazơ yếu + Axit mạnh
      'NH3_HCl': 'NH₃ + HCl → NH₄Cl',
      'NH3_H2SO4': '2NH₃ + H₂SO₄ → (NH₄)₂SO₄',
      'NH3_HNO3': 'NH₃ + HNO₃ → NH₄NO₃',
      'NH3_HBr': 'NH₃ + HBr → NH₄Br',
      
      'CH3NH2_HCl': 'CH₃NH₂ + HCl → CH₃NH₃Cl',
      'CH3NH2_H2SO4': '2CH₃NH₂ + H₂SO₄ → (CH₃NH₃)₂SO₄',
      
      'C5H5N_HCl': 'C₅H₅N + HCl → C₅H₅NHCl',
      'C5H5N_H2SO4': '2C₅H₅N + H₂SO₄ → (C₅H₅NH)₂SO₄',
      
      'C6H5NH2_HCl': 'C₆H₅NH₂ + HCl → C₆H₅NH₃Cl',
      'C6H5NH2_H2SO4': '2C₆H₅NH₂ + H₂SO₄ → (C₆H₅NH₃)₂SO₄',
      
      '(CH3)2NH_HCl': '(CH₃)₂NH + HCl → (CH₃)₂NH₂Cl',
      '(CH3)2NH_H2SO4': '2(CH₃)₂NH + H₂SO₄ → [(CH₃)₂NH₂]₂SO₄',
    };
    
    String key = '${analyteId}_$titrantFormula';
    return specificEquations[key] ?? 'Phản ứng trung hòa axit-bazơ';
  }

  void _performTitration() async {
    if (_selectedAnalyte == null || _selectedTitrant == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng chọn chất cần phân tích và thuốc thử'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    _dropController.forward(from: 0);
    _colorController.forward(from: 0);

    await Future.delayed(const Duration(milliseconds: 800));

    final result = _getTitrationResult(_selectedAnalyte!, _selectedTitrant!, _volumeAdded);

    setState(() {
      _result = result;
      _showResult = true;
    });

    _dropController.reset();
    _colorController.reset();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final scaleX = width / 440;

    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Phân Tích Định Lượng',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20 * scaleX),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Hướng dẫn'),
                  content: Text(
                    '1. Chọn chất cần phân tích\n'
                    '2. Chọn thuốc thử chuẩn độ\n'
                    '3. Điều chỉnh thể tích thuốc thử\n'
                    '4. Nhấn "Chuẩn độ" để xem kết quả\n'
                    '5. Quan sát màu sắc và tính toán nồng độ',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Đóng'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(16 * scaleX),
              padding: EdgeInsets.all(20 * scaleX),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFD32F2F), Color(0xFFEF5350)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16 * scaleX),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFD32F2F).withOpacity(0.3),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12 * scaleX),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12 * scaleX),
                    ),
                    child: Icon(Icons.analytics, color: Colors.white, size: 32 * scaleX),
                  ),
                  SizedBox(width: 16 * scaleX),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phòng thí nghiệm ảo',
                          style: TextStyle(
                            fontSize: 18 * scaleX,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4 * scaleX),
                        Text(
                          'Chuẩn độ axit-bazơ và tính toán nồng độ',
                          style: TextStyle(
                            fontSize: 13 * scaleX,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Analyte selection
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: Row(
                children: [
                  Icon(Icons.science, color: Colors.red, size: 20 * scaleX),
                  SizedBox(width: 8 * scaleX),
                  Text(
                    'Chọn chất cần phân tích:',
                    style: TextStyle(
                      fontSize: 16 * scaleX,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12 * scaleX),

            // Analytes grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10 * scaleX,
                  mainAxisSpacing: 10 * scaleX,
                  childAspectRatio: 0.85,
                ),
                itemCount: _analytes.length,
                itemBuilder: (context, index) {
                  final analyte = _analytes[index];
                  final isSelected = _selectedAnalyte == analyte['id'];
                  return GestureDetector(
                    onTap: () => setState(() {
                      _selectedAnalyte = analyte['id'];
                      _showResult = false;
                    }),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      padding: EdgeInsets.all(8 * scaleX),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12 * scaleX),
                        border: Border.all(
                          color: isSelected ? Colors.red : Colors.grey.shade300,
                          width: isSelected ? 3 : 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isSelected 
                                ? Colors.red.withOpacity(0.3)
                                : Colors.black.withOpacity(0.05),
                            blurRadius: isSelected ? 12 : 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 40 * scaleX,
                            height: 40 * scaleX,
                            decoration: BoxDecoration(
                              color: analyte['color'],
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade300, width: 2),
                            ),
                            child: Icon(
                              analyte['icon'],
                              color: Colors.red,
                              size: 20 * scaleX,
                            ),
                          ),
                          SizedBox(height: 6 * scaleX),
                          Text(
                            analyte['formula'],
                            style: TextStyle(
                              fontSize: 11 * scaleX,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 2 * scaleX),
                          Text(
                            analyte['name'],
                            style: TextStyle(
                              fontSize: 8 * scaleX,
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 24 * scaleX),

            // Titrant selection
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: Row(
                children: [
                  Icon(Icons.science, color: Colors.red, size: 20 * scaleX),
                  SizedBox(width: 8 * scaleX),
                  Text(
                    'Chọn thuốc thử chuẩn độ:',
                    style: TextStyle(
                      fontSize: 16 * scaleX,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12 * scaleX),

            // Titrants grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10 * scaleX,
                  mainAxisSpacing: 10 * scaleX,
                  childAspectRatio: 0.85,
                ),
                itemCount: _titrants.length,
                itemBuilder: (context, index) {
                  final titrant = _titrants[index];
                  final isSelected = _selectedTitrant == titrant['id'];
                  return GestureDetector(
                    onTap: () => setState(() {
                      _selectedTitrant = titrant['id'];
                      _showResult = false;
                    }),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      padding: EdgeInsets.all(8 * scaleX),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12 * scaleX),
                        border: Border.all(
                          color: isSelected ? Colors.green : Colors.grey.shade300,
                          width: isSelected ? 3 : 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isSelected 
                                ? Colors.green.withOpacity(0.3)
                                : Colors.black.withOpacity(0.05),
                            blurRadius: isSelected ? 12 : 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 40 * scaleX,
                            height: 40 * scaleX,
                            decoration: BoxDecoration(
                              color: titrant['color'],
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade300, width: 2),
                            ),
                            child: Icon(
                              titrant['icon'],
                              color: Colors.green,
                              size: 20 * scaleX,
                            ),
                          ),
                          SizedBox(height: 6 * scaleX),
                          Text(
                            titrant['formula'],
                            style: TextStyle(
                              fontSize: 10 * scaleX,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 2 * scaleX),
                          Text(
                            titrant['name'],
                            style: TextStyle(
                              fontSize: 8 * scaleX,
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 24 * scaleX),

            // Volume control
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: Container(
                padding: EdgeInsets.all(16 * scaleX),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16 * scaleX),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Thể tích thuốc thử:',
                          style: TextStyle(
                            fontSize: 14 * scaleX,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          '${_volumeAdded.toStringAsFixed(1)} mL',
                          style: TextStyle(
                            fontSize: 18 * scaleX,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12 * scaleX),
                    Slider(
                      value: _volumeAdded,
                      min: 0,
                      max: 20,
                      divisions: 40,
                      activeColor: Colors.red,
                      label: '${_volumeAdded.toStringAsFixed(1)} mL',
                      onChanged: (value) {
                        setState(() {
                          _volumeAdded = value;
                          _showResult = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24 * scaleX),

            // Titration button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: SizedBox(
                width: double.infinity,
                height: 56 * scaleX,
                child: ElevatedButton(
                  onPressed: _performTitration,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16 * scaleX),
                    ),
                    elevation: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_arrow, color: Colors.white, size: 24 * scaleX),
                      SizedBox(width: 8 * scaleX),
                      Text(
                        'Chuẩn độ',
                        style: TextStyle(
                          fontSize: 16 * scaleX,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Result display
            if (_showResult && _result != null)
              _buildResultCard(scaleX),

            SizedBox(height: 32 * scaleX),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(double scale) {
    final phenomenon = _result!['phenomenon'] as String;
    final calculation = _result!['calculation'] as String;
    final isEquivalence = _result!['isEquivalence'] as bool;

    Color borderColor = isEquivalence ? Colors.green : Colors.orange;
    Color bgColor = isEquivalence ? Colors.green.shade50 : Colors.orange.shade50;
    IconData icon = isEquivalence ? Icons.check_circle : Icons.info;

    return Container(
      margin: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        boxShadow: [
          BoxShadow(
            color: borderColor.withOpacity(0.2),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(16 * scale),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16 * scale),
                topRight: Radius.circular(16 * scale),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10 * scale),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: borderColor, size: 28 * scale),
                ),
                SizedBox(width: 12 * scale),
                Expanded(
                  child: Text(
                    'Kết quả chuẩn độ',
                    style: TextStyle(
                      fontSize: 18 * scale,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(20 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Phenomenon
                Text(
                  '🔬 Hiện tượng quan sát',
                  style: TextStyle(
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 8 * scale),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14 * scale),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F7FA),
                    borderRadius: BorderRadius.circular(10 * scale),
                  ),
                  child: Text(
                    phenomenon,
                    style: TextStyle(
                      fontSize: 13 * scale,
                      color: AppColors.textPrimary,
                      height: 1.5,
                    ),
                  ),
                ),
                
                SizedBox(height: 16 * scale),
                
                // Calculation
                Text(
                  '📊 Tính toán nồng độ',
                  style: TextStyle(
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 8 * scale),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14 * scale),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F7FA),
                    borderRadius: BorderRadius.circular(10 * scale),
                  ),
                  child: Text(
                    calculation,
                    style: TextStyle(
                      fontSize: 12 * scale,
                      color: AppColors.textPrimary,
                      height: 1.6,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
