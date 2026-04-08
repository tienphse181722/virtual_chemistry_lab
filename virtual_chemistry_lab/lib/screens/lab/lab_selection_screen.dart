import 'package:flutter/material.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';
import 'package:virtual_chemistry_lab/screens/lab/mix_chemicals_screen.dart';
import 'package:virtual_chemistry_lab/screens/lab/burn_chemical_screen.dart';
import 'package:virtual_chemistry_lab/screens/lab/balance_equation_screen.dart';
import 'package:virtual_chemistry_lab/screens/lab/electrolysis_screen.dart';
import 'package:virtual_chemistry_lab/screens/course/periodic_table_screen.dart';
import 'package:virtual_chemistry_lab/screens/lab/quantitative_analysis_screen.dart';
import 'package:virtual_chemistry_lab/screens/lab/reaction_kinetics_screen.dart';

/// SCR-005: Lab Selection
class LabSelectionScreen extends StatefulWidget {
  const LabSelectionScreen({super.key});

  @override
  State<LabSelectionScreen> createState() => _LabSelectionScreenState();
}

class _LabSelectionScreenState extends State<LabSelectionScreen> {
  String _selectedFilter = 'Tất cả';

  // All lab experiments data
  final List<Map<String, dynamic>> _allLabs = [
    {
      'title': 'Trộn Hóa Chất',
      'description': 'Thí nghiệm an toàn với mô phỏng tiên tiến thực tế',
      'icon': Icons.science,
      'color': Colors.blue,
      'difficulty': 'Cơ bản',
      'duration': '15 phút',
      'points': '50 điểm',
      'isCompleted': true,
      'hasScreen': true,
    },
    {
      'title': 'Đốt Hóa Chất',
      'description': 'Mô phỏng quá trình đốt cháy với hiệu ứng thực tế',
      'icon': Icons.local_fire_department,
      'color': Colors.orange,
      'difficulty': 'Cơ bản',
      'duration': '20 phút',
      'points': '75 điểm',
      'isCompleted': false,
      'hasScreen': true,
    },
    {
      'title': 'Bảng Tuần Hoàn',
      'description': 'Tương tác với bảng tuần hoàn 3D',
      'icon': Icons.grid_on,
      'color': Colors.teal,
      'difficulty': 'Cơ bản',
      'duration': '10 phút',
      'points': '30 điểm',
      'isCompleted': false,
      'hasScreen': true,
    },
    {
      'title': 'Cân Bằng Phương Trình',
      'description': 'Thực hành cân bằng các phương trình hóa học phức tạp',
      'icon': Icons.balance,
      'color': Colors.purple,
      'difficulty': 'Nâng cao',
      'duration': '25 phút',
      'points': '100 điểm',
      'isCompleted': false,
      'hasScreen': true,
    },
    {
      'title': 'Điện Phân Dung Dịch',
      'description': 'Mô phỏng quá trình điện phân các dung dịch',
      'icon': Icons.electric_bolt,
      'color': Colors.amber,
      'difficulty': 'Nâng cao',
      'duration': '30 phút',
      'points': '120 điểm',
      'isCompleted': false,
      'hasScreen': true,
    },
    {
      'title': 'Phân Tích Định Lượng',
      'description': 'Thực hành phân tích định lượng các chất trong dung dịch',
      'icon': Icons.analytics,
      'color': Colors.red,
      'difficulty': 'Thử thách',
      'duration': '40 phút',
      'points': '150 điểm',
      'isCompleted': false,
      'hasScreen': true,
    },
    {
      'title': 'Động Học Phản Ứng',
      'description': 'Nghiên cứu tốc độ và cơ chế phản ứng hóa học',
      'icon': Icons.speed,
      'color': Colors.deepOrange,
      'difficulty': 'Thử thách',
      'duration': '45 phút',
      'points': '180 điểm',
      'isCompleted': false,
      'hasScreen': true,
    },
  ];

  List<Map<String, dynamic>> _getFilteredLabs() {
    if (_selectedFilter == 'Tất cả') {
      return _allLabs;
    }
    return _allLabs.where((lab) => lab['difficulty'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    
    final scaleX = width / 440;
    final scaleY = height / 956;
    
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            overscroll: false,
            physics: const ClampingScrollPhysics(),
          ),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20 * scaleX, vertical: 16 * scaleY),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 49 * scaleX,
                    height: 47 * scaleY,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                      border: Border.all(color: AppColors.primary, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        'P',
                        style: TextStyle(
                          fontSize: 24 * scaleX,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'PHÒNG THÍ NGHIỆM',
                    style: TextStyle(
                      fontSize: 18 * scaleX,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 16 * scaleY),
              
              // Featured Lab Card
              Container(
                padding: EdgeInsets.all(16 * scaleX),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary.withOpacity(0.7),
                      AppColors.primary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20 * scaleX),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.science,
                      size: 40 * scaleX,
                      color: Colors.white,
                    ),
                    SizedBox(width: 15 * scaleX),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phòng Thí Nghiệm Ảo',
                            style: TextStyle(
                              fontSize: 18 * scaleX,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5 * scaleY),
                          Text(
                            'Thực hành an toàn với mô phỏng tiên tiến và thu thập dữ liệu thời gian thực',
                            style: TextStyle(
                              fontSize: 12 * scaleX,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 20 * scaleY),
              
              // Section Title
              Text(
                'Danh mục thí nghiệm',
                style: TextStyle(
                  fontSize: 20 * scaleX,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              
              SizedBox(height: 12 * scaleY),
              
              // Filter Tabs
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterTab('Tất cả', scaleX),
                    SizedBox(width: 10 * scaleX),
                    _buildFilterTab('Cơ bản', scaleX),
                    SizedBox(width: 10 * scaleX),
                    _buildFilterTab('Nâng cao', scaleX),
                    SizedBox(width: 10 * scaleX),
                    _buildFilterTab('Thử thách', scaleX),
                  ],
                ),
              ),
              
              SizedBox(height: 20 * scaleY),
              
              // Lab List - Dynamic based on filter
              ..._getFilteredLabs().map((lab) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 15 * scaleY),
                  child: _buildLabListItem(
                    context,
                    lab['title'],
                    lab['description'],
                    lab['icon'],
                    lab['color'],
                    lab['difficulty'],
                    lab['duration'],
                    lab['points'],
                    lab['isCompleted'],
                    () {
                      if (lab['hasScreen']) {
                        if (lab['title'] == 'Trộn Hóa Chất') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const MixChemicalsScreen()),
                          );
                        } else if (lab['title'] == 'Đốt Hóa Chất') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const BurnChemicalScreen()),
                          );
                        } else if (lab['title'] == 'Bảng Tuần Hoàn') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const PeriodicTableScreen()),
                          );
                        } else if (lab['title'] == 'Cân Bằng Phương Trình') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const BalanceEquationScreen()),
                          );
                        } else if (lab['title'] == 'Điện Phân Dung Dịch') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ElectrolysisScreen()),
                          );
                        } else if (lab['title'] == 'Phân Tích Định Lượng') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const QuantitativeAnalysisScreen()),
                          );
                        } else if (lab['title'] == 'Động Học Phản Ứng') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ReactionKineticsScreen()),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Tính năng đang phát triển')),
                        );
                      }
                    },
                    scaleX,
                    scaleY,
                  ),
                );
              }).toList(),
              
              SizedBox(height: 20 * scaleY),
            ],
          ),
        ),
      ),
    ),
    );
  }

  Widget _buildFilterTab(String label, double scale) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 8 * scale),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20 * scale),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14 * scale,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildLabListItem(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color color,
    String difficulty,
    String duration,
    String points,
    bool isCompleted,
    VoidCallback onTap,
    double scaleX,
    double scaleY,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15 * scaleX),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15 * scaleX),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 60 * scaleX,
              height: 60 * scaleX,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12 * scaleX),
              ),
              child: Icon(
                icon,
                size: 30 * scaleX,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 15 * scaleX),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 16 * scaleX,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isCompleted)
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 20 * scaleX,
                        ),
                    ],
                  ),
                  SizedBox(height: 4 * scaleY),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 11 * scaleX,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6 * scaleY),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTag(difficulty, Colors.green, scaleX),
                      SizedBox(width: 8 * scaleX),
                      _buildTag(duration, Colors.blue, scaleX),
                      SizedBox(width: 8 * scaleX),
                      _buildTag(points, Colors.orange, scaleX),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16 * scaleX,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String label, Color color, double scale) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8 * scale, vertical: 4 * scale),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5 * scale),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10 * scale,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildLabCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
    double scaleX,
    double scaleY,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.8),
              color,
            ],
          ),
          borderRadius: BorderRadius.circular(20 * scaleX),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(15 * scaleX),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50 * scaleX,
                color: Colors.white,
              ),
              SizedBox(height: 15 * scaleY),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18 * scaleX,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5 * scaleY),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12 * scaleX,
                  color: Colors.white.withOpacity(0.9),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
