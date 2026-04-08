import 'package:flutter/material.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';

class BalanceEquationScreen extends StatefulWidget {
  const BalanceEquationScreen({super.key});

  @override
  State<BalanceEquationScreen> createState() => _BalanceEquationScreenState();
}

class _BalanceEquationScreenState extends State<BalanceEquationScreen> {
  int _currentQuestionIndex = 0;
  Map<String, int> _userCoefficients = {};
  bool _showResult = false;
  bool _isCorrect = false;

  // Danh sách phương trình cần cân bằng
  final List<Map<String, dynamic>> _equations = [
    {
      'reactants': ['H₂', 'O₂'],
      'products': ['H₂O'],
      'correctCoefficients': {'H₂': 2, 'O₂': 1, 'H₂O': 2},
      'name': 'Tạo nước',
      'difficulty': 'Cơ bản',
    },
    {
      'reactants': ['N₂', 'H₂'],
      'products': ['NH₃'],
      'correctCoefficients': {'N₂': 1, 'H₂': 3, 'NH₃': 2},
      'name': 'Tổng hợp amoniac',
      'difficulty': 'Cơ bản',
    },
    {
      'reactants': ['CH₄', 'O₂'],
      'products': ['CO₂', 'H₂O'],
      'correctCoefficients': {'CH₄': 1, 'O₂': 2, 'CO₂': 1, 'H₂O': 2},
      'name': 'Đốt cháy metan',
      'difficulty': 'Trung bình',
    },
    {
      'reactants': ['Fe', 'O₂'],
      'products': ['Fe₂O₃'],
      'correctCoefficients': {'Fe': 4, 'O₂': 3, 'Fe₂O₃': 2},
      'name': 'Gỉ sắt',
      'difficulty': 'Cơ bản',
    },
    {
      'reactants': ['C₂H₅OH', 'O₂'],
      'products': ['CO₂', 'H₂O'],
      'correctCoefficients': {'C₂H₅OH': 1, 'O₂': 3, 'CO₂': 2, 'H₂O': 3},
      'name': 'Đốt cháy etanol',
      'difficulty': 'Trung bình',
    },
    {
      'reactants': ['Al', 'O₂'],
      'products': ['Al₂O₃'],
      'correctCoefficients': {'Al': 4, 'O₂': 3, 'Al₂O₃': 2},
      'name': 'Oxi hóa nhôm',
      'difficulty': 'Cơ bản',
    },
    {
      'reactants': ['C₃H₈', 'O₂'],
      'products': ['CO₂', 'H₂O'],
      'correctCoefficients': {'C₃H₈': 1, 'O₂': 5, 'CO₂': 3, 'H₂O': 4},
      'name': 'Đốt cháy propan',
      'difficulty': 'Trung bình',
    },
    {
      'reactants': ['KClO₃'],
      'products': ['KCl', 'O₂'],
      'correctCoefficients': {'KClO₃': 2, 'KCl': 2, 'O₂': 3},
      'name': 'Phân hủy KClO₃',
      'difficulty': 'Trung bình',
    },
    {
      'reactants': ['Fe₂O₃', 'CO'],
      'products': ['Fe', 'CO₂'],
      'correctCoefficients': {'Fe₂O₃': 1, 'CO': 3, 'Fe': 2, 'CO₂': 3},
      'name': 'Luyện gang',
      'difficulty': 'Nâng cao',
    },
    {
      'reactants': ['C₆H₁₂O₆', 'O₂'],
      'products': ['CO₂', 'H₂O'],
      'correctCoefficients': {'C₆H₁₂O₆': 1, 'O₂': 6, 'CO₂': 6, 'H₂O': 6},
      'name': 'Đốt cháy glucozơ',
      'difficulty': 'Nâng cao',
    },
    {
      'reactants': ['NH₃', 'O₂'],
      'products': ['NO', 'H₂O'],
      'correctCoefficients': {'NH₃': 4, 'O₂': 5, 'NO': 4, 'H₂O': 6},
      'name': 'Oxi hóa amoniac',
      'difficulty': 'Nâng cao',
    },
    {
      'reactants': ['P₂O₅', 'H₂O'],
      'products': ['H₃PO₄'],
      'correctCoefficients': {'P₂O₅': 1, 'H₂O': 3, 'H₃PO₄': 2},
      'name': 'Tạo axit photphoric',
      'difficulty': 'Trung bình',
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeCoefficients();
  }

  void _initializeCoefficients() {
    _userCoefficients.clear();
    final equation = _equations[_currentQuestionIndex];
    for (var reactant in equation['reactants']) {
      _userCoefficients[reactant] = 1;
    }
    for (var product in equation['products']) {
      _userCoefficients[product] = 1;
    }
  }

  void _checkAnswer() {
    final equation = _equations[_currentQuestionIndex];
    final correctCoefficients = equation['correctCoefficients'] as Map<String, int>;
    
    bool correct = true;
    for (var entry in correctCoefficients.entries) {
      if (_userCoefficients[entry.key] != entry.value) {
        correct = false;
        break;
      }
    }
    
    setState(() {
      _isCorrect = correct;
      _showResult = true;
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _equations.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _showResult = false;
        _initializeCoefficients();
      });
    } else {
      // Hoàn thành tất cả câu hỏi
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Chúc mừng!'),
          content: Text('Bạn đã hoàn thành tất cả ${_equations.length} phương trình!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _currentQuestionIndex = 0;
                  _showResult = false;
                  _initializeCoefficients();
                });
              },
              child: Text('Làm lại'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('Thoát'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final scaleX = width / 440;
    final equation = _equations[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Cân Bằng Phương Trình',
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
                    '1. Điều chỉnh hệ số cho mỗi chất\n'
                    '2. Đảm bảo số nguyên tử mỗi nguyên tố bằng nhau ở 2 vế\n'
                    '3. Nhấn "Kiểm tra" để xem kết quả\n'
                    '4. Nhấn "Câu tiếp theo" để làm tiếp',
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
                  colors: [Colors.purple.shade700, Colors.purple.shade500],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16 * scaleX),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.shade700.withOpacity(0.3),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12 * scaleX),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12 * scaleX),
                        ),
                        child: Icon(Icons.balance, color: Colors.white, size: 32 * scaleX),
                      ),
                      SizedBox(width: 16 * scaleX),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Câu ${_currentQuestionIndex + 1}/${_equations.length}',
                              style: TextStyle(
                                fontSize: 14 * scaleX,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                            SizedBox(height: 4 * scaleX),
                            Text(
                              equation['name'],
                              style: TextStyle(
                                fontSize: 18 * scaleX,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12 * scaleX, vertical: 6 * scaleX),
                        decoration: BoxDecoration(
                          color: _getDifficultyColor(equation['difficulty']),
                          borderRadius: BorderRadius.circular(12 * scaleX),
                        ),
                        child: Text(
                          equation['difficulty'],
                          style: TextStyle(
                            fontSize: 12 * scaleX,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Equation display
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              padding: EdgeInsets.all(20 * scaleX),
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
                  Text(
                    'Điều chỉnh hệ số:',
                    style: TextStyle(
                      fontSize: 16 * scaleX,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 20 * scaleX),
                  
                  // Reactants
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8 * scaleX,
                    runSpacing: 12 * scaleX,
                    children: [
                      ...equation['reactants'].asMap().entries.map((entry) {
                        int idx = entry.key;
                        String reactant = entry.value;
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildCoefficientControl(reactant, scaleX),
                            if (idx < equation['reactants'].length - 1)
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8 * scaleX),
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                    fontSize: 20 * scaleX,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                          ],
                        );
                      }).toList(),
                      
                      // Arrow
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12 * scaleX),
                        child: Icon(
                          Icons.arrow_forward,
                          size: 28 * scaleX,
                          color: Colors.purple,
                        ),
                      ),
                      
                      // Products
                      ...equation['products'].asMap().entries.map((entry) {
                        int idx = entry.key;
                        String product = entry.value;
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildCoefficientControl(product, scaleX),
                            if (idx < equation['products'].length - 1)
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8 * scaleX),
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                    fontSize: 20 * scaleX,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 24 * scaleX),

            // Check button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: SizedBox(
                width: double.infinity,
                height: 56 * scaleX,
                child: ElevatedButton(
                  onPressed: _showResult ? null : _checkAnswer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16 * scaleX),
                    ),
                    elevation: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, color: Colors.white, size: 24 * scaleX),
                      SizedBox(width: 8 * scaleX),
                      Text(
                        'Kiểm tra',
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
            if (_showResult)
              _buildResultCard(scaleX),

            SizedBox(height: 32 * scaleX),
          ],
        ),
      ),
    );
  }

  Widget _buildCoefficientControl(String substance, double scale) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 8 * scale),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: Colors.purple.shade200, width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Decrease button
          InkWell(
            onTap: () {
              if (_userCoefficients[substance]! > 1) {
                setState(() {
                  _userCoefficients[substance] = _userCoefficients[substance]! - 1;
                });
              }
            },
            child: Container(
              width: 28 * scale,
              height: 28 * scale,
              decoration: BoxDecoration(
                color: Colors.purple,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.remove, color: Colors.white, size: 16 * scale),
            ),
          ),
          
          SizedBox(width: 12 * scale),
          
          // Coefficient and substance
          Text(
            '${_userCoefficients[substance]} $substance',
            style: TextStyle(
              fontSize: 16 * scale,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          
          SizedBox(width: 12 * scale),
          
          // Increase button
          InkWell(
            onTap: () {
              if (_userCoefficients[substance]! < 10) {
                setState(() {
                  _userCoefficients[substance] = _userCoefficients[substance]! + 1;
                });
              }
            },
            child: Container(
              width: 28 * scale,
              height: 28 * scale,
              decoration: BoxDecoration(
                color: Colors.purple,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: Colors.white, size: 16 * scale),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard(double scale) {
    final equation = _equations[_currentQuestionIndex];
    final correctCoefficients = equation['correctCoefficients'] as Map<String, int>;
    
    Color borderColor = _isCorrect ? Colors.green : Colors.red;
    Color bgColor = _isCorrect ? Colors.green.shade50 : Colors.red.shade50;
    IconData icon = _isCorrect ? Icons.check_circle : Icons.cancel;

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
                    _isCorrect ? 'Chính xác!' : 'Chưa đúng',
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
                if (!_isCorrect) ...[
                  Text(
                    'Đáp án đúng:',
                    style: TextStyle(
                      fontSize: 14 * scale,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 8 * scale),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14 * scale),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(10 * scale),
                      border: Border.all(color: Colors.green, width: 2),
                    ),
                    child: Text(
                      _buildCorrectEquation(equation),
                      style: TextStyle(
                        fontSize: 14 * scale,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 16 * scale),
                ],
                
                // Next button
                SizedBox(
                  width: double.infinity,
                  height: 48 * scale,
                  child: ElevatedButton(
                    onPressed: _nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12 * scale),
                      ),
                    ),
                    child: Text(
                      _currentQuestionIndex < _equations.length - 1 ? 'Câu tiếp theo' : 'Hoàn thành',
                      style: TextStyle(
                        fontSize: 16 * scale,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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

  String _buildCorrectEquation(Map<String, dynamic> equation) {
    final correctCoefficients = equation['correctCoefficients'] as Map<String, int>;
    final reactants = equation['reactants'] as List;
    final products = equation['products'] as List;
    
    String reactantStr = reactants.map((r) => '${correctCoefficients[r]}$r').join(' + ');
    String productStr = products.map((p) => '${correctCoefficients[p]}$p').join(' + ');
    
    return '$reactantStr → $productStr';
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Cơ bản':
        return Colors.green;
      case 'Trung bình':
        return Colors.orange;
      case 'Nâng cao':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
