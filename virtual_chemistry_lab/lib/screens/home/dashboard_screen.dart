import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';
import 'package:virtual_chemistry_lab/screens/lab/lab_selection_screen.dart';
import 'package:virtual_chemistry_lab/screens/game/quiz_screen.dart';
import 'package:virtual_chemistry_lab/screens/profile/profile_screen.dart';
import 'package:virtual_chemistry_lab/screens/profile/achievements_screen.dart';
import 'package:virtual_chemistry_lab/screens/course/course_detail_screen.dart';
import 'package:virtual_chemistry_lab/providers/quiz_provider.dart';
import 'package:virtual_chemistry_lab/providers/auth_provider.dart';
import 'package:virtual_chemistry_lab/providers/progress_provider.dart';

/// SCR-004: Home/Dashboard - Enhanced Design
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  String _selectedTab = 'All';

  // Course data
  final List<Map<String, dynamic>> _allCourses = [
    {'name': 'Hóa học cơ bản', 'icon': Icons.science, 'color': Colors.blue, 'progress': 67, 'lessons': 12},
    {'name': 'Bảng tuần hoàn', 'icon': Icons.grid_on, 'color': Colors.purple, 'progress': 80, 'lessons': 8},
    {'name': 'Hóa hữu cơ', 'icon': Icons.eco, 'color': Colors.green, 'progress': 30, 'lessons': 15},
    {'name': 'Nhận biết ion', 'icon': Icons.water_drop, 'color': Colors.red, 'progress': 55, 'lessons': 9},
    {'name': 'Tổng hợp kiến thức', 'icon': Icons.emoji_events, 'color': Colors.cyan, 'progress': 20, 'lessons': 20},
  ];

  final List<Map<String, dynamic>> _recentCourses = [
    {'name': 'Hóa học cơ bản', 'icon': Icons.science, 'color': Colors.blue, 'progress': 67, 'lessons': 12},
    {'name': 'Bảng tuần hoàn', 'icon': Icons.grid_on, 'color': Colors.purple, 'progress': 80, 'lessons': 8},
    {'name': 'Nhận biết ion', 'icon': Icons.water_drop, 'color': Colors.red, 'progress': 55, 'lessons': 9},
  ];

  List<Map<String, dynamic>> _getFilteredCourses() {
    if (_selectedTab == 'Recent') return _recentCourses;
    return _allCourses;
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<QuizProvider>().loadQuizzes();
      final user = context.read<AuthProvider>().user;
      if (user != null) {
        context.read<ProgressProvider>().loadProgress(user.uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: ClipRect(
        child: _selectedIndex == 0
            ? _buildHomeScreen()
            : _selectedIndex == 1
                ? const LabSelectionScreen()
                : _selectedIndex == 2
                    ? const QuizScreen()
                    : const ProfileScreen(),
      ),
      bottomNavigationBar: Builder(
        builder: (context) {
          final width = MediaQuery.of(context).size.width;
          final scaleX = width / 440;
          
          return Container(
            height: 132 * scaleX,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40 * scaleX),
                topRight: Radius.circular(40 * scaleX),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNavItem(Icons.home, 0, scaleX),
                SizedBox(width: 64 * scaleX),
                _buildNavItem('assets/images/lab_icon.png', 1, scaleX),
                SizedBox(width: 64 * scaleX),
                _buildNavItem(Icons.emoji_events, 2, scaleX),
                SizedBox(width: 64 * scaleX),
                _buildNavItem(Icons.person, 3, scaleX),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _buildNavItem(dynamic icon, int index, double scale) {
    final isSelected = _selectedIndex == index;
    final color = isSelected ? AppColors.white : AppColors.black.withOpacity(0.5);
    final iconSize = 40 * scale;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        width: iconSize + 8,
        height: iconSize + 8,
        decoration: isSelected ? BoxDecoration(
          color: AppColors.primary.withOpacity(0.3),
          shape: BoxShape.circle,
        ) : null,
        child: Center(
          child: SizedBox(
            width: iconSize,
            height: iconSize,
            child: icon is IconData
                ? Icon(icon, size: iconSize, color: color)
                : ColorFiltered(
                    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                    child: Image.asset(
                      icon as String,
                      width: iconSize,
                      height: iconSize,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.science, size: iconSize, color: color);
                      },
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildHomeScreen() {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final scaleX = width / 440;
    
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 440),
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              overscroll: false,
              physics: const ClampingScrollPhysics(),
            ),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20 * scaleX, vertical: 12 * scaleX),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header with avatar and HOME title
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0 * scaleX, vertical: 8.0 * scaleX),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                                    user?.displayName?.substring(0, 1).toUpperCase() ?? 'U',
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
                          Text(
                            'HOME',
                            style: TextStyle(
                              fontSize: 24 * scaleX,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 12 * scaleX),

                    // Search bar
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0 * scaleX),
                      child: Container(
                        height: 33 * scaleX,
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(7 * scaleX),
                        ),
                        child: Row(
                          children: [
                            const Spacer(),
                            Icon(Icons.search, color: AppColors.black, size: 24 * scaleX),
                            SizedBox(width: 8 * scaleX),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 16 * scaleX),

                    // Your Course card - Enhanced design
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0 * scaleX),
                      child: Consumer<ProgressProvider>(
                        builder: (context, progressProvider, _) {
                          final progress = progressProvider.progress;
                          final progressPercent = progress?.progressPercentage ?? 0.0;
                          
                          return Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(20 * scaleX),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppColors.primary.withOpacity(0.8),
                                  AppColors.primary,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(25 * scaleX),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.3),
                                  blurRadius: 15,
                                  offset: Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10 * scaleX),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12 * scaleX),
                                      ),
                                      child: Icon(
                                        Icons.school,
                                        color: Colors.white,
                                        size: 24 * scaleX,
                                      ),
                                    ),
                                    SizedBox(width: 12 * scaleX),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Your Course',
                                            style: TextStyle(
                                              fontSize: 18 * scaleX,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            'Hóa học cơ bản',
                                            style: TextStyle(
                                              fontSize: 14 * scaleX,
                                              color: Colors.white.withOpacity(0.9),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16 * scaleX),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Progress',
                                            style: TextStyle(
                                              fontSize: 12 * scaleX,
                                              color: Colors.white.withOpacity(0.8),
                                            ),
                                          ),
                                          SizedBox(height: 6 * scaleX),
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10 * scaleX),
                                            child: LinearProgressIndicator(
                                              value: progressPercent / 100,
                                              backgroundColor: Colors.white.withOpacity(0.3),
                                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                              minHeight: 8 * scaleX,
                                            ),
                                          ),
                                          SizedBox(height: 4 * scaleX),
                                          Text(
                                            '${progressPercent.toStringAsFixed(0)}% Complete',
                                            style: TextStyle(
                                              fontSize: 14 * scaleX,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 12 * scaleX),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20 * scaleX, vertical: 10 * scaleX),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12 * scaleX),
                                      ),
                                      child: Text(
                                        'Continue',
                                        style: TextStyle(
                                          fontSize: 14 * scaleX,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 16 * scaleX),

                    // Achievements section - Between Your Course and Course list
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0 * scaleX),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AchievementsScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20 * scaleX),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFF59E0B),
                                Color(0xFFD97706),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(25 * scaleX),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFF59E0B).withOpacity(0.3),
                                blurRadius: 15,
                                offset: Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.emoji_events,
                                        color: Colors.white,
                                        size: 24 * scaleX,
                                      ),
                                      SizedBox(width: 8 * scaleX),
                                      Text(
                                        'Thành Tích Của Bạn',
                                        style: TextStyle(
                                          fontSize: 18 * scaleX,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12 * scaleX, vertical: 6 * scaleX),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12 * scaleX),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Xem tất cả',
                                          style: TextStyle(
                                            fontSize: 12 * scaleX,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 4 * scaleX),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 12 * scaleX,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20 * scaleX),
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
                                  Container(
                                    width: 1,
                                    height: 50 * scaleX,
                                    color: Colors.white.withOpacity(0.3),
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
                                  Container(
                                    width: 1,
                                    height: 50 * scaleX,
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                  Consumer<ProgressProvider>(
                                    builder: (context, progressProvider, _) {
                                      final progress = progressProvider.progress;
                                      return _buildAchievementStat(
                                        '${progress?.currentStreak ?? 0}',
                                        'Ngày streak',
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
                    ),

                    SizedBox(height: 16 * scaleX),

                    // Course section
                    Padding(
                      padding: EdgeInsets.only(left: 20.0 * scaleX),
                      child: Text(
                        'Course',
                        style: TextStyle(
                          fontSize: 22 * scaleX,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),

                    SizedBox(height: 12 * scaleX),

                    // Tabs
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0 * scaleX),
                      child: Row(
                        children: [
                          _buildTab('All', scaleX),
                          SizedBox(width: 40 * scaleX),
                          _buildTab('Recent', scaleX),
                        ],
                      ),
                    ),

                    SizedBox(height: 16 * scaleX),

                    // Course list - Grid 2 columns
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0 * scaleX),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          (_getFilteredCourses().length / 2).ceil(),
                          (rowIndex) {
                            final startIndex = rowIndex * 2;
                            final endIndex = (startIndex + 2).clamp(0, _getFilteredCourses().length);
                            final coursesInRow = _getFilteredCourses().sublist(startIndex, endIndex);
                            
                            return Padding(
                              padding: EdgeInsets.only(bottom: 16 * scaleX),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _buildCourseCard(
                                      coursesInRow[0]['name'],
                                      coursesInRow[0]['icon'],
                                      coursesInRow[0]['color'],
                                      coursesInRow[0]['progress'],
                                      coursesInRow[0]['lessons'],
                                      scaleX,
                                    ),
                                  ),
                                  if (coursesInRow.length > 1) ...[
                                    SizedBox(width: 16 * scaleX),
                                    Expanded(
                                      child: _buildCourseCard(
                                        coursesInRow[1]['name'],
                                        coursesInRow[1]['icon'],
                                        coursesInRow[1]['color'],
                                        coursesInRow[1]['progress'],
                                        coursesInRow[1]['lessons'],
                                        scaleX,
                                      ),
                                    ),
                                  ] else
                                    Expanded(child: SizedBox()),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    SizedBox(height: 20 * scaleX),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAchievementStat(String value, String label, IconData icon, double scale) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 28 * scale),
        SizedBox(height: 8 * scale),
        Text(
          value,
          style: TextStyle(
            fontSize: 24 * scale,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4 * scale),
        Text(
          label,
          style: TextStyle(
            fontSize: 13 * scale,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildTab(String title, double scale) {
    final isSelected = _selectedTab == title;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = title),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 4 * scale),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.grey : Colors.transparent,
          borderRadius: BorderRadius.circular(11 * scale),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20 * scale,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildCourseCard(String name, IconData icon, Color color, int progress, int lessons, double scale) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CourseDetailScreen(
              courseName: name,
              icon: icon,
              color: color,
              progress: progress,
              lessons: lessons,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20 * scale),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(16 * scale),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60 * scale,
              height: 60 * scale,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(15 * scale),
              ),
              child: Icon(
                icon,
                size: 32 * scale,
                color: color,
              ),
            ),
            SizedBox(height: 12 * scale),
            Text(
              name,
              style: TextStyle(
                fontSize: 14 * scale,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
