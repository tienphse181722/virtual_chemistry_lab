import 'package:flutter/material.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';

class ElectrolysisScreen extends StatefulWidget {
  const ElectrolysisScreen({super.key});

  @override
  State<ElectrolysisScreen> createState() => _ElectrolysisScreenState();
}

class _ElectrolysisScreenState extends State<ElectrolysisScreen> with TickerProviderStateMixin {
  String? _selectedSolution;
  Map<String, dynamic>? _result;
  bool _showResult = false;
  bool _isElectrolyzing = false;
  late AnimationController _bubbleController;
  late AnimationController _electronController;

  @override
  void initState() {
    super.initState();
    _bubbleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _electronController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _bubbleController.dispose();
    _electronController.dispose();
    super.dispose();
  }

  // Danh sách dung dịch điện phân
  final List<Map<String, dynamic>> _solutions = [
    {
      'id': 'H2O',
      'name': 'Nước (có H₂SO₄)',
      'formula': 'H₂O',
      'color': Color(0xFFE1F5FE),
      'icon': Icons.water_drop,
    },
    {
      'id': 'NaCl',
      'name': 'Natri clorua',
      'formula': 'NaCl',
      'color': Color(0xFFF5F5F5),
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
      'id': 'NaOH',
      'name': 'Natri hydroxide',
      'formula': 'NaOH',
      'color': Color(0xFFE8F5E9),
      'icon': Icons.water_drop,
    },
    {
      'id': 'H2SO4',
      'name': 'Axit sunfuric loãng',
      'formula': 'H₂SO₄',
      'color': Color(0xFFFFF9C4),
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
      'id': 'KI',
      'name': 'Kali iodua',
      'formula': 'KI',
      'color': Color(0xFFFFE0B2),
      'icon': Icons.water_drop,
    },
    {
      'id': 'Al2O3',
      'name': 'Nhôm oxit nóng chảy',
      'formula': 'Al₂O₃',
      'color': Color(0xFFECEFF1),
      'icon': Icons.circle,
    },
    {
      'id': 'CuCl2',
      'name': 'Đồng(II) clorua',
      'formula': 'CuCl₂',
      'color': Color(0xFF80DEEA),
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
      'id': 'KOH',
      'name': 'Kali hydroxide',
      'formula': 'KOH',
      'color': Color(0xFFE8F5E9),
      'icon': Icons.water_drop,
    },
    {
      'id': 'HCl',
      'name': 'Axit clohidric',
      'formula': 'HCl',
      'color': Color(0xFFFFCDD2),
      'icon': Icons.water_drop,
    },
    {
      'id': 'NaBr',
      'name': 'Natri bromua',
      'formula': 'NaBr',
      'color': Color(0xFFFFE0B2),
      'icon': Icons.water_drop,
    },
    {
      'id': 'FeSO4',
      'name': 'Sắt(II) sunfat',
      'formula': 'FeSO₄',
      'color': Color(0xFFB2DFDB),
      'icon': Icons.water_drop,
    },
    {
      'id': 'NiSO4',
      'name': 'Niken sunfat',
      'formula': 'NiSO₄',
      'color': Color(0xFFA5D6A7),
      'icon': Icons.water_drop,
    },
    {
      'id': 'Na2SO4',
      'name': 'Natri sunfat',
      'formula': 'Na₂SO₄',
      'color': Color(0xFFF5F5F5),
      'icon': Icons.water_drop,
    },
  ];

  // Phản ứng điện phân chi tiết
  Map<String, dynamic> _getElectrolysisResult(String solution) {
    final reactions = {
      'H2O': {
        'cathode': 'Khí H₂ thoát ra ở catot',
        'anode': 'Khí O₂ thoát ra ở anot',
        'cathodeEquation': '2H₂O + 2e⁻ → H₂↑ + 2OH⁻',
        'anodeEquation': '2H₂O → O₂↑ + 4H⁺ + 4e⁻',
        'overallEquation': '2H₂O → 2H₂↑ + O₂↑',
        'explanation': 'Điện phân nước tạo khí H₂ ở catot và O₂ ở anot với tỉ lệ 2:1',
        'cathodeColor': Color(0xFF90CAF9),
        'anodeColor': Color(0xFFFFCDD2),
        'hasCathodeBubbles': true,
        'hasAnodeBubbles': true,
        'hasDeposit': false,
      },
      'NaCl': {
        'cathode': 'Khí H₂ thoát ra ở catot',
        'anode': 'Khí Cl₂ thoát ra ở anot',
        'cathodeEquation': '2H₂O + 2e⁻ → H₂↑ + 2OH⁻',
        'anodeEquation': '2Cl⁻ → Cl₂↑ + 2e⁻',
        'overallEquation': '2NaCl + 2H₂O → 2NaOH + H₂↑ + Cl₂↑',
        'explanation': 'Điện phân dung dịch NaCl tạo H₂, Cl₂ và NaOH',
        'cathodeColor': Color(0xFF90CAF9),
        'anodeColor': Color(0xFFFFF59D),
        'hasCathodeBubbles': true,
        'hasAnodeBubbles': true,
        'hasDeposit': false,
      },
      'CuSO4': {
        'cathode': 'Đồng kim loại bám vào catot',
        'anode': 'Khí O₂ thoát ra ở anot',
        'cathodeEquation': 'Cu²⁺ + 2e⁻ → Cu',
        'anodeEquation': '2H₂O → O₂↑ + 4H⁺ + 4e⁻',
        'overallEquation': '2CuSO₄ + 2H₂O → 2Cu + 2H₂SO₄ + O₂↑',
        'explanation': 'Đồng bám vào catot, oxi thoát ra ở anot',
        'cathodeColor': Color(0xFFFF6F00),
        'anodeColor': Color(0xFFFFCDD2),
        'hasCathodeBubbles': false,
        'hasAnodeBubbles': true,
        'hasDeposit': true,
      },
      'NaOH': {
        'cathode': 'Khí H₂ thoát ra ở catot',
        'anode': 'Khí O₂ thoát ra ở anot',
        'cathodeEquation': '2H₂O + 2e⁻ → H₂↑ + 2OH⁻',
        'anodeEquation': '4OH⁻ → O₂↑ + 2H₂O + 4e⁻',
        'overallEquation': '2H₂O → 2H₂↑ + O₂↑',
        'explanation': 'Điện phân dung dịch NaOH tạo H₂ và O₂',
        'cathodeColor': Color(0xFF90CAF9),
        'anodeColor': Color(0xFFFFCDD2),
        'hasCathodeBubbles': true,
        'hasAnodeBubbles': true,
        'hasDeposit': false,
      },
      'H2SO4': {
        'cathode': 'Khí H₂ thoát ra ở catot',
        'anode': 'Khí O₂ thoát ra ở anot',
        'cathodeEquation': '2H⁺ + 2e⁻ → H₂↑',
        'anodeEquation': '2H₂O → O₂↑ + 4H⁺ + 4e⁻',
        'overallEquation': '2H₂O → 2H₂↑ + O₂↑',
        'explanation': 'Điện phân H₂SO₄ loãng tạo H₂ và O₂',
        'cathodeColor': Color(0xFF90CAF9),
        'anodeColor': Color(0xFFFFCDD2),
        'hasCathodeBubbles': true,
        'hasAnodeBubbles': true,
        'hasDeposit': false,
      },
      'AgNO3': {
        'cathode': 'Bạc kim loại bám vào catot',
        'anode': 'Khí O₂ thoát ra ở anot',
        'cathodeEquation': 'Ag⁺ + e⁻ → Ag',
        'anodeEquation': '2H₂O → O₂↑ + 4H⁺ + 4e⁻',
        'overallEquation': '4AgNO₃ + 2H₂O → 4Ag + 4HNO₃ + O₂↑',
        'explanation': 'Bạc bám vào catot, oxi thoát ra ở anot',
        'cathodeColor': Color(0xFFE0E0E0),
        'anodeColor': Color(0xFFFFCDD2),
        'hasCathodeBubbles': false,
        'hasAnodeBubbles': true,
        'hasDeposit': true,
      },
      'KI': {
        'cathode': 'Khí H₂ thoát ra ở catot',
        'anode': 'Iot thoát ra ở anot, dung dịch chuyển màu nâu',
        'cathodeEquation': '2H₂O + 2e⁻ → H₂↑ + 2OH⁻',
        'anodeEquation': '2I⁻ → I₂ + 2e⁻',
        'overallEquation': '2KI + 2H₂O → 2KOH + H₂↑ + I₂',
        'explanation': 'H₂ thoát ra ở catot, I₂ màu nâu tạo thành ở anot',
        'cathodeColor': Color(0xFF90CAF9),
        'anodeColor': Color(0xFF8D6E63),
        'hasCathodeBubbles': true,
        'hasAnodeBubbles': false,
        'hasDeposit': false,
      },
      'Al2O3': {
        'cathode': 'Nhôm nóng chảy thu được ở catot',
        'anode': 'Khí O₂ thoát ra ở anot',
        'cathodeEquation': 'Al³⁺ + 3e⁻ → Al',
        'anodeEquation': '2O²⁻ → O₂↑ + 4e⁻',
        'overallEquation': '2Al₂O₃ → 4Al + 3O₂↑',
        'explanation': 'Điện phân nóng chảy Al₂O₃ thu được nhôm lỏng',
        'cathodeColor': Color(0xFFB0BEC5),
        'anodeColor': Color(0xFFFFCDD2),
        'hasCathodeBubbles': false,
        'hasAnodeBubbles': true,
        'hasDeposit': true,
      },
      'CuCl2': {
        'cathode': 'Đồng kim loại bám vào catot',
        'anode': 'Khí Cl₂ thoát ra ở anot',
        'cathodeEquation': 'Cu²⁺ + 2e⁻ → Cu',
        'anodeEquation': '2Cl⁻ → Cl₂↑ + 2e⁻',
        'overallEquation': 'CuCl₂ → Cu + Cl₂↑',
        'explanation': 'Đồng bám vào catot, clo thoát ra ở anot',
        'cathodeColor': Color(0xFFFF6F00),
        'anodeColor': Color(0xFFFFF59D),
        'hasCathodeBubbles': false,
        'hasAnodeBubbles': true,
        'hasDeposit': true,
      },
      'ZnSO4': {
        'cathode': 'Kẽm kim loại bám vào catot',
        'anode': 'Khí O₂ thoát ra ở anot',
        'cathodeEquation': 'Zn²⁺ + 2e⁻ → Zn',
        'anodeEquation': '2H₂O → O₂↑ + 4H⁺ + 4e⁻',
        'overallEquation': '2ZnSO₄ + 2H₂O → 2Zn + 2H₂SO₄ + O₂↑',
        'explanation': 'Kẽm bám vào catot, oxi thoát ra ở anot',
        'cathodeColor': Color(0xFFCFD8DC),
        'anodeColor': Color(0xFFFFCDD2),
        'hasCathodeBubbles': false,
        'hasAnodeBubbles': true,
        'hasDeposit': true,
      },
      'KOH': {
        'cathode': 'Khí H₂ thoát ra ở catot',
        'anode': 'Khí O₂ thoát ra ở anot',
        'cathodeEquation': '2H₂O + 2e⁻ → H₂↑ + 2OH⁻',
        'anodeEquation': '4OH⁻ → O₂↑ + 2H₂O + 4e⁻',
        'overallEquation': '2H₂O → 2H₂↑ + O₂↑',
        'explanation': 'Điện phân dung dịch KOH tạo H₂ và O₂',
        'cathodeColor': Color(0xFF90CAF9),
        'anodeColor': Color(0xFFFFCDD2),
        'hasCathodeBubbles': true,
        'hasAnodeBubbles': true,
        'hasDeposit': false,
      },
      'HCl': {
        'cathode': 'Khí H₂ thoát ra ở catot',
        'anode': 'Khí Cl₂ thoát ra ở anot',
        'cathodeEquation': '2H⁺ + 2e⁻ → H₂↑',
        'anodeEquation': '2Cl⁻ → Cl₂↑ + 2e⁻',
        'overallEquation': '2HCl → H₂↑ + Cl₂↑',
        'explanation': 'Điện phân HCl tạo H₂ và Cl₂',
        'cathodeColor': Color(0xFF90CAF9),
        'anodeColor': Color(0xFFFFF59D),
        'hasCathodeBubbles': true,
        'hasAnodeBubbles': true,
        'hasDeposit': false,
      },
      'NaBr': {
        'cathode': 'Khí H₂ thoát ra ở catot',
        'anode': 'Brom thoát ra ở anot, dung dịch chuyển màu nâu đỏ',
        'cathodeEquation': '2H₂O + 2e⁻ → H₂↑ + 2OH⁻',
        'anodeEquation': '2Br⁻ → Br₂ + 2e⁻',
        'overallEquation': '2NaBr + 2H₂O → 2NaOH + H₂↑ + Br₂',
        'explanation': 'H₂ thoát ra ở catot, Br₂ màu nâu đỏ tạo thành ở anot',
        'cathodeColor': Color(0xFF90CAF9),
        'anodeColor': Color(0xFFD84315),
        'hasCathodeBubbles': true,
        'hasAnodeBubbles': false,
        'hasDeposit': false,
      },
      'FeSO4': {
        'cathode': 'Sắt kim loại bám vào catot',
        'anode': 'Khí O₂ thoát ra ở anot',
        'cathodeEquation': 'Fe²⁺ + 2e⁻ → Fe',
        'anodeEquation': '2H₂O → O₂↑ + 4H⁺ + 4e⁻',
        'overallEquation': '2FeSO₄ + 2H₂O → 2Fe + 2H₂SO₄ + O₂↑',
        'explanation': 'Sắt bám vào catot, oxi thoát ra ở anot',
        'cathodeColor': Color(0xFFB0BEC5),
        'anodeColor': Color(0xFFFFCDD2),
        'hasCathodeBubbles': false,
        'hasAnodeBubbles': true,
        'hasDeposit': true,
      },
      'NiSO4': {
        'cathode': 'Niken kim loại bám vào catot',
        'anode': 'Khí O₂ thoát ra ở anot',
        'cathodeEquation': 'Ni²⁺ + 2e⁻ → Ni',
        'anodeEquation': '2H₂O → O₂↑ + 4H⁺ + 4e⁻',
        'overallEquation': '2NiSO₄ + 2H₂O → 2Ni + 2H₂SO₄ + O₂↑',
        'explanation': 'Niken bám vào catot (mạ niken), oxi thoát ra ở anot',
        'cathodeColor': Color(0xFFA5D6A7),
        'anodeColor': Color(0xFFFFCDD2),
        'hasCathodeBubbles': false,
        'hasAnodeBubbles': true,
        'hasDeposit': true,
      },
      'Na2SO4': {
        'cathode': 'Khí H₂ thoát ra ở catot',
        'anode': 'Khí O₂ thoát ra ở anot',
        'cathodeEquation': '2H₂O + 2e⁻ → H₂↑ + 2OH⁻',
        'anodeEquation': '2H₂O → O₂↑ + 4H⁺ + 4e⁻',
        'overallEquation': '2H₂O → 2H₂↑ + O₂↑',
        'explanation': 'Điện phân dung dịch Na₂SO₄ tạo H₂ và O₂',
        'cathodeColor': Color(0xFF90CAF9),
        'anodeColor': Color(0xFFFFCDD2),
        'hasCathodeBubbles': true,
        'hasAnodeBubbles': true,
        'hasDeposit': false,
      },
    };

    return reactions[solution] ?? {
      'cathode': 'Không có hiện tượng',
      'anode': 'Không có hiện tượng',
      'cathodeEquation': 'Không phản ứng',
      'anodeEquation': 'Không phản ứng',
      'overallEquation': 'Không phản ứng',
      'explanation': 'Dung dịch này không thể điện phân',
      'cathodeColor': Colors.grey,
      'anodeColor': Colors.grey,
      'hasCathodeBubbles': false,
      'hasAnodeBubbles': false,
      'hasDeposit': false,
    };
  }

  void _performElectrolysis() async {
    if (_selectedSolution == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng chọn dung dịch để điện phân'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isElectrolyzing = true;
      _showResult = false;
    });

    _electronController.forward(from: 0);

    await Future.delayed(const Duration(milliseconds: 2000));

    final result = _getElectrolysisResult(_selectedSolution!);

    setState(() {
      _result = result;
      _showResult = true;
      _isElectrolyzing = false;
    });

    _electronController.reset();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final scaleX = width / 440;

    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.amber.shade700,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Điện Phân Dung Dịch',
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
                    '1. Chọn dung dịch cần điện phân\n'
                    '2. Nhấn "Bắt đầu điện phân"\n'
                    '3. Quan sát hiện tượng ở 2 điện cực\n'
                    '4. Xem phương trình và giải thích',
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
                  colors: [Colors.amber.shade700, Colors.amber.shade500],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16 * scaleX),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.shade700.withOpacity(0.3),
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
                    child: Icon(Icons.electric_bolt, color: Colors.white, size: 32 * scaleX),
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
                          'Điện phân dung dịch và quan sát sản phẩm',
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

            // Solution selection
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: Row(
                children: [
                  Icon(Icons.science, color: Colors.amber.shade700, size: 20 * scaleX),
                  SizedBox(width: 8 * scaleX),
                  Text(
                    'Chọn dung dịch điện phân:',
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

            // Solutions grid
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
                itemCount: _solutions.length,
                itemBuilder: (context, index) {
                  final solution = _solutions[index];
                  final isSelected = _selectedSolution == solution['id'];
                  return GestureDetector(
                    onTap: () => setState(() {
                      _selectedSolution = solution['id'];
                      _showResult = false;
                    }),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      padding: EdgeInsets.all(8 * scaleX),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12 * scaleX),
                        border: Border.all(
                          color: isSelected ? Colors.amber.shade700 : Colors.grey.shade300,
                          width: isSelected ? 3 : 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isSelected 
                                ? Colors.amber.shade700.withOpacity(0.3)
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
                              color: solution['color'],
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade300, width: 2),
                            ),
                            child: Icon(
                              solution['icon'],
                              color: Colors.amber.shade700,
                              size: 20 * scaleX,
                            ),
                          ),
                          SizedBox(height: 6 * scaleX),
                          Text(
                            solution['formula'],
                            style: TextStyle(
                              fontSize: 11 * scaleX,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 2 * scaleX),
                          Text(
                            solution['name'],
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

            // Electrolysis cell visualization
            _buildElectrolysisCell(scaleX),

            SizedBox(height: 24 * scaleX),

            // Start button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: SizedBox(
                width: double.infinity,
                height: 56 * scaleX,
                child: ElevatedButton(
                  onPressed: _isElectrolyzing ? null : _performElectrolysis,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16 * scaleX),
                    ),
                    elevation: 4,
                  ),
                  child: _isElectrolyzing
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
                              'Đang điện phân...',
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
                            Icon(Icons.electric_bolt, color: Colors.white, size: 24 * scaleX),
                            SizedBox(width: 8 * scaleX),
                            Text(
                              'Bắt đầu điện phân',
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

  Widget _buildElectrolysisCell(double scale) {
    Color solutionColor = Colors.grey.shade100;
    
    if (_selectedSolution != null) {
      final solution = _solutions.firstWhere((s) => s['id'] == _selectedSolution);
      solutionColor = solution['color'];
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
              Icon(Icons.electric_bolt, color: Colors.amber.shade700, size: 20 * scale),
              SizedBox(width: 8 * scale),
              Text(
                'Bình điện phân',
                style: TextStyle(
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 20 * scale),
          
          // Electrolysis setup
          Stack(
            alignment: Alignment.center,
            children: [
              // Container (beaker)
              Container(
                width: 200 * scale,
                height: 180 * scale,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20 * scale),
                    bottomRight: Radius.circular(20 * scale),
                  ),
                  border: Border.all(color: Colors.grey.shade400, width: 3),
                ),
              ),
              
              // Solution inside
              Positioned(
                bottom: 3,
                child: Container(
                  width: 194 * scale,
                  height: 150 * scale,
                  decoration: BoxDecoration(
                    color: solutionColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(17 * scale),
                      bottomRight: Radius.circular(17 * scale),
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Cathode bubbles (left)
                      if (_isElectrolyzing && _result != null && _result!['hasCathodeBubbles'])
                        ...List.generate(6, (index) {
                          return AnimatedBuilder(
                            animation: _bubbleController,
                            builder: (context, child) {
                              final offset = (index * 0.15 + _bubbleController.value) % 1.0;
                              return Positioned(
                                left: (30 + index * 8) * scale,
                                bottom: offset * 120 * scale,
                                child: Container(
                                  width: 8 * scale,
                                  height: 8 * scale,
                                  decoration: BoxDecoration(
                                    color: _result!['cathodeColor'].withOpacity(0.7),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      
                      // Anode bubbles (right)
                      if (_isElectrolyzing && _result != null && _result!['hasAnodeBubbles'])
                        ...List.generate(6, (index) {
                          return AnimatedBuilder(
                            animation: _bubbleController,
                            builder: (context, child) {
                              final offset = (index * 0.15 + _bubbleController.value) % 1.0;
                              return Positioned(
                                right: (30 + index * 8) * scale,
                                bottom: offset * 120 * scale,
                                child: Container(
                                  width: 8 * scale,
                                  height: 8 * scale,
                                  decoration: BoxDecoration(
                                    color: _result!['anodeColor'].withOpacity(0.7),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      
                      // Cathode deposit (left)
                      if (_showResult && _result != null && _result!['hasDeposit'])
                        Positioned(
                          left: 20 * scale,
                          bottom: 10 * scale,
                          child: Container(
                            width: 30 * scale,
                            height: 100 * scale,
                            decoration: BoxDecoration(
                              color: _result!['cathodeColor'],
                              borderRadius: BorderRadius.circular(5 * scale),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              
              // Electrodes
              Positioned(
                bottom: 10 * scale,
                left: 40 * scale,
                child: Column(
                  children: [
                    // Wire
                    Container(
                      width: 3 * scale,
                      height: 40 * scale,
                      color: Colors.grey.shade700,
                    ),
                    // Cathode (-)
                    Container(
                      width: 30 * scale,
                      height: 120 * scale,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade600,
                        borderRadius: BorderRadius.circular(5 * scale),
                      ),
                      child: Center(
                        child: Text(
                          '-',
                          style: TextStyle(
                            fontSize: 24 * scale,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              Positioned(
                bottom: 10 * scale,
                right: 40 * scale,
                child: Column(
                  children: [
                    // Wire
                    Container(
                      width: 3 * scale,
                      height: 40 * scale,
                      color: Colors.red.shade700,
                    ),
                    // Anode (+)
                    Container(
                      width: 30 * scale,
                      height: 120 * scale,
                      decoration: BoxDecoration(
                        color: Colors.red.shade600,
                        borderRadius: BorderRadius.circular(5 * scale),
                      ),
                      child: Center(
                        child: Text(
                          '+',
                          style: TextStyle(
                            fontSize: 24 * scale,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Electron flow animation
              if (_isElectrolyzing)
                ...List.generate(4, (index) {
                  return AnimatedBuilder(
                    animation: _electronController,
                    builder: (context, child) {
                      final progress = (_electronController.value + index * 0.25) % 1.0;
                      return Positioned(
                        top: 20 * scale + progress * 60 * scale,
                        left: 40 * scale + 15 * scale,
                        child: Container(
                          width: 6 * scale,
                          height: 6 * scale,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(1.0 - progress),
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    },
                  );
                }),
              
              // Battery/Power source
              Positioned(
                top: -20 * scale,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 8 * scale),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade700,
                    borderRadius: BorderRadius.circular(8 * scale),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.battery_charging_full, color: Colors.white, size: 20 * scale),
                      SizedBox(width: 6 * scale),
                      Text(
                        'Nguồn điện',
                        style: TextStyle(
                          fontSize: 12 * scale,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Labels
              if (_selectedSolution != null && !_isElectrolyzing)
                Positioned(
                  bottom: 60 * scale,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8 * scale),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Text(
                      _solutions.firstWhere((s) => s['id'] == _selectedSolution)['formula'],
                      style: TextStyle(
                        fontSize: 14 * scale,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          
          SizedBox(height: 16 * scale),
          
          // Electrode labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8 * scale),
                ),
                child: Row(
                  children: [
                    Icon(Icons.remove, color: Colors.grey.shade700, size: 16 * scale),
                    SizedBox(width: 4 * scale),
                    Text(
                      'Catot (-)',
                      style: TextStyle(
                        fontSize: 12 * scale,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8 * scale),
                ),
                child: Row(
                  children: [
                    Icon(Icons.add, color: Colors.red.shade700, size: 16 * scale),
                    SizedBox(width: 4 * scale),
                    Text(
                      'Anot (+)',
                      style: TextStyle(
                        fontSize: 12 * scale,
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard(double scale) {
    final cathode = _result!['cathode'] as String;
    final anode = _result!['anode'] as String;
    final cathodeEquation = _result!['cathodeEquation'] as String;
    final anodeEquation = _result!['anodeEquation'] as String;
    final overallEquation = _result!['overallEquation'] as String;
    final explanation = _result!['explanation'] as String;

    return Container(
      margin: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.shade700.withOpacity(0.2),
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
              color: Colors.amber.shade50,
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
                  child: Icon(Icons.electric_bolt, color: Colors.amber.shade700, size: 28 * scale),
                ),
                SizedBox(width: 12 * scale),
                Expanded(
                  child: Text(
                    'Kết quả điện phân',
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
                // Cathode
                _buildResultSection(
                  '⚡ Catot (-)',
                  cathode,
                  scale,
                  Colors.grey.shade700,
                ),
                
                SizedBox(height: 12 * scale),
                
                _buildEquationSection(
                  cathodeEquation,
                  scale,
                ),
                
                SizedBox(height: 16 * scale),
                
                // Anode
                _buildResultSection(
                  '⚡ Anot (+)',
                  anode,
                  scale,
                  Colors.red.shade700,
                ),
                
                SizedBox(height: 12 * scale),
                
                _buildEquationSection(
                  anodeEquation,
                  scale,
                ),
                
                SizedBox(height: 16 * scale),
                
                // Overall equation
                Text(
                  '⚗️ Phương trình tổng quát',
                  style: TextStyle(
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber.shade700,
                  ),
                ),
                SizedBox(height: 8 * scale),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14 * scale),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.amber.shade50, Colors.amber.shade100],
                    ),
                    borderRadius: BorderRadius.circular(10 * scale),
                    border: Border.all(color: Colors.amber.shade700, width: 2),
                  ),
                  child: Text(
                    overallEquation,
                    style: TextStyle(
                      fontSize: 13 * scale,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                SizedBox(height: 16 * scale),
                
                // Explanation
                _buildResultSection(
                  '💡 Giải thích',
                  explanation,
                  scale,
                  Colors.amber.shade700,
                ),
                
                SizedBox(height: 20 * scale),
                
                // Conclusion
                Container(
                  padding: EdgeInsets.all(16 * scale),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.amber.shade700.withOpacity(0.1), Colors.amber.shade700.withOpacity(0.05)],
                    ),
                    borderRadius: BorderRadius.circular(12 * scale),
                    border: Border.all(color: Colors.amber.shade700.withOpacity(0.3), width: 2),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.electric_bolt, color: Colors.amber.shade700, size: 24 * scale),
                      SizedBox(width: 12 * scale),
                      Expanded(
                        child: Text(
                          'Quá trình điện phân hoàn thành',
                          style: TextStyle(
                            fontSize: 14 * scale,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber.shade700,
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

  Widget _buildResultSection(String title, String content, double scale, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14 * scale,
            fontWeight: FontWeight.bold,
            color: color,
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

  Widget _buildEquationSection(String equation, double scale) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12 * scale),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8 * scale),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        equation,
        style: TextStyle(
          fontSize: 12 * scale,
          color: AppColors.textPrimary,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}
