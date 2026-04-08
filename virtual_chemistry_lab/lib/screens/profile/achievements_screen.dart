import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';
import 'package:virtual_chemistry_lab/providers/progress_provider.dart';

/// Achievements Screen - Display all 10 achievements
class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  // Define 10 achievements with unlock conditions
  static const List<Map<String, dynamic>> achievements = [
    {
      'id': 'first_login',
      'name': 'Người Mới',
      'description': 'Đăng nhập lần đầu tiên',
      'icon': Icons.waving_hand,
      'color': Color(0xFF3B82F6), // Blue
      'points': 0,
    },
    {
      'id': 'streak_7',
      'name': 'Streak 7 Ngày',
      'description': 'Học liên tục 7 ngày',
      'icon': Icons.local_fire_department,
      'color': Color(0xFFF97316), // Orange
      'points': 7,
    },
    {
      'id': 'points_100',
      'name': '100 Điểm',
      'description': 'Đạt 100 điểm tổng',
      'icon': Icons.star,
      'color': Color(0xFFFBBF24), // Amber
      'points': 100,
    },
    {
      'id': 'points_500',
      'name': '500 Điểm',
      'description': 'Đạt 500 điểm tổng',
      'icon': Icons.stars,
      'color': Color(0xFFF59E0B), // Yellow
      'points': 500,
    },
    {
      'id': 'lab_master',
      'name': 'Chuyên Gia Thí Nghiệm',
      'description': 'Hoàn thành 20 thí nghiệm',
      'icon': Icons.science,
      'color': Color(0xFF10B981), // Green
      'points': 20,
    },
    {
      'id': 'game_champion',
      'name': 'Nhà Vô Địch Game',
      'description': 'Hoàn thành 30 game',
      'icon': Icons.emoji_events,
      'color': Color(0xFF8B5CF6), // Purple
      'points': 30,
    },
    {
      'id': 'scholar',
      'name': 'Học Giả',
      'description': 'Hoàn thành 3 khóa học',
      'icon': Icons.school,
      'color': Color(0xFF06B6D4), // Cyan
      'points': 3,
    },
    {
      'id': 'expert',
      'name': 'Chuyên Gia',
      'description': 'Đạt 1000 điểm tổng',
      'icon': Icons.workspace_premium,
      'color': Color(0xFFEC4899), // Pink
      'points': 1000,
    },
    {
      'id': 'master',
      'name': 'Bậc Thầy',
      'description': 'Hoàn thành tất cả khóa học',
      'icon': Icons.military_tech,
      'color': Color(0xFF6366F1), // Indigo
      'points': 5,
    },
    {
      'id': 'legend',
      'name': 'Huyền Thoại',
      'description': 'Đạt 2000 điểm và streak 30 ngày',
      'icon': Icons.diamond,
      'color': Color(0xFF14B8A6), // Teal
      'points': 2000,
    },
  ];

  bool _isAchievementUnlocked(String achievementId, dynamic progress) {
    if (progress == null) return false;

    switch (achievementId) {
      case 'first_login':
        return true; // Always unlocked after first login
      case 'streak_7':
        return (progress.currentStreak ?? 0) >= 7;
      case 'points_100':
        return (progress.totalPoints ?? 0) >= 100;
      case 'points_500':
        return (progress.totalPoints ?? 0) >= 500;
      case 'lab_master':
        return (progress.labProgress.length) >= 20;
      case 'game_champion':
        return (progress.gameProgress.length) >= 30;
      case 'scholar':
        return (progress.courseProgress.length) >= 3;
      case 'expert':
        return (progress.totalPoints ?? 0) >= 1000;
      case 'master':
        return (progress.courseProgress.length) >= 5;
      case 'legend':
        return (progress.totalPoints ?? 0) >= 2000 && (progress.currentStreak ?? 0) >= 30;
      default:
        return false;
    }
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
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(20 * scaleX),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFF59E0B).withOpacity(0.8),
                    Color(0xFFD97706),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white, size: 24 * scaleX),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Text(
                          'Thành Tích Của Bạn',
                          style: TextStyle(
                            fontSize: 24 * scaleX,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 48 * scaleX), // Balance the back button
                    ],
                  ),
                  SizedBox(height: 20 * scaleX),
                  Consumer<ProgressProvider>(
                    builder: (context, progressProvider, _) {
                      final progress = progressProvider.progress;
                      final unlockedCount = achievements.where((a) => _isAchievementUnlocked(a['id'], progress)).length;
                      
                      return Container(
                        padding: EdgeInsets.all(20 * scaleX),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20 * scaleX),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildHeaderStat(
                              '$unlockedCount/10',
                              'Đã mở khóa',
                              Icons.lock_open,
                              scaleX,
                            ),
                            Container(
                              width: 1,
                              height: 40 * scaleX,
                              color: Colors.white.withOpacity(0.3),
                            ),
                            _buildHeaderStat(
                              '${progress?.totalPoints ?? 0}',
                              'Tổng điểm',
                              Icons.star,
                              scaleX,
                            ),
                            Container(
                              width: 1,
                              height: 40 * scaleX,
                              color: Colors.white.withOpacity(0.3),
                            ),
                            _buildHeaderStat(
                              '${progress?.currentStreak ?? 0}',
                              'Streak',
                              Icons.local_fire_department,
                              scaleX,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Achievements Grid
            Expanded(
              child: Consumer<ProgressProvider>(
                builder: (context, progressProvider, _) {
                  final progress = progressProvider.progress;
                  
                  return ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      overscroll: false,
                      physics: const ClampingScrollPhysics(),
                    ),
                    child: GridView.builder(
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.all(20 * scaleX),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16 * scaleX,
                        mainAxisSpacing: 16 * scaleX,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: achievements.length,
                      itemBuilder: (context, index) {
                        final achievement = achievements[index];
                        final isUnlocked = _isAchievementUnlocked(achievement['id'], progress);
                        
                        return _buildAchievementCard(
                          achievement['name'],
                          achievement['description'],
                          achievement['icon'],
                          achievement['color'],
                          isUnlocked,
                          scaleX,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderStat(String value, String label, IconData icon, double scale) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24 * scale),
        SizedBox(height: 8 * scale),
        Text(
          value,
          style: TextStyle(
            fontSize: 20 * scale,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4 * scale),
        Text(
          label,
          style: TextStyle(
            fontSize: 12 * scale,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementCard(
    String name,
    String description,
    IconData icon,
    Color color,
    bool isUnlocked,
    double scale,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(
          color: isUnlocked ? color.withOpacity(0.3) : Colors.grey.shade200,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: isUnlocked ? color.withOpacity(0.15) : Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background gradient for unlocked achievements
          if (isUnlocked)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color.withOpacity(0.05),
                      color.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18 * scale),
                ),
              ),
            ),
          
          // Content
          Padding(
            padding: EdgeInsets.all(16 * scale),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                Container(
                  width: 80 * scale,
                  height: 80 * scale,
                  decoration: BoxDecoration(
                    color: isUnlocked ? color.withOpacity(0.15) : Colors.grey.shade200,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isUnlocked ? color : Colors.grey.shade300,
                      width: 3,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: isUnlocked ? color : Colors.grey.shade400,
                    size: 40 * scale,
                  ),
                ),
                
                SizedBox(height: 12 * scale),
                
                // Name
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.bold,
                    color: isUnlocked ? AppColors.textPrimary : AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: 6 * scale),
                
                // Description
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11 * scale,
                    color: isUnlocked ? AppColors.textSecondary : Colors.grey.shade400,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: 8 * scale),
                
                // Status badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12 * scale, vertical: 4 * scale),
                  decoration: BoxDecoration(
                    color: isUnlocked ? color.withOpacity(0.15) : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12 * scale),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isUnlocked ? Icons.check_circle : Icons.lock,
                        size: 12 * scale,
                        color: isUnlocked ? color : Colors.grey.shade400,
                      ),
                      SizedBox(width: 4 * scale),
                      Text(
                        isUnlocked ? 'Đã mở' : 'Khóa',
                        style: TextStyle(
                          fontSize: 10 * scale,
                          fontWeight: FontWeight.w600,
                          color: isUnlocked ? color : Colors.grey.shade400,
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
}
