import 'package:flutter/material.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';
import 'dart:math' as math;

class ReactionKineticsScreen extends StatefulWidget {
  const ReactionKineticsScreen({super.key});

  @override
  State<ReactionKineticsScreen> createState() => _ReactionKineticsScreenState();
}

class _ReactionKineticsScreenState extends State<ReactionKineticsScreen> with TickerProviderStateMixin {
  String? _selectedReaction;
  double _temperature = 25.0;
  double _concentration = 1.0;
  String? _catalyst;
  bool _isRunning = false;
  bool _showResult = false;
  Map<String, dynamic>? _result;
  late AnimationController _reactionController;
  late AnimationController _graphController;

  @override
  void initState() {
    super.initState();
    _reactionController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _graphController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _reactionController.dispose();
    _graphController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _reactions = [
    {
      'id': 'H2O2_decomposition',
      'name': 'Phân hủy H₂O₂',
      'equation': '2H₂O₂ → 2H₂O + O₂',
      'baseRate': 0.5,
      'activationEnergy': 75,
      'color': Color(0xFF81D4FA),
    },
    {
      'id': 'N2O5_decomposition',
      'name': 'Phân hủy N₂O₅',
      'equation': '2N₂O₅ → 4NO₂ + O₂',
      'baseRate': 0.8,
      'activationEnergy': 103,
      'color': Color(0xFFFFCC80),
    },
    {
      'id': 'ester_hydrolysis',
      'name': 'Thủy phân este',
      'equation': 'CH₃COOC₂H₅ + H₂O → CH₃COOH + C₂H₅OH',
      'baseRate': 0.3,
      'activationEnergy': 85,
      'color': Color(0xFFC8E6C9),
    },
    {
      'id': 'NH3_synthesis',
      'name': 'Tổng hợp NH₃',
      'equation': 'N₂ + 3H₂ ⇌ 2NH₃',
      'baseRate': 0.6,
      'activationEnergy': 150,
      'color': Color(0xFFB2DFDB),
    },
    {
      'id': 'NO2_dimerization',
      'name': 'Dime hóa NO₂',
      'equation': '2NO₂ ⇌ N₂O₄',
      'baseRate': 0.7,
      'activationEnergy': 57,
      'color': Color(0xFFFFAB91),
    },
    {
      'id': 'sucrose_inversion',
      'name': 'Đảo đường saccarozơ',
      'equation': 'C₁₂H₂₂O₁₁ + H₂O → C₆H₁₂O₆ + C₆H₁₂O₆',
      'baseRate': 0.4,
      'activationEnergy': 108,
      'color': Color(0xFFFFF59D),
    },
    {
      'id': 'SO2Cl2_decomposition',
      'name': 'Phân hủy SO₂Cl₂',
      'equation': 'SO₂Cl₂ → SO₂ + Cl₂',
      'baseRate': 0.55,
      'activationEnergy': 210,
      'color': Color(0xFFCE93D8),
    },
    {
      'id': 'CH3CHO_decomposition',
      'name': 'Phân hủy CH₃CHO',
      'equation': 'CH₃CHO → CH₄ + CO',
      'baseRate': 0.65,
      'activationEnergy': 190,
      'color': Color(0xFFA5D6A7),
    },
    {
      'id': 'HI_decomposition',
      'name': 'Phân hủy HI',
      'equation': '2HI → H₂ + I₂',
      'baseRate': 0.45,
      'activationEnergy': 184,
      'color': Color(0xFFB39DDB),
    },
    {
      'id': 'NO_oxidation',
      'name': 'Oxi hóa NO',
      'equation': '2NO + O₂ → 2NO₂',
      'baseRate': 0.75,
      'activationEnergy': 115,
      'color': Color(0xFFEF9A9A),
    },
    {
      'id': 'CO_oxidation',
      'name': 'Oxi hóa CO',
      'equation': '2CO + O₂ → 2CO₂',
      'baseRate': 0.5,
      'activationEnergy': 125,
      'color': Color(0xFF90CAF9),
    },
    {
      'id': 'C2H4_hydrogenation',
      'name': 'Hiđro hóa C₂H₄',
      'equation': 'C₂H₄ + H₂ → C₂H₆',
      'baseRate': 0.6,
      'activationEnergy': 180,
      'color': Color(0xFFA5D6A7),
    },
    {
      'id': 'CH3Br_hydrolysis',
      'name': 'Thủy phân CH₃Br',
      'equation': 'CH₃Br + OH⁻ → CH₃OH + Br⁻',
      'baseRate': 0.35,
      'activationEnergy': 95,
      'color': Color(0xFFFFCC80),
    },
    {
      'id': 'cyclopropane_isomerization',
      'name': 'Đồng phân hóa cyclopropan',
      'equation': 'C₃H₆ (cyclo) → C₃H₆ (propen)',
      'baseRate': 0.42,
      'activationEnergy': 272,
      'color': Color(0xFFCE93D8),
    },
    {
      'id': 'H2_I2_synthesis',
      'name': 'Tổng hợp HI',
      'equation': 'H₂ + I₂ ⇌ 2HI',
      'baseRate': 0.52,
      'activationEnergy': 165,
      'color': Color(0xFFB2DFDB),
    },
  ];

  final List<Map<String, dynamic>> _catalysts = [
    {
      'id': 'none',
      'name': 'Không có',
      'factor': 1.0,
      'color': Colors.grey,
    },
    {
      'id': 'MnO2',
      'name': 'MnO₂',
      'factor': 5.0,
      'color': Color(0xFF424242),
    },
    {
      'id': 'Pt',
      'name': 'Bạch kim (Pt)',
      'factor': 10.0,
      'color': Color(0xFFE0E0E0),
    },
    {
      'id': 'Fe',
      'name': 'Sắt (Fe)',
      'factor': 3.0,
      'color': Color(0xFFB0BEC5),
    },
  ];

  Map<String, dynamic> _calculateKinetics() {
    final reaction = _reactions.firstWhere((r) => r['id'] == _selectedReaction);
    final catalystData = _catalysts.firstWhere((c) => c['id'] == (_catalyst ?? 'none'));
    
    // Tính tốc độ phản ứng theo phương trình Arrhenius
    // k = A * e^(-Ea/RT)
    double R = 8.314; // J/(mol·K)
    double T = _temperature + 273.15; // Kelvin
    double Ea = (reaction['activationEnergy'] as num).toDouble() * 1000; // J/mol
    double A = (reaction['baseRate'] as num).toDouble();
    
    double k = A * math.exp(-Ea / (R * T)) * (catalystData['factor'] as num).toDouble();
    double rate = k * _concentration;
    
    // Thời gian bán hủy
    double halfLife = 0.693 / k;
    
    // Năng lượng hoạt hóa hiệu dụng
    double effectiveEa = Ea / catalystData['factor'];
    
    String analysis = '''
📈 Phân tích động học:

1. Hằng số tốc độ (k):
   k = A × e^(-Ea/RT)
   k = ${k.toStringAsExponential(2)} s⁻¹

2. Tốc độ phản ứng (v):
   v = k × [C]
   v = ${rate.toStringAsExponential(2)} mol/(L·s)

3. Thời gian bán hủy (t₁/₂):
   t₁/₂ = 0.693 / k
   t₁/₂ = ${halfLife.toStringAsFixed(2)} giây

4. Năng lượng hoạt hóa:
   Ea = ${(Ea/1000).toStringAsFixed(0)} kJ/mol
   Ea hiệu dụng = ${(effectiveEa/1000).toStringAsFixed(0)} kJ/mol

5. Ảnh hưởng của yếu tố:
   • Nhiệt độ: ${_temperature.toStringAsFixed(0)}°C
   • Nồng độ: ${_concentration.toStringAsFixed(1)} M
   • Chất xúc tác: ${catalystData['name']} (×${catalystData['factor']})
''';

    return {
      'k': k,
      'rate': rate,
      'halfLife': halfLife,
      'effectiveEa': effectiveEa,
      'analysis': analysis,
      'reactionSpeed': (rate * 100).clamp(0, 100),
    };
  }

  void _runExperiment() async {
    if (_selectedReaction == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng chọn phản ứng'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isRunning = true;
      _showResult = false;
    });

    _reactionController.forward(from: 0);
    _graphController.forward(from: 0);

    await Future.delayed(const Duration(milliseconds: 3000));

    final result = _calculateKinetics();

    setState(() {
      _result = result;
      _showResult = true;
      _isRunning = false;
    });

    _reactionController.reset();
    _graphController.reset();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final scaleX = width / 440;

    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Động Học Phản Ứng',
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
                    '1. Chọn phản ứng nghiên cứu\n'
                    '2. Điều chỉnh nhiệt độ\n'
                    '3. Điều chỉnh nồng độ\n'
                    '4. Chọn chất xúc tác (nếu có)\n'
                    '5. Nhấn "Chạy thí nghiệm"\n'
                    '6. Quan sát tốc độ và phân tích kết quả',
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
                  colors: [Colors.deepOrange.shade700, Colors.deepOrange.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16 * scaleX),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepOrange.shade700.withOpacity(0.3),
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
                    child: Icon(Icons.speed, color: Colors.white, size: 32 * scaleX),
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
                          'Nghiên cứu tốc độ và cơ chế phản ứng',
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

            // Reaction selection
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: Row(
                children: [
                  Icon(Icons.science, color: Colors.deepOrange, size: 20 * scaleX),
                  SizedBox(width: 8 * scaleX),
                  Text(
                    'Chọn phản ứng:',
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

            // Reactions list
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: Column(
                children: _reactions.map((reaction) {
                  final isSelected = _selectedReaction == reaction['id'];
                  return GestureDetector(
                    onTap: () => setState(() {
                      _selectedReaction = reaction['id'];
                      _showResult = false;
                    }),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10 * scaleX),
                      padding: EdgeInsets.all(12 * scaleX),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12 * scaleX),
                        border: Border.all(
                          color: isSelected ? Colors.deepOrange : Colors.grey.shade300,
                          width: isSelected ? 3 : 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isSelected 
                                ? Colors.deepOrange.withOpacity(0.3)
                                : Colors.black.withOpacity(0.05),
                            blurRadius: isSelected ? 12 : 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50 * scaleX,
                            height: 50 * scaleX,
                            decoration: BoxDecoration(
                              color: reaction['color'],
                              borderRadius: BorderRadius.circular(10 * scaleX),
                            ),
                            child: Icon(Icons.science, color: Colors.white, size: 24 * scaleX),
                          ),
                          SizedBox(width: 12 * scaleX),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  reaction['name'],
                                  style: TextStyle(
                                    fontSize: 14 * scaleX,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 4 * scaleX),
                                Text(
                                  reaction['equation'],
                                  style: TextStyle(
                                    fontSize: 11 * scaleX,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Icon(Icons.check_circle, color: Colors.deepOrange, size: 24 * scaleX),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 24 * scaleX),

            // Parameters
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Điều kiện phản ứng:',
                      style: TextStyle(
                        fontSize: 16 * scaleX,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 16 * scaleX),
                    
                    // Temperature
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '🌡️ Nhiệt độ:',
                          style: TextStyle(fontSize: 14 * scaleX, color: AppColors.textPrimary),
                        ),
                        Text(
                          '${_temperature.toStringAsFixed(0)}°C',
                          style: TextStyle(
                            fontSize: 16 * scaleX,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: _temperature,
                      min: 0,
                      max: 100,
                      divisions: 20,
                      activeColor: Colors.deepOrange,
                      onChanged: (value) {
                        setState(() {
                          _temperature = value;
                          _showResult = false;
                        });
                      },
                    ),
                    
                    SizedBox(height: 12 * scaleX),
                    
                    // Concentration
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '⚗️ Nồng độ:',
                          style: TextStyle(fontSize: 14 * scaleX, color: AppColors.textPrimary),
                        ),
                        Text(
                          '${_concentration.toStringAsFixed(1)} M',
                          style: TextStyle(
                            fontSize: 16 * scaleX,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: _concentration,
                      min: 0.1,
                      max: 3.0,
                      divisions: 29,
                      activeColor: Colors.deepOrange,
                      onChanged: (value) {
                        setState(() {
                          _concentration = value;
                          _showResult = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24 * scaleX),

            // Catalyst selection
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: Row(
                children: [
                  Icon(Icons.auto_fix_high, color: Colors.deepOrange, size: 20 * scaleX),
                  SizedBox(width: 8 * scaleX),
                  Text(
                    'Chất xúc tác:',
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

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: Wrap(
                spacing: 10 * scaleX,
                runSpacing: 10 * scaleX,
                children: _catalysts.map((cat) {
                  final isSelected = _catalyst == cat['id'];
                  return GestureDetector(
                    onTap: () => setState(() {
                      _catalyst = cat['id'];
                      _showResult = false;
                    }),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16 * scaleX, vertical: 10 * scaleX),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.deepOrange : Colors.white,
                        borderRadius: BorderRadius.circular(20 * scaleX),
                        border: Border.all(
                          color: isSelected ? Colors.deepOrange : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        '${cat['name']} (×${cat['factor']})',
                        style: TextStyle(
                          fontSize: 12 * scaleX,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 24 * scaleX),

            // Run button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: SizedBox(
                width: double.infinity,
                height: 56 * scaleX,
                child: ElevatedButton(
                  onPressed: _isRunning ? null : _runExperiment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16 * scaleX),
                    ),
                    elevation: 4,
                  ),
                  child: _isRunning
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
                              'Đang chạy...',
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
                              'Chạy thí nghiệm',
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
    final analysis = _result!['analysis'] as String;
    final reactionSpeed = _result!['reactionSpeed'] as double;

    return Container(
      margin: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16 * scale),
        boxShadow: [
          BoxShadow(
            color: Colors.deepOrange.withOpacity(0.2),
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
              color: Colors.deepOrange.shade50,
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
                  child: Icon(Icons.speed, color: Colors.deepOrange, size: 28 * scale),
                ),
                SizedBox(width: 12 * scale),
                Expanded(
                  child: Text(
                    'Kết quả động học',
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
                // Speed indicator
                Text(
                  'Tốc độ phản ứng:',
                  style: TextStyle(
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
                SizedBox(height: 8 * scale),
                Container(
                  height: 20 * scale,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10 * scale),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: reactionSpeed / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.orange, Colors.deepOrange],
                        ),
                        borderRadius: BorderRadius.circular(10 * scale),
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 16 * scale),
                
                // Analysis
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14 * scale),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F7FA),
                    borderRadius: BorderRadius.circular(10 * scale),
                  ),
                  child: Text(
                    analysis,
                    style: TextStyle(
                      fontSize: 11 * scale,
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
