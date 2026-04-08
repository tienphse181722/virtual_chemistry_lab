import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';
import 'package:virtual_chemistry_lab/providers/auth_provider.dart';
import 'package:virtual_chemistry_lab/providers/lab_provider.dart';
import 'package:virtual_chemistry_lab/providers/progress_provider.dart';
import 'package:virtual_chemistry_lab/screens/profile/leaderboard_screen.dart';
import 'package:virtual_chemistry_lab/screens/profile/notifications_screen.dart';
import 'package:virtual_chemistry_lab/screens/profile/about_screen.dart';
import 'package:virtual_chemistry_lab/screens/auth/login_screen.dart';

/// SCR-014: User Profile
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    final authProvider = context.read<AuthProvider>();
    if (authProvider.user != null) {
      Future.microtask(() {
        context.read<LabProvider>().loadUserExperiments(authProvider.user!.uid);
      });
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
        child: Consumer2<AuthProvider, LabProvider>(
          builder: (context, authProvider, labProvider, child) {
            final user = authProvider.user;
            if (user == null) {
              return const Center(
                child: Text('Chưa đăng nhập'),
              );
            }

            return ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                overscroll: false,
                physics: const ClampingScrollPhysics(),
              ),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header with gradient background
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primary.withOpacity(0.8),
                            AppColors.primary,
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 20 * scaleX),
                          // PROFILE title
                          Text(
                            'PROFILE',
                            style: TextStyle(
                              fontSize: 24 * scaleX,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 30 * scaleX),
                          // User avatar
                          Container(
                            width: 100 * scaleX,
                            height: 100 * scaleX,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 15,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                user.displayName?.substring(0, 1).toUpperCase() ?? 'U',
                                style: TextStyle(
                                  fontSize: 40 * scaleX,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16 * scaleX),
                          Text(
                            user.displayName ?? 'User',
                            style: TextStyle(
                              fontSize: 24 * scaleX,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8 * scaleX),
                          Text(
                            user.email ?? '',
                            style: TextStyle(
                              fontSize: 14 * scaleX,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          SizedBox(height: 30 * scaleX),
                        ],
                      ),
                    ),

                    // Content
                    Padding(
                      padding: EdgeInsets.all(20 * scaleX),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Stats cards - 4 columns
                          Consumer<ProgressProvider>(
                            builder: (context, progressProvider, _) {
                              final progress = progressProvider.progress;
                              final totalPoints = progress?.totalPoints ?? 0;
                              final completedCourses = progress?.courseProgress.length ?? 0;
                              final currentStreak = progress?.currentStreak ?? 0;
                              
                              return Row(
                                children: [
                                  Expanded(
                                    child: _buildStatCard(
                                      '$totalPoints',
                                      'Điểm',
                                      Icons.star,
                                      Color(0xFFFBBF24),
                                      scaleX,
                                    ),
                                  ),
                                  SizedBox(width: 10 * scaleX),
                                  Expanded(
                                    child: _buildStatCard(
                                      '${labProvider.experiments.length}',
                                      'Thí nghiệm',
                                      Icons.science,
                                      Colors.blue,
                                      scaleX,
                                    ),
                                  ),
                                  SizedBox(width: 10 * scaleX),
                                  Expanded(
                                    child: _buildStatCard(
                                      '$completedCourses/6',
                                      'Hoàn thành',
                                      Icons.check_circle,
                                      Colors.green,
                                      scaleX,
                                    ),
                                  ),
                                  SizedBox(width: 10 * scaleX),
                                  Expanded(
                                    child: _buildStatCard(
                                      '$currentStreak',
                                      'Streak',
                                      Icons.local_fire_department,
                                      Colors.orange,
                                      scaleX,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),

                          SizedBox(height: 20 * scaleX),

                          // Leaderboard card - NEW
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LeaderboardScreen(),
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
                                    Color(0xFF8B5CF6),
                                    Color(0xFF6366F1),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20 * scaleX),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF8B5CF6).withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: Offset(0, 8),
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
                                    child: Icon(
                                      Icons.emoji_events,
                                      color: Colors.white,
                                      size: 32 * scaleX,
                                    ),
                                  ),
                                  SizedBox(width: 16 * scaleX),
                                  Expanded(
                                    child: Text(
                                      'Bảng Xếp Hạng',
                                      style: TextStyle(
                                        fontSize: 18 * scaleX,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 20 * scaleX,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 20 * scaleX),

                          // Achievements section
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Thành Tích',
                              style: TextStyle(
                                fontSize: 20 * scaleX,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          SizedBox(height: 16 * scaleX),

                          // Achievement badges grid
                          Consumer<ProgressProvider>(
                            builder: (context, progressProvider, _) {
                              final progress = progressProvider.progress;
                              
                              // Helper function to check if achievement is unlocked
                              bool isUnlocked(String achievementId) {
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
                              
                              return GridView.count(
                                crossAxisCount: 5,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                mainAxisSpacing: 12 * scaleX,
                                crossAxisSpacing: 8 * scaleX,
                                children: [
                                  _buildAchievementBadge(Icons.waving_hand, 'Người mới', Color(0xFF3B82F6), isUnlocked('first_login'), scaleX),
                                  _buildAchievementBadge(Icons.local_fire_department, 'Streak 7', Color(0xFFF97316), isUnlocked('streak_7'), scaleX),
                                  _buildAchievementBadge(Icons.star, '100 điểm', Color(0xFFFBBF24), isUnlocked('points_100'), scaleX),
                                  _buildAchievementBadge(Icons.stars, '500 điểm', Color(0xFFF59E0B), isUnlocked('points_500'), scaleX),
                                  _buildAchievementBadge(Icons.science, 'Chuyên gia TN', Color(0xFF10B981), isUnlocked('lab_master'), scaleX),
                                  _buildAchievementBadge(Icons.emoji_events, 'Vô địch', Color(0xFF8B5CF6), isUnlocked('game_champion'), scaleX),
                                  _buildAchievementBadge(Icons.school, 'Học giả', Color(0xFF06B6D4), isUnlocked('scholar'), scaleX),
                                  _buildAchievementBadge(Icons.workspace_premium, 'Chuyên gia', Color(0xFFEC4899), isUnlocked('expert'), scaleX),
                                  _buildAchievementBadge(Icons.military_tech, 'Bậc thầy', Color(0xFF6366F1), isUnlocked('master'), scaleX),
                                  _buildAchievementBadge(Icons.diamond, 'Huyền thoại', Color(0xFF14B8A6), isUnlocked('legend'), scaleX),
                                ],
                              );
                            },
                          ),

                          SizedBox(height: 24 * scaleX),

                          // Settings section
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Cài đặt',
                              style: TextStyle(
                                fontSize: 20 * scaleX,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          SizedBox(height: 16 * scaleX),

                          // Settings grid - 2 columns
                          Row(
                            children: [
                              Expanded(
                                child: _buildSettingCard(
                                  Icons.notifications_active,
                                  'Thông báo',
                                  'Cài đặt thông báo',
                                  Color(0xFF3B82F6),
                                  scaleX,
                                  () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: 12 * scaleX),
                              Expanded(
                                child: _buildSettingCard(
                                  Icons.info_outline,
                                  'Về ứng dụng',
                                  'Thông tin app',
                                  Color(0xFF8B5CF6),
                                  scaleX,
                                  () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => const AboutScreen()),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 24 * scaleX),

                          // Logout button
                          Builder(
                            builder: (btnContext) => SizedBox(
                              width: double.infinity,
                              height: 50 * scaleX,
                              child: ElevatedButton(
                                onPressed: () async {
                                  // Show confirmation dialog
                                  final shouldLogout = await showDialog<bool>(
                                    context: btnContext,
                                    builder: (dialogContext) => AlertDialog(
                                      title: Text('Đăng xuất'),
                                      content: Text('Bạn có chắc chắn muốn đăng xuất?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(dialogContext, false),
                                          child: Text('Hủy'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pop(dialogContext, true),
                                          child: Text(
                                            'Đăng xuất',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );

                                  if (shouldLogout == true) {
                                    // Sign out
                                    await authProvider.signOut();
                                    
                                    // Navigate to login screen and remove all previous routes
                                    if (btnContext.mounted) {
                                      Navigator.of(btnContext, rootNavigator: true).pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                                        (route) => false,
                                      );
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12 * scaleX),
                                  ),
                                ),
                                child: Text(
                                  'Đăng xuất',
                                  style: TextStyle(
                                    fontSize: 16 * scaleX,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 20 * scaleX),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon, Color color, double scale) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16 * scale, horizontal: 8 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15 * scale),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24 * scale),
          SizedBox(height: 6 * scale),
          Text(
            value,
            style: TextStyle(
              fontSize: 18 * scale,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 2 * scale),
          Text(
            label,
            style: TextStyle(
              fontSize: 10 * scale,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementBadge(IconData icon, String label, Color color, bool isUnlocked, double scale) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50 * scale,
          height: 50 * scale,
          decoration: BoxDecoration(
            color: isUnlocked ? color.withOpacity(0.15) : Colors.grey.shade200,
            shape: BoxShape.circle,
            border: Border.all(
              color: isUnlocked ? color : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Icon(
            icon,
            color: isUnlocked ? color : Colors.grey.shade400,
            size: 24 * scale,
          ),
        ),
        SizedBox(height: 4 * scale),
        Text(
          label,
          style: TextStyle(
            fontSize: 8 * scale,
            color: isUnlocked ? AppColors.textPrimary : AppColors.textSecondary,
            fontWeight: isUnlocked ? FontWeight.w600 : FontWeight.normal,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildSettingItem(IconData icon, String title, double scale, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12 * scale),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 40 * scale,
              height: 40 * scale,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10 * scale),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 22 * scale,
              ),
            ),
            SizedBox(width: 12 * scale),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16 * scale,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16 * scale,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingCard(
    IconData icon,
    String title,
    String subtitle,
    Color color,
    double scale,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20 * scale),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.8),
              color,
            ],
          ),
          borderRadius: BorderRadius.circular(20 * scale),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50 * scale,
              height: 50 * scale,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15 * scale),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 28 * scale,
              ),
            ),
            SizedBox(height: 16 * scale),
            Text(
              title,
              style: TextStyle(
                fontSize: 16 * scale,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4 * scale),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12 * scale,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            SizedBox(height: 12 * scale),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 20 * scale,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
