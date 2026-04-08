import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';
import 'package:virtual_chemistry_lab/providers/auth_provider.dart';
import 'package:virtual_chemistry_lab/providers/progress_provider.dart';
import 'package:virtual_chemistry_lab/services/user_data_service.dart';

class MixChemicalsScreen extends StatefulWidget {
  const MixChemicalsScreen({super.key});

  @override
  State<MixChemicalsScreen> createState() => _MixChemicalsScreenState();
}

class _MixChemicalsScreenState extends State<MixChemicalsScreen> with TickerProviderStateMixin {
  String? _selectedChemical1;
  String? _selectedChemical2;
  Map<String, dynamic>? _result;
  bool _showResult = false;
  bool _isReacting = false;
  late AnimationController _reactionController;
  late AnimationController _bubbleController;
  late Animation<double> _reactionAnimation;
  final UserDataService _userDataService = UserDataService();

  @override
  void initState() {
    super.initState();
    _reactionController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _bubbleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _reactionAnimation = CurvedAnimation(
      parent: _reactionController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _reactionController.dispose();
    _bubbleController.dispose();
    super.dispose();
  }

  // Danh sách hóa chất
  final List<Map<String, dynamic>> _chemicals = [
    {
      'id': 'HCl',
      'name': 'Axit clohidric',
      'formula': 'HCl',
      'color': Color(0xFFFFCDD2),
      'icon': Icons.water_drop,
    },
    {
      'id': 'NaOH',
      'name': 'Natri hydroxide',
      'formula': 'NaOH',
      'color': Color(0xFFE1F5FE),
      'icon': Icons.water_drop,
    },
    {
      'id': 'H2SO4',
      'name': 'Axit sunfuric',
      'formula': 'H₂SO₄',
      'color': Color(0xFFFFF9C4),
      'icon': Icons.water_drop,
    },
    {
      'id': 'CuSO4',
      'name': 'Đồng(II) sunfat',
      'formula': 'CuSO₄',
      'color': Color(0xFF81D4FA),
      'icon': Icons.water_drop,
    },
    {
      'id': 'BaCl2',
      'name': 'Bari clorua',
      'formula': 'BaCl₂',
      'color': Color(0xFFFFF3E0),
      'icon': Icons.water_drop,
    },
    {
      'id': 'AgNO3',
      'name': 'Bạc nitrat',
      'formula': 'AgNO₃',
      'color': Color(0xFFE0E0E0),
      'icon': Icons.water_drop,
    },
    {
      'id': 'Na2CO3',
      'name': 'Natri cacbonat',
      'formula': 'Na₂CO₃',
      'color': Color(0xFFF5F5F5),
      'icon': Icons.water_drop,
    },
    {
      'id': 'FeCl3',
      'name': 'Sắt(III) clorua',
      'formula': 'FeCl₃',
      'color': Color(0xFFFFCC80),
      'icon': Icons.water_drop,
    },
    {
      'id': 'FeCl2',
      'name': 'Sắt(II) clorua',
      'formula': 'FeCl₂',
      'color': Color(0xFFB2DFDB),
      'icon': Icons.water_drop,
    },
    {
      'id': 'AlCl3',
      'name': 'Nhôm clorua',
      'formula': 'AlCl₃',
      'color': Color(0xFFF5F5F5),
      'icon': Icons.water_drop,
    },
    {
      'id': 'NH3',
      'name': 'Amoniac',
      'formula': 'NH₃',
      'color': Color(0xFFC8E6C9),
      'icon': Icons.cloud,
    },
    {
      'id': 'KOH',
      'name': 'Kali hydroxide',
      'formula': 'KOH',
      'color': Color(0xFFE8F5E9),
      'icon': Icons.water_drop,
    },
    {
      'id': 'Pb(NO3)2',
      'name': 'Chì(II) nitrat',
      'formula': 'Pb(NO₃)₂',
      'color': Color(0xFFECEFF1),
      'icon': Icons.water_drop,
    },
    {
      'id': 'ZnSO4',
      'name': 'Kẽm sunfat',
      'formula': 'ZnSO₄',
      'color': Color(0xFFF5F5F5),
      'icon': Icons.water_drop,
    },
    {
      'id': 'Ca(OH)2',
      'name': 'Canxi hydroxide',
      'formula': 'Ca(OH)₂',
      'color': Color(0xFFFFF9C4),
      'icon': Icons.water_drop,
    },
    {
      'id': 'NaCl',
      'name': 'Natri clorua',
      'formula': 'NaCl',
      'color': Color(0xFFF5F5F5),
      'icon': Icons.water_drop,
    },
  ];

  // Phản ứng chi tiết
  Map<String, dynamic> _getReactionResult(String chem1, String chem2) {
    final key1 = '${chem1}_$chem2';
    final key2 = '${chem2}_$chem1';
    
    final reactions = {
      // Phản ứng trung hòa axit-bazơ
      'HCl_NaOH': {
        'phenomenon': 'Dung dịch nóng lên, không có hiện tượng gì khác',
        'equation': 'HCl + NaOH → NaCl + H₂O',
        'resultColor': Color(0xFFF5F5F5),
        'explanation': 'Phản ứng trung hòa giữa axit và bazơ, tỏa nhiệt',
        'type': 'neutralization',
        'animation': 'heat',
      },
      'HCl_KOH': {
        'phenomenon': 'Dung dịch nóng lên, không có hiện tượng gì khác',
        'equation': 'HCl + KOH → KCl + H₂O',
        'resultColor': Color(0xFFF5F5F5),
        'explanation': 'Phản ứng trung hòa tạo muối và nước',
        'type': 'neutralization',
        'animation': 'heat',
      },
      'H2SO4_NaOH': {
        'phenomenon': 'Dung dịch nóng lên mạnh',
        'equation': 'H₂SO₄ + 2NaOH → Na₂SO₄ + 2H₂O',
        'resultColor': Color(0xFFF5F5F5),
        'explanation': 'Phản ứng trung hòa tỏa nhiệt mạnh',
        'type': 'neutralization',
        'animation': 'heat',
      },
      'H2SO4_KOH': {
        'phenomenon': 'Dung dịch nóng lên mạnh',
        'equation': 'H₂SO₄ + 2KOH → K₂SO₄ + 2H₂O',
        'resultColor': Color(0xFFF5F5F5),
        'explanation': 'Phản ứng trung hòa tỏa nhiệt',
        'type': 'neutralization',
        'animation': 'heat',
      },
      
      // Phản ứng tạo kết tủa với BaCl2
      'H2SO4_BaCl2': {
        'phenomenon': 'Xuất hiện kết tủa trắng',
        'equation': 'H₂SO₄ + BaCl₂ → BaSO₄↓ + 2HCl',
        'resultColor': Colors.white,
        'explanation': 'Kết tủa trắng BaSO₄ không tan trong axit',
        'type': 'precipitate',
        'animation': 'fall',
      },
      'Na2CO3_BaCl2': {
        'phenomenon': 'Xuất hiện kết tủa trắng',
        'equation': 'Na₂CO₃ + BaCl₂ → BaCO₃↓ + 2NaCl',
        'resultColor': Colors.white,
        'explanation': 'Kết tủa trắng BaCO₃',
        'type': 'precipitate',
        'animation': 'fall',
      },
      
      // Phản ứng với AgNO3
      'AgNO3_HCl': {
        'phenomenon': 'Xuất hiện kết tủa trắng',
        'equation': 'AgNO₃ + HCl → AgCl↓ + HNO₃',
        'resultColor': Colors.white,
        'explanation': 'Kết tủa trắng AgCl không tan trong axit',
        'type': 'precipitate',
        'animation': 'fall',
      },
      'AgNO3_NaCl': {
        'phenomenon': 'Xuất hiện kết tủa trắng',
        'equation': 'AgNO₃ + NaCl → AgCl↓ + NaNO₃',
        'resultColor': Colors.white,
        'explanation': 'Kết tủa trắng AgCl',
        'type': 'precipitate',
        'animation': 'fall',
      },
      'AgNO3_NaOH': {
        'phenomenon': 'Xuất hiện kết tủa nâu đen',
        'equation': '2AgNO₃ + 2NaOH → Ag₂O↓ + 2NaNO₃ + H₂O',
        'resultColor': Color(0xFF424242),
        'explanation': 'Tạo Ag₂O màu nâu đen',
        'type': 'precipitate',
        'animation': 'fall',
      },
      
      // Phản ứng với CuSO4
      'CuSO4_NaOH': {
        'phenomenon': 'Xuất hiện kết tủa xanh lam',
        'equation': 'CuSO₄ + 2NaOH → Cu(OH)₂↓ + Na₂SO₄',
        'resultColor': Color(0xFF4FC3F7),
        'explanation': 'Kết tủa xanh lam Cu(OH)₂',
        'type': 'precipitate',
        'animation': 'fall',
      },
      'CuSO4_KOH': {
        'phenomenon': 'Xuất hiện kết tủa xanh lam',
        'equation': 'CuSO₄ + 2KOH → Cu(OH)₂↓ + K₂SO₄',
        'resultColor': Color(0xFF4FC3F7),
        'explanation': 'Kết tủa xanh lam Cu(OH)₂',
        'type': 'precipitate',
        'animation': 'fall',
      },
      'CuSO4_NH3': {
        'phenomenon': 'Kết tủa xanh lam xuất hiện, sau đó tan tạo dung dịch xanh đậm',
        'equation': 'CuSO₄ + 4NH₃ + 2H₂O → [Cu(NH₃)₄]²⁺ + SO₄²⁻ + 2OH⁻',
        'resultColor': Color(0xFF0D47A1),
        'explanation': 'Tạo phức đồng-amoniac màu xanh đậm',
        'type': 'complex',
        'animation': 'dissolve',
      },
      'CuSO4_BaCl2': {
        'phenomenon': 'Xuất hiện kết tủa trắng',
        'equation': 'CuSO₄ + BaCl₂ → BaSO₄↓ + CuCl₂',
        'resultColor': Colors.white,
        'explanation': 'Kết tủa trắng BaSO₄',
        'type': 'precipitate',
        'animation': 'fall',
      },
      
      // Phản ứng với FeCl3
      'FeCl3_NaOH': {
        'phenomenon': 'Xuất hiện kết tủa nâu đỏ',
        'equation': 'FeCl₃ + 3NaOH → Fe(OH)₃↓ + 3NaCl',
        'resultColor': Color(0xFFD84315),
        'explanation': 'Kết tủa nâu đỏ Fe(OH)₃',
        'type': 'precipitate',
        'animation': 'fall',
      },
      'FeCl3_KOH': {
        'phenomenon': 'Xuất hiện kết tủa nâu đỏ',
        'equation': 'FeCl₃ + 3KOH → Fe(OH)₃↓ + 3KCl',
        'resultColor': Color(0xFFD84315),
        'explanation': 'Kết tủa nâu đỏ Fe(OH)₃',
        'type': 'precipitate',
        'animation': 'fall',
      },
      'FeCl3_NH3': {
        'phenomenon': 'Xuất hiện kết tủa nâu đỏ',
        'equation': 'FeCl₃ + 3NH₃ + 3H₂O → Fe(OH)₃↓ + 3NH₄Cl',
        'resultColor': Color(0xFFD84315),
        'explanation': 'Kết tủa Fe(OH)₃ không tan trong NH₃ dư',
        'type': 'precipitate',
        'animation': 'fall',
      },
      'FeCl3_AgNO3': {
        'phenomenon': 'Xuất hiện kết tủa trắng',
        'equation': 'FeCl₃ + 3AgNO₃ → 3AgCl↓ + Fe(NO₃)₃',
        'resultColor': Colors.white,
        'explanation': 'Kết tủa trắng AgCl',
        'type': 'precipitate',
        'animation': 'fall',
      },
      
      // Phản ứng với FeCl2
      'FeCl2_NaOH': {
        'phenomenon': 'Xuất hiện kết tủa trắng xanh, sau đó chuyển nâu đỏ',
        'equation': 'FeCl₂ + 2NaOH → Fe(OH)₂↓ + 2NaCl\n4Fe(OH)₂ + O₂ + 2H₂O → 4Fe(OH)₃',
        'resultColor': Color(0xFF80CBC4),
        'explanation': 'Fe(OH)₂ trắng xanh bị oxi hóa thành Fe(OH)₃ nâu đỏ',
        'type': 'precipitate',
        'animation': 'fall',
      },
      'FeCl2_KOH': {
        'phenomenon': 'Xuất hiện kết tủa trắng xanh',
        'equation': 'FeCl₂ + 2KOH → Fe(OH)₂↓ + 2KCl',
        'resultColor': Color(0xFF80CBC4),
        'explanation': 'Kết tủa trắng xanh Fe(OH)₂',
        'type': 'precipitate',
        'animation': 'fall',
      },
      'FeCl2_AgNO3': {
        'phenomenon': 'Xuất hiện kết tủa trắng',
        'equation': 'FeCl₂ + 2AgNO₃ → 2AgCl↓ + Fe(NO₃)₂',
        'resultColor': Colors.white,
        'explanation': 'Kết tủa trắng AgCl',
        'type': 'precipitate',
        'animation': 'fall',
      },
      
      // Phản ứng với AlCl3
      'AlCl3_NaOH': {
        'phenomenon': 'Xuất hiện kết tủa trắng, tan trong kiềm dư',
        'equation': 'AlCl₃ + 3NaOH → Al(OH)₃↓ + 3NaCl\nAl(OH)₃ + NaOH → NaAlO₂ + 2H₂O',
        'resultColor': Colors.white,
        'explanation': 'Al(OH)₃ lưỡng tính, tan trong kiềm dư',
        'type': 'precipitate_dissolve',
        'animation': 'fall_dissolve',
      },
      'AlCl3_KOH': {
        'phenomenon': 'Xuất hiện kết tủa trắng, tan trong kiềm dư',
        'equation': 'AlCl₃ + 3KOH → Al(OH)₃↓ + 3KCl\nAl(OH)₃ + KOH → KAlO₂ + 2H₂O',
        'resultColor': Colors.white,
        'explanation': 'Al(OH)₃ lưỡng tính',
        'type': 'precipitate_dissolve',
        'animation': 'fall_dissolve',
      },
      'AlCl3_NH3': {
        'phenomenon': 'Xuất hiện kết tủa trắng keo',
        'equation': 'AlCl₃ + 3NH₃ + 3H₂O → Al(OH)₃↓ + 3NH₄Cl',
        'resultColor': Colors.white,
        'explanation': 'Kết tủa trắng keo Al(OH)₃',
        'type': 'precipitate',
        'animation': 'fall',
      },
      'AlCl3_AgNO3': {
        'phenomenon': 'Xuất hiện kết tủa trắng',
        'equation': 'AlCl₃ + 3AgNO₃ → 3AgCl↓ + Al(NO₃)₃',
        'resultColor': Colors.white,
        'explanation': 'Kết tủa trắng AgCl',
        'type': 'precipitate',
        'animation': 'fall',
      },
      
      // Phản ứng với ZnSO4
      'ZnSO4_NaOH': {
        'phenomenon': 'Xuất hiện kết tủa trắng, tan trong kiềm dư',
        'equation': 'ZnSO₄ + 2NaOH → Zn(OH)₂↓ + Na₂SO₄\nZn(OH)₂ + 2NaOH → Na₂ZnO₂ + 2H₂O',
        'resultColor': Colors.white,
        'explanation': 'Zn(OH)₂ lưỡng tính, tan trong kiềm dư',
        'type': 'precipitate_dissolve',
        'animation': 'fall_dissolve',
      },
      'ZnSO4_KOH': {
        'phenomenon': 'Xuất hiện kết tủa trắng, tan trong kiềm dư',
        'equation': 'ZnSO₄ + 2KOH → Zn(OH)₂↓ + K₂SO₄',
        'resultColor': Colors.white,
        'explanation': 'Zn(OH)₂ lưỡng tính',
        'type': 'precipitate_dissolve',
        'animation': 'fall_dissolve',
      },
      'ZnSO4_BaCl2': {
        'phenomenon': 'Xuất hiện kết tủa trắng',
        'equation': 'ZnSO₄ + BaCl₂ → BaSO₄↓ + ZnCl₂',
        'resultColor': Colors.white,
        'explanation': 'Kết tủa trắng BaSO₄',
        'type': 'precipitate',
        'animation': 'fall',
      },
      
      // Phản ứng với Pb(NO3)2
      'Pb(NO3)2_HCl': {
        'phenomenon': 'Xuất hiện kết tủa trắng',
        'equation': 'Pb(NO₃)₂ + 2HCl → PbCl₂↓ + 2HNO₃',
        'resultColor': Colors.white,
        'explanation': 'Kết tủa trắng PbCl₂, tan trong nước nóng',
        'type': 'precipitate',
        'animation': 'fall',
      },
      'Pb(NO3)2_H2SO4': {
        'phenomenon': 'Xuất hiện kết tủa trắng',
        'equation': 'Pb(NO₃)₂ + H₂SO₄ → PbSO₄↓ + 2HNO₃',
        'resultColor': Colors.white,
        'explanation': 'Kết tủa trắng PbSO₄',
        'type': 'precipitate',
        'animation': 'fall',
      },
      'Pb(NO3)2_NaOH': {
        'phenomenon': 'Xuất hiện kết tủa trắng',
        'equation': 'Pb(NO₃)₂ + 2NaOH → Pb(OH)₂↓ + 2NaNO₃',
        'resultColor': Colors.white,
        'explanation': 'Kết tủa trắng Pb(OH)₂',
        'type': 'precipitate',
        'animation': 'fall',
      },
      'Pb(NO3)2_Na2CO3': {
        'phenomenon': 'Xuất hiện kết tủa trắng',
        'equation': 'Pb(NO₃)₂ + Na₂CO₃ → PbCO₃↓ + 2NaNO₃',
        'resultColor': Colors.white,
        'explanation': 'Kết tủa trắng PbCO₃',
        'type': 'precipitate',
        'animation': 'fall',
      },
      'Pb(NO3)2_NaCl': {
        'phenomenon': 'Xuất hiện kết tủa trắng',
        'equation': 'Pb(NO₃)₂ + 2NaCl → PbCl₂↓ + 2NaNO₃',
        'resultColor': Colors.white,
        'explanation': 'Kết tủa trắng PbCl₂',
        'type': 'precipitate',
        'animation': 'fall',
      },
      
      // Phản ứng với Na2CO3 (tạo khí CO2)
      'Na2CO3_HCl': {
        'phenomenon': 'Sủi bọt khí, có khí CO₂ thoát ra',
        'equation': 'Na₂CO₃ + 2HCl → 2NaCl + H₂O + CO₂↑',
        'resultColor': Color(0xFFF5F5F5),
        'explanation': 'Khí CO₂ thoát ra làm dung dịch sủi bọt',
        'type': 'gas',
        'animation': 'bubble',
      },
      'Na2CO3_H2SO4': {
        'phenomenon': 'Sủi bọt khí, có khí CO₂ thoát ra',
        'equation': 'Na₂CO₃ + H₂SO₄ → Na₂SO₄ + H₂O + CO₂↑',
        'resultColor': Color(0xFFF5F5F5),
        'explanation': 'Khí CO₂ thoát ra',
        'type': 'gas',
        'animation': 'bubble',
      },
      'Na2CO3_CuSO4': {
        'phenomenon': 'Xuất hiện kết tủa xanh lục',
        'equation': 'Na₂CO₃ + CuSO₄ → CuCO₃↓ + Na₂SO₄',
        'resultColor': Color(0xFF4DB6AC),
        'explanation': 'Kết tủa xanh lục CuCO₃',
        'type': 'precipitate',
        'animation': 'fall',
      },
      'Na2CO3_FeCl3': {
        'phenomenon': 'Xuất hiện kết tủa nâu đỏ và sủi bọt khí',
        'equation': '3Na₂CO₃ + 2FeCl₃ + 3H₂O → 2Fe(OH)₃↓ + 6NaCl + 3CO₂↑',
        'resultColor': Color(0xFFD84315),
        'explanation': 'Tạo Fe(OH)₃ và CO₂',
        'type': 'precipitate',
        'animation': 'fall',
      },
      'Na2CO3_AgNO3': {
        'phenomenon': 'Xuất hiện kết tủa trắng',
        'equation': 'Na₂CO₃ + 2AgNO₃ → Ag₂CO₃↓ + 2NaNO₃',
        'resultColor': Colors.white,
        'explanation': 'Kết tủa trắng Ag₂CO₃',
        'type': 'precipitate',
        'animation': 'fall',
      },
      
      // Phản ứng với Ca(OH)2
      'Ca(OH)2_HCl': {
        'phenomenon': 'Dung dịch trong suốt',
        'equation': 'Ca(OH)₂ + 2HCl → CaCl₂ + 2H₂O',
        'resultColor': Color(0xFFF5F5F5),
        'explanation': 'Phản ứng trung hòa',
        'type': 'neutralization',
        'animation': 'heat',
      },
      'Ca(OH)2_H2SO4': {
        'phenomenon': 'Xuất hiện kết tủa trắng',
        'equation': 'Ca(OH)₂ + H₂SO₄ → CaSO₄↓ + 2H₂O',
        'resultColor': Colors.white,
        'explanation': 'Kết tủa trắng CaSO₄',
        'type': 'precipitate',
        'animation': 'fall',
      },
      'Ca(OH)2_Na2CO3': {
        'phenomenon': 'Xuất hiện kết tủa trắng',
        'equation': 'Ca(OH)₂ + Na₂CO₃ → CaCO₃↓ + 2NaOH',
        'resultColor': Colors.white,
        'explanation': 'Kết tủa trắng CaCO₃',
        'type': 'precipitate',
        'animation': 'fall',
      },
      
      // Phản ứng không tạo sản phẩm đặc trưng
      'NaCl_NaOH': {
        'phenomenon': 'Không có hiện tượng gì',
        'equation': 'Không phản ứng',
        'resultColor': Colors.transparent,
        'explanation': 'Hai chất không phản ứng với nhau',
        'type': 'none',
        'animation': 'none',
      },
      'NaCl_KOH': {
        'phenomenon': 'Không có hiện tượng gì',
        'equation': 'Không phản ứng',
        'resultColor': Colors.transparent,
        'explanation': 'Hai chất không phản ứng với nhau',
        'type': 'none',
        'animation': 'none',
      },
    };

    return reactions[key1] ?? reactions[key2] ?? {
      'phenomenon': 'Không có phản ứng đặc trưng hoặc chỉ tạo dung dịch',
      'equation': 'Phản ứng trao đổi ion hoặc không phản ứng',
      'resultColor': Colors.grey.shade200,
      'explanation': 'Hai chất trộn lẫn nhưng không có hiện tượng đặc trưng để nhận biết',
      'type': 'none',
      'animation': 'none',
    };
  }

  void _performMix() async {
    if (_selectedChemical1 == null || _selectedChemical2 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng chọn 2 hóa chất'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (_selectedChemical1 == _selectedChemical2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng chọn 2 hóa chất khác nhau'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isReacting = true;
      _showResult = false;
    });

    _reactionController.forward(from: 0);

    await Future.delayed(const Duration(milliseconds: 2000));

    final result = _getReactionResult(_selectedChemical1!, _selectedChemical2!);

    setState(() {
      _result = result;
      _showResult = true;
      _isReacting = false;
    });
    
    // Save to Firebase
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final progressProvider = Provider.of<ProgressProvider>(context, listen: false);
    
    if (authProvider.user != null) {
      // Award points based on reaction type
      int points = 10;
      if (result['type'] == 'precipitate' || result['type'] == 'gas') {
        points = 15;
      } else if (result['type'] == 'complex' || result['type'] == 'precipitate_dissolve') {
        points = 20;
      }
      
      // Save to progress system
      await progressProvider.completeLab(
        authProvider.user!.uid,
        'mix_chemicals_${_selectedChemical1}_$_selectedChemical2',
        points,
      );
      
      // Save detailed experiment to Firebase
      final chem1 = _chemicals.firstWhere((c) => c['id'] == _selectedChemical1);
      final chem2 = _chemicals.firstWhere((c) => c['id'] == _selectedChemical2);
      
      await _userDataService.saveLabExperiment(
        userId: authProvider.user!.uid,
        labType: 'mix_chemicals',
        experimentName: '${chem1['name']} + ${chem2['name']}',
        inputs: {
          'chemical1': {'id': _selectedChemical1, 'name': chem1['name'], 'formula': chem1['formula']},
          'chemical2': {'id': _selectedChemical2, 'name': chem2['name'], 'formula': chem2['formula']},
        },
        results: {
          'phenomenon': result['phenomenon'],
          'equation': result['equation'],
          'explanation': result['explanation'],
          'type': result['type'],
          'points': points,
        },
        successful: result['type'] != 'none',
      );
      
      // Log activity
      await _userDataService.logActivity(
        userId: authProvider.user!.uid,
        activityType: 'lab',
        action: 'complete',
        itemId: 'mix_chemicals',
        metadata: {
          'chemical1': _selectedChemical1,
          'chemical2': _selectedChemical2,
          'reactionType': result['type'],
          'points': points,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final scaleX = width / 440;

    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Trộn Hóa Chất',
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
                    '1. Chọn hóa chất thứ nhất\n'
                    '2. Chọn hóa chất thứ hai\n'
                    '3. Nhấn "Trộn hóa chất"\n'
                    '4. Quan sát hiện tượng và kết luận',
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
                  colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16 * scaleX),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF1976D2).withOpacity(0.3),
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
                    child: Icon(Icons.science, color: Colors.white, size: 32 * scaleX),
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
                          'Trộn hóa chất và quan sát phản ứng',
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

            // Chemical 1 selection
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: Row(
                children: [
                  Icon(Icons.science, color: AppColors.primary, size: 20 * scaleX),
                  SizedBox(width: 8 * scaleX),
                  Text(
                    'Chọn hóa chất thứ nhất:',
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

            // Chemicals grid 1
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10 * scaleX,
                  mainAxisSpacing: 10 * scaleX,
                  childAspectRatio: 0.75,
                ),
                itemCount: _chemicals.length,
                itemBuilder: (context, index) {
                  final chemical = _chemicals[index];
                  final isSelected = _selectedChemical1 == chemical['id'];
                  return GestureDetector(
                    onTap: () => setState(() {
                      _selectedChemical1 = chemical['id'];
                      _showResult = false;
                    }),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      padding: EdgeInsets.all(8 * scaleX),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12 * scaleX),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : Colors.grey.shade300,
                          width: isSelected ? 3 : 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isSelected 
                                ? AppColors.primary.withOpacity(0.3)
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
                              color: chemical['color'],
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade300, width: 2),
                            ),
                            child: Icon(
                              chemical['icon'],
                              color: AppColors.primary,
                              size: 20 * scaleX,
                            ),
                          ),
                          SizedBox(height: 6 * scaleX),
                          Text(
                            chemical['formula'],
                            style: TextStyle(
                              fontSize: 11 * scaleX,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 2 * scaleX),
                          Text(
                            chemical['name'],
                            style: TextStyle(
                              fontSize: 7 * scaleX,
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

            // Chemical 2 selection
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: Row(
                children: [
                  Icon(Icons.science, color: AppColors.primary, size: 20 * scaleX),
                  SizedBox(width: 8 * scaleX),
                  Text(
                    'Chọn hóa chất thứ hai:',
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

            // Chemicals grid 2
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10 * scaleX,
                  mainAxisSpacing: 10 * scaleX,
                  childAspectRatio: 0.75,
                ),
                itemCount: _chemicals.length,
                itemBuilder: (context, index) {
                  final chemical = _chemicals[index];
                  final isSelected = _selectedChemical2 == chemical['id'];
                  return GestureDetector(
                    onTap: () => setState(() {
                      _selectedChemical2 = chemical['id'];
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
                              color: chemical['color'],
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade300, width: 2),
                            ),
                            child: Icon(
                              chemical['icon'],
                              color: Colors.green,
                              size: 20 * scaleX,
                            ),
                          ),
                          SizedBox(height: 6 * scaleX),
                          Text(
                            chemical['formula'],
                            style: TextStyle(
                              fontSize: 11 * scaleX,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 2 * scaleX),
                          Text(
                            chemical['name'],
                            style: TextStyle(
                              fontSize: 7 * scaleX,
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

            // Beaker visualization
            _buildBeaker(scaleX),

            SizedBox(height: 24 * scaleX),

            // Mix button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: SizedBox(
                width: double.infinity,
                height: 56 * scaleX,
                child: ElevatedButton(
                  onPressed: _isReacting ? null : _performMix,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16 * scaleX),
                    ),
                    elevation: 4,
                  ),
                  child: _isReacting
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20 * scaleX,
                              height: 20 * scaleX,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                            SizedBox(width: 12 * scaleX),
                            Text(
                              'Đang phản ứng...',
                              style: TextStyle(
                                fontSize: 16 * scaleX,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.play_arrow, color: Colors.white, size: 24 * scaleX),
                            SizedBox(width: 8 * scaleX),
                            Text(
                              'Trộn hóa chất',
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

  Widget _buildBeaker(double scale) {
    Color beakerColor = Colors.grey.shade100;
    
    if (_selectedChemical1 != null && _selectedChemical2 != null) {
      final chem1 = _chemicals.firstWhere((c) => c['id'] == _selectedChemical1);
      final chem2 = _chemicals.firstWhere((c) => c['id'] == _selectedChemical2);
      beakerColor = Color.lerp(chem1['color'], chem2['color'], 0.5)!;
    }

    if (_showResult && _result != null && _result!['resultColor'] != Colors.transparent) {
      beakerColor = _result!['resultColor'];
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16 * scale),
      padding: EdgeInsets.all(24 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.science, color: AppColors.primary, size: 20 * scale),
              SizedBox(width: 8 * scale),
              Text(
                'Cốc phản ứng',
                style: TextStyle(
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 20 * scale),
          
          // Beaker
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 150 * scale,
                height: 200 * scale,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20 * scale),
                    bottomRight: Radius.circular(20 * scale),
                  ),
                  border: Border.all(color: Colors.grey.shade400, width: 3),
                ),
              ),
              
              // Liquid inside
              Positioned(
                bottom: 3,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: 144 * scale,
                  height: _isReacting ? 160 * scale : 140 * scale,
                  decoration: BoxDecoration(
                    color: beakerColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(17 * scale),
                      bottomRight: Radius.circular(17 * scale),
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Precipitate particles falling
                      if (_isReacting && _result != null && _result!['type'] == 'precipitate')
                        ...List.generate(10, (index) {
                          return AnimatedBuilder(
                            animation: _reactionAnimation,
                            builder: (context, child) {
                              final delay = index * 0.08;
                              final progress = (_reactionAnimation.value - delay).clamp(0.0, 1.0);
                              return Positioned(
                                left: (20 + index * 12) * scale,
                                top: progress * 120 * scale,
                                child: Container(
                                  width: 6 * scale,
                                  height: 6 * scale,
                                  decoration: BoxDecoration(
                                    color: _result!['resultColor'],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      
                      // Precipitate layer at bottom
                      if (_showResult && _result != null && _result!['type'] == 'precipitate')
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 40 * scale,
                            decoration: BoxDecoration(
                              color: _result!['resultColor'],
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(17 * scale),
                                bottomRight: Radius.circular(17 * scale),
                              ),
                            ),
                          ),
                        ),
                      
                      // Bubbles for gas evolution
                      if (_isReacting && _result != null && _result!['type'] == 'gas')
                        ...List.generate(8, (index) {
                          return AnimatedBuilder(
                            animation: _bubbleController,
                            builder: (context, child) {
                              final offset = (index * 0.15 + _bubbleController.value) % 1.0;
                              return Positioned(
                                left: (30 + index * 15) * scale,
                                bottom: offset * 130 * scale,
                                child: Container(
                                  width: 10 * scale,
                                  height: 10 * scale,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.7),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      
                      // Chemical labels
                      if (_selectedChemical1 != null && _selectedChemical2 != null && !_isReacting)
                        Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 8 * scale),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(8 * scale),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _chemicals.firstWhere((c) => c['id'] == _selectedChemical1)['formula'],
                                  style: TextStyle(
                                    fontSize: 16 * scale,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                                Text(
                                  '+',
                                  style: TextStyle(
                                    fontSize: 14 * scale,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                Text(
                                  _chemicals.firstWhere((c) => c['id'] == _selectedChemical2)['formula'],
                                  style: TextStyle(
                                    fontSize: 16 * scale,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard(double scale) {
    final phenomenon = _result!['phenomenon'] as String;
    final equation = _result!['equation'] as String;
    final explanation = _result!['explanation'] as String;
    final type = _result!['type'] as String;

    Color borderColor = Colors.green;
    Color bgColor = Colors.green.shade50;
    IconData icon = Icons.check_circle;

    if (type == 'none') {
      borderColor = Colors.grey;
      bgColor = Colors.grey.shade100;
      icon = Icons.info_outline;
    } else if (type == 'precipitate') {
      borderColor = Colors.blue;
      bgColor = Colors.blue.shade50;
      icon = Icons.arrow_downward;
    } else if (type == 'gas') {
      borderColor = Colors.orange;
      bgColor = Colors.orange.shade50;
      icon = Icons.bubble_chart;
    } else if (type == 'neutralization') {
      borderColor = Colors.purple;
      bgColor = Colors.purple.shade50;
      icon = Icons.balance;
    }

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
                    'Kết quả phản ứng',
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
                _buildResultSection(
                  '🔬 Hiện tượng quan sát',
                  phenomenon,
                  scale,
                ),
                
                SizedBox(height: 16 * scale),
                
                // Equation
                _buildResultSection(
                  '⚗️ Phương trình phản ứng',
                  equation,
                  scale,
                ),
                
                SizedBox(height: 16 * scale),
                
                // Explanation
                _buildResultSection(
                  '💡 Giải thích',
                  explanation,
                  scale,
                ),
                
                SizedBox(height: 20 * scale),
                
                // Conclusion
                Container(
                  padding: EdgeInsets.all(16 * scale),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [borderColor.withOpacity(0.1), borderColor.withOpacity(0.05)],
                    ),
                    borderRadius: BorderRadius.circular(12 * scale),
                    border: Border.all(color: borderColor.withOpacity(0.3), width: 2),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.science, color: borderColor, size: 24 * scale),
                      SizedBox(width: 12 * scale),
                      Expanded(
                        child: Text(
                          type == 'none' 
                              ? 'Không có phản ứng đặc trưng'
                              : 'Phản ứng hoàn thành thành công',
                          style: TextStyle(
                            fontSize: 14 * scale,
                            fontWeight: FontWeight.bold,
                            color: borderColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultSection(String title, String content, double scale) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14 * scale,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
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
            content,
            style: TextStyle(
              fontSize: 13 * scale,
              color: AppColors.textPrimary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
