import 'package:flutter/material.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';
import 'dart:math' as math;

class BurnChemicalScreen extends StatefulWidget {
  const BurnChemicalScreen({super.key});

  @override
  State<BurnChemicalScreen> createState() => _BurnChemicalScreenState();
}

class _BurnChemicalScreenState extends State<BurnChemicalScreen> with TickerProviderStateMixin {
  String? _selectedChemical;
  Map<String, dynamic>? _result;
  bool _showResult = false;
  bool _isBurning = false;
  late AnimationController _flameController;
  late AnimationController _smokeController;
  late Animation<double> _flameAnimation;

  @override
  void initState() {
    super.initState();
    _flameController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );
    _smokeController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
    _flameAnimation = CurvedAnimation(
      parent: _flameController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _flameController.dispose();
    _smokeController.dispose();
    super.dispose();
  }

  // Danh sách hóa chất có thể đốt
  final List<Map<String, dynamic>> _chemicals = [
    {
      'id': 'C',
      'name': 'Carbon',
      'formula': 'C',
      'color': Color(0xFF424242),
      'icon': Icons.circle,
    },
    {
      'id': 'S',
      'name': 'Lưu huỳnh',
      'formula': 'S',
      'color': Color(0xFFFFF59D),
      'icon': Icons.circle,
    },
    {
      'id': 'P',
      'name': 'Photpho',
      'formula': 'P',
      'color': Color(0xFFFFCDD2),
      'icon': Icons.circle,
    },
    {
      'id': 'Mg',
      'name': 'Magie',
      'formula': 'Mg',
      'color': Color(0xFFE0E0E0),
      'icon': Icons.circle,
    },
    {
      'id': 'CH4',
      'name': 'Metan',
      'formula': 'CH₄',
      'color': Color(0xFFE3F2FD),
      'icon': Icons.cloud,
    },
    {
      'id': 'C2H5OH',
      'name': 'Etanol',
      'formula': 'C₂H₅OH',
      'color': Color(0xFFC8E6C9),
      'icon': Icons.water_drop,
    },
    {
      'id': 'H2',
      'name': 'Hiđro',
      'formula': 'H₂',
      'color': Color(0xFFE1F5FE),
      'icon': Icons.cloud,
    },
    {
      'id': 'Fe',
      'name': 'Sắt',
      'formula': 'Fe',
      'color': Color(0xFFB0BEC5),
      'icon': Icons.circle,
    },
    {
      'id': 'Al',
      'name': 'Nhôm',
      'formula': 'Al',
      'color': Color(0xFFECEFF1),
      'icon': Icons.circle,
    },
    {
      'id': 'Zn',
      'name': 'Kẽm',
      'formula': 'Zn',
      'color': Color(0xFFCFD8DC),
      'icon': Icons.circle,
    },
    {
      'id': 'Cu',
      'name': 'Đồng',
      'formula': 'Cu',
      'color': Color(0xFFFF6F00),
      'icon': Icons.circle,
    },
    {
      'id': 'Na',
      'name': 'Natri',
      'formula': 'Na',
      'color': Color(0xFFFFF9C4),
      'icon': Icons.circle,
    },
    {
      'id': 'C2H2',
      'name': 'Axetilen',
      'formula': 'C₂H₂',
      'color': Color(0xFFE1F5FE),
      'icon': Icons.cloud,
    },
    {
      'id': 'C3H8',
      'name': 'Propan',
      'formula': 'C₃H₈',
      'color': Color(0xFFE8F5E9),
      'icon': Icons.cloud,
    },
    {
      'id': 'C6H12O6',
      'name': 'Glucozơ',
      'formula': 'C₆H₁₂O₆',
      'color': Color(0xFFFFF3E0),
      'icon': Icons.circle,
    },
    {
      'id': 'CH3COOH',
      'name': 'Axit axetic',
      'formula': 'CH₃COOH',
      'color': Color(0xFFF5F5F5),
      'icon': Icons.water_drop,
    },
  ];

  // Phản ứng đốt cháy chi tiết
  Map<String, dynamic> _getBurnResult(String chemical) {
    final reactions = {
      'C': {
        'phenomenon': 'Cháy sáng, tỏa nhiệt mạnh, không có khói',
        'equation': 'C + O₂ → CO₂',
        'flameColor': Color(0xFFFF6F00),
        'explanation': 'Carbon cháy trong oxi tạo khí CO₂, phản ứng tỏa nhiệt mạnh',
        'flameIntensity': 0.9,
        'hasSmoke': false,
      },
      'S': {
        'phenomenon': 'Cháy với ngọn lửa xanh lam, có mùi hắc đặc trưng',
        'equation': 'S + O₂ → SO₂',
        'flameColor': Color(0xFF2196F3),
        'explanation': 'Lưu huỳnh cháy tạo khí SO₂ có mùi hắc, ngọn lửa màu xanh lam',
        'flameIntensity': 0.8,
        'hasSmoke': true,
      },
      'P': {
        'phenomenon': 'Cháy rất sáng, tạo khói trắng dày đặc',
        'equation': '4P + 5O₂ → 2P₂O₅',
        'flameColor': Color(0xFFFFFFFF),
        'explanation': 'Photpho cháy rất mạnh, tạo khói trắng P₂O₅',
        'flameIntensity': 1.0,
        'hasSmoke': true,
      },
      'Mg': {
        'phenomenon': 'Cháy với ánh sáng trắng chói, rất sáng',
        'equation': '2Mg + O₂ → 2MgO',
        'flameColor': Color(0xFFFFFFFF),
        'explanation': 'Magie cháy với ánh sáng trắng chói, tạo MgO màu trắng',
        'flameIntensity': 1.0,
        'hasSmoke': true,
      },
      'CH4': {
        'phenomenon': 'Cháy với ngọn lửa xanh nhạt, tỏa nhiệt',
        'equation': 'CH₄ + 2O₂ → CO₂ + 2H₂O',
        'flameColor': Color(0xFF64B5F6),
        'explanation': 'Metan cháy hoàn toàn tạo CO₂ và H₂O, ngọn lửa xanh',
        'flameIntensity': 0.7,
        'hasSmoke': false,
      },
      'C2H5OH': {
        'phenomenon': 'Cháy với ngọn lửa xanh nhạt, không khói',
        'equation': 'C₂H₅OH + 3O₂ → 2CO₂ + 3H₂O',
        'flameColor': Color(0xFF42A5F5),
        'explanation': 'Etanol cháy hoàn toàn, ngọn lửa xanh nhạt, không khói',
        'flameIntensity': 0.75,
        'hasSmoke': false,
      },
      'H2': {
        'phenomenon': 'Cháy với ngọn lửa xanh nhạt, nổ nhẹ',
        'equation': '2H₂ + O₂ → 2H₂O',
        'flameColor': Color(0xFF90CAF9),
        'explanation': 'Hiđro cháy tạo nước, ngọn lửa xanh nhạt, có thể nổ',
        'flameIntensity': 0.8,
        'hasSmoke': false,
      },
      'Fe': {
        'phenomenon': 'Cháy sáng, tạo tia lửa, có khói đen',
        'equation': '3Fe + 2O₂ → Fe₃O₄',
        'flameColor': Color(0xFFFF9800),
        'explanation': 'Sắt cháy trong oxi tạo Fe₃O₄, có tia lửa và khói',
        'flameIntensity': 0.85,
        'hasSmoke': true,
      },
      'Al': {
        'phenomenon': 'Cháy rất sáng với ánh sáng trắng, tỏa nhiệt mạnh',
        'equation': '4Al + 3O₂ → 2Al₂O₃',
        'flameColor': Color(0xFFFFFFFF),
        'explanation': 'Nhôm cháy với ánh sáng trắng chói, tạo Al₂O₃',
        'flameIntensity': 0.95,
        'hasSmoke': true,
      },
      'Zn': {
        'phenomenon': 'Cháy với ngọn lửa xanh lục nhạt, có khói trắng',
        'equation': '2Zn + O₂ → 2ZnO',
        'flameColor': Color(0xFF81C784),
        'explanation': 'Kẽm cháy tạo ZnO màu trắng, ngọn lửa xanh lục',
        'flameIntensity': 0.8,
        'hasSmoke': true,
      },
      'Cu': {
        'phenomenon': 'Cháy với ngọn lửa xanh lục, tạo chất rắn màu đen',
        'equation': '2Cu + O₂ → 2CuO',
        'flameColor': Color(0xFF66BB6A),
        'explanation': 'Đồng cháy tạo CuO màu đen, ngọn lửa xanh lục',
        'flameIntensity': 0.7,
        'hasSmoke': false,
      },
      'Na': {
        'phenomenon': 'Cháy rất mạnh với ngọn lửa vàng chói',
        'equation': '4Na + O₂ → 2Na₂O',
        'flameColor': Color(0xFFFFEB3B),
        'explanation': 'Natri cháy rất mạnh, ngọn lửa vàng đặc trưng',
        'flameIntensity': 0.95,
        'hasSmoke': true,
      },
      'C2H2': {
        'phenomenon': 'Cháy với ngọn lửa sáng, nhiệt độ rất cao',
        'equation': '2C₂H₂ + 5O₂ → 4CO₂ + 2H₂O',
        'flameColor': Color(0xFFFFFFFF),
        'explanation': 'Axetilen cháy với nhiệt độ rất cao (3000°C), dùng hàn cắt kim loại',
        'flameIntensity': 1.0,
        'hasSmoke': false,
      },
      'C3H8': {
        'phenomenon': 'Cháy với ngọn lửa xanh, tỏa nhiệt',
        'equation': 'C₃H₈ + 5O₂ → 3CO₂ + 4H₂O',
        'flameColor': Color(0xFF42A5F5),
        'explanation': 'Propan cháy hoàn toàn, ngọn lửa xanh, nhiên liệu phổ biến',
        'flameIntensity': 0.8,
        'hasSmoke': false,
      },
      'C6H12O6': {
        'phenomenon': 'Cháy chậm, có khói đen và mùi caramel',
        'equation': 'C₆H₁₂O₆ + 6O₂ → 6CO₂ + 6H₂O',
        'flameColor': Color(0xFFFF9800),
        'explanation': 'Glucozơ cháy không hoàn toàn, tạo khói và mùi đặc trưng',
        'flameIntensity': 0.6,
        'hasSmoke': true,
      },
      'CH3COOH': {
        'phenomenon': 'Cháy với ngọn lửa xanh nhạt, có mùi giấm',
        'equation': 'CH₃COOH + 2O₂ → 2CO₂ + 2H₂O',
        'flameColor': Color(0xFF64B5F6),
        'explanation': 'Axit axetic cháy tạo CO₂ và H₂O, có mùi giấm',
        'flameIntensity': 0.65,
        'hasSmoke': false,
      },
    };

    return reactions[chemical] ?? {
      'phenomenon': 'Không thể đốt cháy',
      'equation': 'Không phản ứng',
      'flameColor': Colors.grey,
      'explanation': 'Chất này không thể đốt cháy trong điều kiện thường',
      'flameIntensity': 0.0,
      'hasSmoke': false,
    };
  }

  void _performBurn() async {
    if (_selectedChemical == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng chọn hóa chất để đốt'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isBurning = true;
      _showResult = false;
    });

    _flameController.forward(from: 0);

    await Future.delayed(const Duration(milliseconds: 2500));

    final result = _getBurnResult(_selectedChemical!);

    setState(() {
      _result = result;
      _showResult = true;
      _isBurning = false;
    });

    _flameController.reset();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final scaleX = width / 440;

    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Đốt Hóa Chất',
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
                    '1. Chọn hóa chất cần đốt\n'
                    '2. Nhấn "Đốt hóa chất"\n'
                    '3. Quan sát ngọn lửa và hiện tượng\n'
                    '4. Xem kết quả phản ứng',
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
                  colors: [Color(0xFFFF6F00), Color(0xFFFF9800)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16 * scaleX),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFFF6F00).withOpacity(0.3),
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
                    child: Icon(Icons.local_fire_department, color: Colors.white, size: 32 * scaleX),
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
                          'Đốt cháy hóa chất và quan sát phản ứng',
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

            // Chemical selection
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: Row(
                children: [
                  Icon(Icons.science, color: Colors.orange, size: 20 * scaleX),
                  SizedBox(width: 8 * scaleX),
                  Text(
                    'Chọn hóa chất cần đốt:',
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

            // Chemicals grid
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
                  final isSelected = _selectedChemical == chemical['id'];
                  return GestureDetector(
                    onTap: () => setState(() {
                      _selectedChemical = chemical['id'];
                      _showResult = false;
                    }),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      padding: EdgeInsets.all(8 * scaleX),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12 * scaleX),
                        border: Border.all(
                          color: isSelected ? Colors.orange : Colors.grey.shade300,
                          width: isSelected ? 3 : 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isSelected 
                                ? Colors.orange.withOpacity(0.3)
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
                              color: Colors.orange,
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

            // Burner visualization
            _buildBurner(scaleX),

            SizedBox(height: 24 * scaleX),

            // Burn button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: SizedBox(
                width: double.infinity,
                height: 56 * scaleX,
                child: ElevatedButton(
                  onPressed: _isBurning ? null : _performBurn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16 * scaleX),
                    ),
                    elevation: 4,
                  ),
                  child: _isBurning
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
                              'Đang đốt...',
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
                            Icon(Icons.local_fire_department, color: Colors.white, size: 24 * scaleX),
                            SizedBox(width: 8 * scaleX),
                            Text(
                              'Đốt hóa chất',
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

  Widget _buildBurner(double scale) {
    Color flameColor = Colors.orange;
    double flameIntensity = 0.5;
    
    if (_isBurning && _result != null) {
      flameColor = _result!['flameColor'];
      flameIntensity = _result!['flameIntensity'];
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
              Icon(Icons.local_fire_department, color: Colors.orange, size: 20 * scale),
              SizedBox(width: 8 * scale),
              Text(
                'Đèn cồn',
                style: TextStyle(
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 20 * scale),
          
          // Burner setup
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Smoke particles
              if (_isBurning && _result != null && _result!['hasSmoke'])
                ...List.generate(6, (index) {
                  return AnimatedBuilder(
                    animation: _smokeController,
                    builder: (context, child) {
                      final offset = (index * 0.15 + _smokeController.value) % 1.0;
                      final opacity = 1.0 - offset;
                      return Positioned(
                        left: (60 + index * 8 - offset * 20) * scale,
                        bottom: (180 + offset * 100) * scale,
                        child: Container(
                          width: (10 + offset * 15) * scale,
                          height: (10 + offset * 15) * scale,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(opacity * 0.5),
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    },
                  );
                }),
              
              Column(
                children: [
                  // Flame
                  SizedBox(
                    height: 120 * scale,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        if (_isBurning)
                          ...List.generate(3, (index) {
                            return AnimatedBuilder(
                              animation: _flameAnimation,
                              builder: (context, child) {
                                final flicker = math.sin(_flameAnimation.value * math.pi * 4 + index) * 0.2 + 0.8;
                                final height = (60 + index * 15) * scale * flameIntensity * flicker;
                                return Positioned(
                                  bottom: 0,
                                  child: Container(
                                    width: (40 - index * 8) * scale,
                                    height: height,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          flameColor,
                                          flameColor.withOpacity(0.7),
                                          flameColor.withOpacity(0.3),
                                          Colors.transparent,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(50 * scale),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                        
                        // Chemical being burned
                        if (_selectedChemical != null && !_isBurning)
                          Positioned(
                            bottom: 40 * scale,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 6 * scale),
                              decoration: BoxDecoration(
                                color: _chemicals.firstWhere((c) => c['id'] == _selectedChemical)['color'],
                                borderRadius: BorderRadius.circular(8 * scale),
                                border: Border.all(color: Colors.grey.shade400, width: 2),
                              ),
                              child: Text(
                                _chemicals.firstWhere((c) => c['id'] == _selectedChemical)['formula'],
                                style: TextStyle(
                                  fontSize: 16 * scale,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  
                  // Burner base
                  Container(
                    width: 80 * scale,
                    height: 60 * scale,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.grey.shade400,
                          Colors.grey.shade600,
                        ],
                      ),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10 * scale),
                      ),
                    ),
                  ),
                  
                  // Burner stand
                  Container(
                    width: 100 * scale,
                    height: 10 * scale,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(5 * scale),
                    ),
                  ),
                ],
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
    final flameIntensity = _result!['flameIntensity'] as double;

    Color borderColor = Colors.orange;
    Color bgColor = Colors.orange.shade50;
    IconData icon = Icons.local_fire_department;

    if (flameIntensity == 0.0) {
      borderColor = Colors.grey;
      bgColor = Colors.grey.shade100;
      icon = Icons.info_outline;
    } else if (flameIntensity >= 0.9) {
      borderColor = Colors.red;
      bgColor = Colors.red.shade50;
      icon = Icons.whatshot;
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
                    'Kết quả đốt cháy',
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
                  '🔥 Hiện tượng quan sát',
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
                
                // Intensity indicator
                if (flameIntensity > 0.0) ...[
                  Text(
                    'Cường độ cháy',
                    style: TextStyle(
                      fontSize: 14 * scale,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  SizedBox(height: 8 * scale),
                  Container(
                    height: 12 * scale,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(6 * scale),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: flameIntensity,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.orange, Colors.red],
                          ),
                          borderRadius: BorderRadius.circular(6 * scale),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20 * scale),
                ],
                
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
                      Icon(Icons.local_fire_department, color: borderColor, size: 24 * scale),
                      SizedBox(width: 12 * scale),
                      Expanded(
                        child: Text(
                          flameIntensity == 0.0 
                              ? 'Không thể đốt cháy'
                              : 'Phản ứng đốt cháy hoàn thành',
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
            color: Colors.orange,
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
