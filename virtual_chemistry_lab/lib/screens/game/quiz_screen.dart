import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';
import 'package:virtual_chemistry_lab/providers/quiz_provider.dart';
import 'package:virtual_chemistry_lab/providers/auth_provider.dart';
import 'package:virtual_chemistry_lab/providers/progress_provider.dart';
import 'package:virtual_chemistry_lab/screens/game/quiz_nhanh_screen.dart';
import 'package:virtual_chemistry_lab/screens/game/ghi_nho_screen.dart';
import 'package:virtual_chemistry_lab/screens/game/xay_dung_phan_tu_screen.dart';
import 'package:virtual_chemistry_lab/screens/game/ghep_tu_screen.dart';
import 'package:virtual_chemistry_lab/screens/game/tong_hop_screen.dart';

/// SCR-012: Chemistry Quiz/Challenge
/// Bài tập hóa học dạng game
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String _selectedFilter = 'Tất cả';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<QuizProvider>().loadQuizzes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final scaleX = width / 440;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with avatar
            Padding(
              padding: EdgeInsets.fromLTRB(20.0 * scaleX, 12.0 * scaleX, 20.0 * scaleX, 8.0 * scaleX),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Avatar
                  Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      final user = authProvider.user;
                      return Container(
                        width: 49 * scaleX,
                        height: 47 * scaleX,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                        child: Center(
                          child: Text(
                            user?.displayName?.substring(0, 1).toUpperCase() ?? 'P',
                            style: TextStyle(
                              fontSize: 24 * scaleX,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Achievement Card
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0 * scaleX),
              child: Container(
                padding: EdgeInsets.all(16 * scaleX),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                  ),
                  borderRadius: BorderRadius.circular(20 * scaleX),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.emoji_events, color: Colors.white, size: 20 * scaleX),
                        SizedBox(width: 8 * scaleX),
                        Text(
                          'Thành Tích Của Bạn',
                          style: TextStyle(
                            fontSize: 16 * scaleX,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12 * scaleX),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Consumer<ProgressProvider>(
                          builder: (context, progressProvider, _) {
                            final progress = progressProvider.progress;
                            return _buildAchievementStat(
                              '${progress?.totalPoints ?? 0}',
                              'Điểm',
                              Icons.star,
                              scaleX,
                            );
                          },
                        ),
                        Consumer<ProgressProvider>(
                          builder: (context, progressProvider, _) {
                            final progress = progressProvider.progress;
                            final completed = progress?.completedAchievements ?? 0;
                            return _buildAchievementStat(
                              '$completed/10',
                              'Hoàn thành',
                              Icons.check_circle,
                              scaleX,
                            );
                          },
                        ),
                        Consumer<ProgressProvider>(
                          builder: (context, progressProvider, _) {
                            final progress = progressProvider.progress;
                            return _buildAchievementStat(
                              '${progress?.currentStreak ?? 0} ngày',
                              'Streak',
                              Icons.local_fire_department,
                              scaleX,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 12 * scaleX),

            // Search bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0 * scaleX),
              child: Container(
                height: 45 * scaleX,
                decoration: BoxDecoration(
                  color: AppColors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12 * scaleX),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 15 * scaleX),
                    Icon(Icons.search, color: AppColors.textSecondary, size: 20 * scaleX),
                    SizedBox(width: 10 * scaleX),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Tìm kiếm bài tập...',
                          hintStyle: TextStyle(
                            fontSize: 14 * scaleX,
                            color: AppColors.textSecondary,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 12 * scaleX),

            // Section title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0 * scaleX),
              child: Text(
                'Danh mục bài tập',
                style: TextStyle(
                  fontSize: 18 * scaleX,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            SizedBox(height: 12 * scaleX),

            // Filter Tabs
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0 * scaleX),
              child: Row(
                children: [
                  _buildFilterTab('Tất cả', scaleX),
                  SizedBox(width: 10 * scaleX),
                  _buildFilterTab('Cơ bản', scaleX),
                  SizedBox(width: 10 * scaleX),
                  _buildFilterTab('Nâng cao', scaleX),
                ],
              ),
            ),

            SizedBox(height: 12 * scaleX),

            // Quiz List - Scrollable with wrap_content items
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(20.0 * scaleX, 0, 20.0 * scaleX, 20.0 * scaleX),
                physics: const ClampingScrollPhysics(),
                itemCount: _getFilteredQuizzes().length,
                separatorBuilder: (context, index) => SizedBox(height: 12 * scaleX),
                itemBuilder: (context, index) {
                  final quiz = _getFilteredQuizzes()[index];
                  return _buildQuizCard(
                    quiz['title'] as String,
                    quiz['description'] as String,
                    quiz['icon'] as IconData,
                    quiz['color'] as Color,
                    quiz['difficulty'] as String,
                    quiz['questions'] as String,
                    quiz['points'] as String,
                    scaleX,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredQuizzes() {
    final allQuizzes = [
      {
        'title': 'Quiz Nhanh',
        'description': 'Trả lời nhanh trong thời gian giới hạn',
        'icon': Icons.flash_on,
        'color': Colors.orange,
        'difficulty': 'Cơ bản',
        'questions': '3 levels',
        'points': '16 câu',
      },
      {
        'title': 'Trò Chơi Ghi Nhớ',
        'description': 'Tìm cặp công thức và tên hóa chất',
        'icon': Icons.psychology,
        'color': Colors.purple,
        'difficulty': 'Cơ bản',
        'questions': '3 levels',
        'points': '24 cặp',
      },
      {
        'title': 'Xây Dựng Phân Tử',
        'description': 'Tạo phân tử bằng cách kéo thả các nguyên tử',
        'icon': Icons.account_tree,
        'color': Colors.teal,
        'difficulty': 'Cơ bản',
        'questions': '3 levels',
        'points': '12 phân tử',
      },
      {
        'title': 'Ghép Từ Hóa Học',
        'description': 'Ghép các chữ cái thành từ khóa hóa học',
        'icon': Icons.text_fields,
        'color': Colors.green,
        'difficulty': 'Cơ bản',
        'questions': '3 levels',
        'points': '18 từ',
      },
      {
        'title': 'Kiến Thức Tổng Hợp',
        'description': 'Kiểm tra kiến thức toàn diện về hóa học',
        'icon': Icons.school,
        'color': Colors.blue,
        'difficulty': 'Nâng cao',
        'questions': '3 levels',
        'points': '15 câu',
      },
    ];

    if (_selectedFilter == 'Tất cả') {
      return allQuizzes;
    } else if (_selectedFilter == 'Cơ bản') {
      return allQuizzes.where((q) => q['difficulty'] == 'Cơ bản').toList();
    } else if (_selectedFilter == 'Nâng cao') {
      return allQuizzes.where((q) => q['difficulty'] == 'Nâng cao').toList();
    }
    return allQuizzes;
  }

  Widget _buildAchievementStat(String value, String label, IconData icon, double scale) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 20 * scale),
        SizedBox(height: 4 * scale),
        Text(
          value,
          style: TextStyle(
            fontSize: 16 * scale,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11 * scale,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterTab(String label, double scale) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20 * scale, vertical: 10 * scale),
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

  Widget _buildQuizCard(
    String title,
    String description,
    IconData icon,
    Color color,
    String difficulty,
    String questions,
    String points,
    double scale,
  ) {
    return InkWell(
      onTap: () => _navigateToGame(title),
      child: Container(
        padding: EdgeInsets.all(12 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12 * scale),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 55 * scale,
              height: 55 * scale,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12 * scale),
              ),
              child: Icon(
                icon,
                size: 28 * scale,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 14 * scale),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15 * scale,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4 * scale),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 11 * scale,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6 * scale),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTag(difficulty, _getDifficultyColor(difficulty), scale),
                      SizedBox(width: 6 * scale),
                      _buildTag(questions, Colors.blue, scale),
                      SizedBox(width: 6 * scale),
                      _buildTag(points, Colors.orange, scale),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToGame(String title) {
    Widget? screen;
    
    switch (title) {
      case 'Quiz Nhanh':
        screen = const QuizNhanhScreen();
        break;
      case 'Trò Chơi Ghi Nhớ':
        screen = const GhiNhoScreen();
        break;
      case 'Xây Dựng Phân Tử':
        screen = const XayDungPhanTuScreen();
        break;
      case 'Ghép Từ Hóa Học':
        screen = const GhepTuScreen();
        break;
      case 'Kiến Thức Tổng Hợp':
        screen = const TongHopScreen();
        break;
    }
    
    if (screen != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen!),
      );
    }
  }

  Widget _buildTag(String label, Color color, double scale) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6 * scale, vertical: 2 * scale),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4 * scale),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 9 * scale,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    if (difficulty == 'Cơ bản') return Colors.green;
    if (difficulty == 'Trung bình') return Colors.grey;
    if (difficulty == 'Nâng cao') return Colors.orange;
    return Colors.blue;
  }
}
