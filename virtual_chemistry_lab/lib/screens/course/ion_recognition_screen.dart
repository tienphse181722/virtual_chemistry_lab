import 'package:flutter/material.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';

class IonRecognitionScreen extends StatefulWidget {
  const IonRecognitionScreen({super.key});

  @override
  State<IonRecognitionScreen> createState() => _IonRecognitionScreenState();
}

class _IonRecognitionScreenState extends State<IonRecognitionScreen> with TickerProviderStateMixin {
  String? _selectedSample;
  String? _selectedReagent;
  Map<String, dynamic>? _result;
  bool _showResult = false;
  bool _isReacting = false;
  late AnimationController _reactionController;
  late AnimationController _bubbleController;
  late Animation<double> _reactionAnimation;

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

  // Mẫu cần nhận biết (chứa các ion khác nhau)
  final List<Map<String, dynamic>> _samples = [
    {
      'id': 'Na+',
      'name': 'Mẫu 1',
      'ion': 'Na⁺',
      'description': 'Dung dịch không màu',
      'color': Color(0xFFE3F2FD),
      'actualIon': 'Natri (Na⁺)',
    },
    {
      'id': 'Cu2+',
      'name': 'Mẫu 2',
      'ion': 'Cu²⁺',
      'description': 'Dung dịch xanh lam',
      'color': Color(0xFF81D4FA),
      'actualIon': 'Đồng (Cu²⁺)',
    },
    {
      'id': 'Fe3+',
      'name': 'Mẫu 3',
      'ion': 'Fe³⁺',
      'description': 'Dung dịch vàng nâu',
      'color': Color(0xFFFFCC80),
      'actualIon': 'Sắt (III) (Fe³⁺)',
    },
    {
      'id': 'Fe2+',
      'name': 'Mẫu 4',
      'ion': 'Fe²⁺',
      'description': 'Dung dịch xanh nhạt',
      'color': Color(0xFFB2DFDB),
      'actualIon': 'Sắt (II) (Fe²⁺)',
    },
    {
      'id': 'Al3+',
      'name': 'Mẫu 5',
      'ion': 'Al³⁺',
      'description': 'Dung dịch không màu',
      'color': Color(0xFFF5F5F5),
      'actualIon': 'Nhôm (Al³⁺)',
    },
    {
      'id': 'Ag+',
      'name': 'Mẫu 6',
      'ion': 'Ag⁺',
      'description': 'Dung dịch không màu',
      'color': Color(0xFFECEFF1),
      'actualIon': 'Bạc (Ag⁺)',
    },
    {
      'id': 'Ba2+',
      'name': 'Mẫu 7',
      'ion': 'Ba²⁺',
      'description': 'Dung dịch không màu',
      'color': Color(0xFFFFF9C4),
      'actualIon': 'Bari (Ba²⁺)',
    },
    {
      'id': 'Pb2+',
      'name': 'Mẫu 8',
      'ion': 'Pb²⁺',
      'description': 'Dung dịch không màu',
      'color': Color(0xFFE0E0E0),
      'actualIon': 'Chì (Pb²⁺)',
    },
  ];

  // Thuốc thử phong phú hơn
  final List<Map<String, dynamic>> _reagents = [
    {
      'id': 'NaOH',
      'name': 'NaOH',
      'fullName': 'Natri hydroxide',
      'color': Color(0xFFE1F5FE),
      'icon': Icons.water_drop,
    },
    {
      'id': 'NH3',
      'name': 'NH₃',
      'fullName': 'Amoniac',
      'color': Color(0xFFC8E6C9),
      'icon': Icons.cloud,
    },
    {
      'id': 'HCl',
      'name': 'HCl',
      'fullName': 'Axit clohidric',
      'color': Color(0xFFFFCDD2),
      'icon': Icons.water_drop,
    },
    {
      'id': 'H2SO4',
      'name': 'H₂SO₄',
      'fullName': 'Axit sunfuric',
      'color': Color(0xFFFFF9C4),
      'icon': Icons.water_drop,
    },
    {
      'id': 'AgNO3',
      'name': 'AgNO₃',
      'fullName': 'Bạc nitrat',
      'color': Color(0xFFE0E0E0),
      'icon': Icons.water_drop,
    },
    {
      'id': 'BaCl2',
      'name': 'BaCl₂',
      'fullName': 'Bari clorua',
      'color': Color(0xFFFFF3E0),
      'icon': Icons.water_drop,
    },
    {
      'id': 'K4[Fe(CN)6]',
      'name': 'K₄[Fe(CN)₆]',
      'fullName': 'Kali hexaxianoferat (II)',
      'color': Color(0xFFFFF59D),
      'icon': Icons.water_drop,
    },
    {
      'id': 'KSCN',
      'name': 'KSCN',
      'fullName': 'Kali thioxianat',
      'color': Color(0xFFFFCCBC),
      'icon': Icons.water_drop,
    },
  ];

  // Phản ứng chi tiết với hiệu ứng
  Map<String, dynamic> _getReactionResult(String sample, String reagent) {
    final reactions = {
      // Phản ứng với NaOH
      'Cu2+_NaOH': {
        'phenomenon': 'Xuất hiện kết tủa xanh lam',
        'equation': 'Cu²⁺ + 2OH⁻ → Cu(OH)₂↓',
        'precipitateColor': Color(0xFF4FC3F7),
        'explanation': 'Kết tủa xanh lam Cu(OH)₂ không tan trong kiềm dư',
        'type': 'precipitate',
        'animation': 'fall',
      },
      'Fe3+_NaOH': {
        'phenomenon': 'Xuất hiện kết tủa nâu đỏ',
        'equation': 'Fe³⁺ + 3OH⁻ → Fe(OH)₃↓',
        'precipitateColor': Color(0xFFD84315),
        'explanation': 'Kết tủa nâu đỏ Fe(OH)₃ không tan trong kiềm dư',
        'type': 'precipitate',
        'animation': 'fall',
      },
      'Fe2+_NaOH': {
        'phenomenon': 'Xuất hiện kết tủa trắng xanh, sau đó chuyển nâu đỏ ngoài không khí',
        'equation': 'Fe²⁺ + 2OH⁻ → Fe(OH)₂↓ → Fe(OH)₃↓',
        'precipitateColor': Color(0xFF80CBC4),
        'explanation': 'Fe(OH)₂ trắng xanh bị oxi hóa thành Fe(OH)₃ nâu đỏ',
        'type': 'precipitate',
        'animation': 'fall',
      },
      'Al3+_NaOH': {
        'phenomenon': 'Xuất hiện kết tủa trắng, tan trong kiềm dư',
        'equation': 'Al³⁺ + 3OH⁻ → Al(OH)₃↓\nAl(OH)₃ + OH⁻ → AlO₂⁻ + 2H₂O',
        'precipitateColor': Colors.white,
        'explanation': 'Al(OH)₃ lưỡng tính, tan trong kiềm dư tạo phức',
        'type': 'precipitate_dissolve',
        'animation': 'fall_dissolve',
      },
      'Ag+_NaOH': {
        'phenomenon': 'Xuất hiện kết tủa nâu đen',
        'equation': '2Ag⁺ + 2OH⁻ → Ag₂O↓ + H₂O',
        'precipitateColor': Color(0xFF424242),
        'explanation': 'Tạo Ag₂O màu nâu đen',
        'type': 'precipitate',
        'animation': 'fall',
      },
      'Na+_NaOH': {
        'phenomenon': 'Không có hiện tượng gì',
        'equation': 'Không phản ứng',
        'precipitateColor': Colors.transparent,
        'explanation': 'Na⁺ không tạo kết tủa với OH⁻',
        'type': 'none',
        'animation': 'none',
      },

      // Phản ứng với NH3
      'Cu2+_NH3': {
        'phenomenon': 'Kết tủa xanh lam xuất hiện, sau đó tan tạo dung dịch xanh đậm',
        'equation': 'Cu²⁺ + 2OH⁻ → Cu(OH)₂↓\nCu(OH)₂ + 4NH₃ → [Cu(NH₃)₄]²⁺ + 2OH⁻',
        'precipitateColor': Color(0xFF0D47A1),
        'explanation': 'Tạo phức đồng-amoniac màu xanh đậm đặc trưng',
        'type': 'complex',
        'animation': 'dissolve',
      },
      'Ag+_NH3': {
        'phenomenon': 'Kết tủa nâu xuất hiện, sau đó tan tạo dung dịch không màu',
        'equation': 'Ag⁺ + NH₃ + H₂O → AgOH↓ + NH₄⁺\nAgOH + 2NH₃ → [Ag(NH₃)₂]⁺ + OH⁻',
        'precipitateColor': Colors.transparent,
        'explanation': 'Tạo phức bạc-amoniac không màu',
        'type': 'complex',
        'animation': 'dissolve',
      },
      'Fe3+_NH3': {
        'phenomenon': 'Xuất hiện kết tủa nâu đỏ',
        'equation': 'Fe³⁺ + 3NH₃ + 3H₂O → Fe(OH)₃↓ + 3NH₄⁺',
        'precipitateColor': Color(0xFFD84315),
        'explanation': 'Tạo kết tủa Fe(OH)₃ không tan trong NH₃ dư',
        'type': 'precipitate',
        'animation': 'fall',
      },

      // Phản ứng với HCl
      'Ag+_HCl': {
        'phenomenon': 'Xuất hiện kết tủa trắng',
        'equation': 'Ag⁺ + Cl⁻ → AgCl↓',
        'precipitateColor': Colors.white,
        'explanation': 'Kết tủa trắng AgCl không tan trong axit',
        'type': 'precipitate',
        'animation': 'fall',
      },
      'Pb2+_HCl': {
        'phenomenon': 'Xuất hiện kết tủa trắng',
        'equation': 'Pb²⁺ + 2Cl⁻ → PbCl₂↓',
        'precipitateColor': Colors.white,
        'explanation': 'Kết tủa trắng PbCl₂, tan trong nước nóng',
        'type': 'precipitate',
        'animation': 'fall',
      },

      // Phản ứng với H2SO4
      'Ba2+_H2SO4': {
        'phenomenon': 'Xuất hiện kết tủa trắng',
        'equation': 'Ba²⁺ + SO₄²⁻ → BaSO₄↓',
        'precipitateColor': Colors.white,
        'explanation': 'Kết tủa trắng BaSO₄ không tan trong axit',
        'type': 'precipitate',
        'animation': 'fall',
      },
      'Pb2+_H2SO4': {
        'phenomenon': 'Xuất hiện kết tủa trắng',
        'equation': 'Pb²⁺ + SO₄²⁻ → PbSO₄↓',
        'precipitateColor': Colors.white,
        'explanation': 'Kết tủa trắng PbSO₄ không tan',
        'type': 'precipitate',
        'animation': 'fall',
      },

      // Phản ứng với AgNO3
      'Na+_AgNO3': {
        'phenomenon': 'Không có hiện tượng gì',
        'equation': 'Không phản ứng',
        'precipitateColor': Colors.transparent,
        'explanation': 'Không tạo kết tủa',
        'type': 'none',
        'animation': 'none',
      },

      // Phản ứng với BaCl2
      'Ba2+_BaCl2': {
        'phenomenon': 'Không có hiện tượng gì',
        'equation': 'Không phản ứng',
        'precipitateColor': Colors.transparent,
        'explanation': 'Cùng ion Ba²⁺',
        'type': 'none',
        'animation': 'none',
      },

      // Phản ứng với K4[Fe(CN)6]
      'Fe3+_K4[Fe(CN)6]': {
        'phenomenon': 'Xuất hiện kết tủa xanh đậm (xanh Pru-si)',
        'equation': '4Fe³⁺ + 3[Fe(CN)₆]⁴⁻ → Fe₄[Fe(CN)₆]₃↓',
        'precipitateColor': Color(0xFF0D47A1),
        'explanation': 'Kết tủa xanh Pru-si đặc trưng của Fe³⁺',
        'type': 'precipitate',
        'animation': 'fall',
      },
      'Fe2+_K4[Fe(CN)6]': {
        'phenomenon': 'Xuất hiện kết tủa trắng xanh',
        'equation': '2Fe²⁺ + [Fe(CN)₆]⁴⁻ → Fe₂[Fe(CN)₆]↓',
        'precipitateColor': Color(0xFF80CBC4),
        'explanation': 'Kết tủa trắng xanh đặc trưng của Fe²⁺',
        'type': 'precipitate',
        'animation': 'fall',
      },

      // Phản ứng với KSCN
      'Fe3+_KSCN': {
        'phenomenon': 'Dung dịch chuyển màu đỏ máu',
        'equation': 'Fe³⁺ + SCN⁻ → [Fe(SCN)]²⁺',
        'precipitateColor': Color(0xFFD32F2F),
        'explanation': 'Tạo phức màu đỏ máu đặc trưng của Fe³⁺',
        'type': 'color_change',
        'animation': 'color',
      },
      'Fe2+_KSCN': {
        'phenomenon': 'Không có hiện tượng gì',
        'equation': 'Không phản ứng',
        'precipitateColor': Colors.transparent,
        'explanation': 'Fe²⁺ không tạo phức với SCN⁻',
        'type': 'none',
        'animation': 'none',
      },
    };

    final key = '${sample}_$reagent';
    return reactions[key] ?? {
      'phenomenon': 'Không có phản ứng đặc trưng',
      'equation': 'Không phản ứng',
      'precipitateColor': Colors.transparent,
      'explanation': 'Không xảy ra phản ứng nhận biết',
      'type': 'none',
      'animation': 'none',
    };
  }

  void _performTest() async {
    if (_selectedSample == null || _selectedReagent == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng chọn mẫu và thuốc thử'),
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

    final result = _getReactionResult(_selectedSample!, _selectedReagent!);

    setState(() {
      _result = result;
      _showResult = true;
      _isReacting = false;
    });
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
          'Nhận Biết Ion',
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
                    '1. Chọn mẫu cần nhận biết\n'
                    '2. Chọn thuốc thử phù hợp\n'
                    '3. Nhấn "Thực hiện thí nghiệm"\n'
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
            // Header card with gradient
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
                          'Nhận biết ion bằng thuốc thử đặc trưng',
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

            // Sample selection
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: Row(
                children: [
                  Icon(Icons.colorize, color: AppColors.primary, size: 20 * scaleX),
                  SizedBox(width: 8 * scaleX),
                  Text(
                    'Chọn mẫu cần phân tích:',
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

            // Samples grid
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
                itemCount: _samples.length,
                itemBuilder: (context, index) {
                  final sample = _samples[index];
                  final isSelected = _selectedSample == sample['id'];
                  return GestureDetector(
                    onTap: () => setState(() {
                      _selectedSample = sample['id'];
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
                              color: sample['color'],
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade300, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                sample['ion'],
                                style: TextStyle(
                                  fontSize: 12 * scaleX,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 6 * scaleX),
                          Text(
                            sample['name'],
                            style: TextStyle(
                              fontSize: 11 * scaleX,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 2 * scaleX),
                          Text(
                            sample['description'],
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

            // Reagent selection
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: Row(
                children: [
                  Icon(Icons.water_drop, color: AppColors.primary, size: 20 * scaleX),
                  SizedBox(width: 8 * scaleX),
                  Text(
                    'Chọn thuốc thử:',
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

            // Reagents grid
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
                itemCount: _reagents.length,
                itemBuilder: (context, index) {
                  final reagent = _reagents[index];
                  final isSelected = _selectedReagent == reagent['id'];
                  return GestureDetector(
                    onTap: () => setState(() {
                      _selectedReagent = reagent['id'];
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
                              color: reagent['color'],
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade300, width: 2),
                            ),
                            child: Icon(
                              reagent['icon'],
                              color: AppColors.primary,
                              size: 20 * scaleX,
                            ),
                          ),
                          SizedBox(height: 6 * scaleX),
                          Text(
                            reagent['name'],
                            style: TextStyle(
                              fontSize: 11 * scaleX,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 2 * scaleX),
                          Text(
                            reagent['fullName'],
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

            // Test tube visualization with animation
            _buildTestTube(scaleX),

            SizedBox(height: 24 * scaleX),

            // Test button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: SizedBox(
                width: double.infinity,
                height: 56 * scaleX,
                child: ElevatedButton(
                  onPressed: _isReacting ? null : _performTest,
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
                              'Thực hiện thí nghiệm',
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

  Widget _buildTestTube(double scale) {
    Color tubeColor = Colors.grey.shade100;
    
    if (_selectedSample != null) {
      final sample = _samples.firstWhere((s) => s['id'] == _selectedSample);
      tubeColor = sample['color'];
    }

    if (_showResult && _result != null && _result!['precipitateColor'] != Colors.transparent) {
      tubeColor = _result!['precipitateColor'];
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
                'Ống nghiệm phản ứng',
                style: TextStyle(
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 20 * scale),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Dropper icon for reagent
              if (_selectedReagent != null)
                Column(
                  children: [
                    AnimatedBuilder(
                      animation: _reactionAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _isReacting ? _reactionAnimation.value * 30 : 0),
                          child: Icon(
                            Icons.opacity,
                            size: 40 * scale,
                            color: AppColors.primary,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10 * scale),
                  ],
                ),
              
              SizedBox(width: 20 * scale),
              
              // Test tube
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: 100 * scale,
                    height: 220 * scale,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50 * scale),
                        bottomRight: Radius.circular(50 * scale),
                      ),
                      border: Border.all(color: Colors.grey.shade400, width: 3),
                    ),
                  ),
                  
                  // Liquid inside
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    width: 94 * scale,
                    height: _isReacting ? 180 * scale : 160 * scale,
                    decoration: BoxDecoration(
                      color: tubeColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(47 * scale),
                        bottomRight: Radius.circular(47 * scale),
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Precipitate particles falling
                        if (_isReacting && _result != null && _result!['type'] == 'precipitate')
                          ...List.generate(8, (index) {
                            return AnimatedBuilder(
                              animation: _reactionAnimation,
                              builder: (context, child) {
                                final delay = index * 0.1;
                                final progress = (_reactionAnimation.value - delay).clamp(0.0, 1.0);
                                return Positioned(
                                  left: (20 + index * 10) * scale,
                                  top: progress * 140 * scale,
                                  child: Container(
                                    width: 6 * scale,
                                    height: 6 * scale,
                                    decoration: BoxDecoration(
                                      color: _result!['precipitateColor'],
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
                              height: 30 * scale,
                              decoration: BoxDecoration(
                                color: _result!['precipitateColor'],
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(47 * scale),
                                  bottomRight: Radius.circular(47 * scale),
                                ),
                              ),
                            ),
                          ),
                        
                        // Bubbles for gas evolution
                        if (_isReacting && _result != null && _result!['type'] == 'gas')
                          ...List.generate(5, (index) {
                            return AnimatedBuilder(
                              animation: _bubbleController,
                              builder: (context, child) {
                                final offset = (index * 0.2 + _bubbleController.value) % 1.0;
                                return Positioned(
                                  left: (30 + index * 12) * scale,
                                  bottom: offset * 150 * scale,
                                  child: Container(
                                    width: 8 * scale,
                                    height: 8 * scale,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.6),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                        
                        // Sample label
                        if (_selectedSample != null && !_isReacting)
                          Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(8 * scale),
                              ),
                              child: Text(
                                _samples.firstWhere((s) => s['id'] == _selectedSample)['ion'],
                                style: TextStyle(
                                  fontSize: 18 * scale,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          SizedBox(height: 16 * scale),
          
          // Selected info
          if (_selectedSample != null || _selectedReagent != null)
            Container(
              padding: EdgeInsets.all(12 * scale),
              decoration: BoxDecoration(
                color: Color(0xFFF5F7FA),
                borderRadius: BorderRadius.circular(12 * scale),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_selectedSample != null) ...[
                    Icon(Icons.colorize, size: 16 * scale, color: AppColors.primary),
                    SizedBox(width: 6 * scale),
                    Text(
                      _samples.firstWhere((s) => s['id'] == _selectedSample)['actualIon'],
                      style: TextStyle(
                        fontSize: 12 * scale,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                  if (_selectedSample != null && _selectedReagent != null)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8 * scale),
                      child: Icon(Icons.add, size: 16 * scale, color: AppColors.textSecondary),
                    ),
                  if (_selectedReagent != null) ...[
                    Icon(Icons.water_drop, size: 16 * scale, color: AppColors.primary),
                    SizedBox(width: 6 * scale),
                    Text(
                      _reagents.firstWhere((r) => r['id'] == _selectedReagent)['name'],
                      style: TextStyle(
                        fontSize: 12 * scale,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ],
              ),
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
    } else if (type == 'color_change') {
      borderColor = Colors.orange;
      bgColor = Colors.orange.shade50;
      icon = Icons.palette;
    } else if (type == 'complex') {
      borderColor = Colors.purple;
      bgColor = Colors.purple.shade50;
      icon = Icons.blur_on;
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
                    'Kết quả thí nghiệm',
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
                              : 'Đã nhận biết thành công ion ${_samples.firstWhere((s) => s['id'] == _selectedSample)['ion']}',
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
