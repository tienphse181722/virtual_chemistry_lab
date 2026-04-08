import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';
import 'package:virtual_chemistry_lab/providers/auth_provider.dart';
import 'package:virtual_chemistry_lab/services/leaderboard_service.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  final LeaderboardService _leaderboardService = LeaderboardService();
  List<Map<String, dynamic>> _leaderboard = [];
  Map<String, dynamic> _userRank = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLeaderboard();
  }

  Future<void> _loadLeaderboard() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.user == null) return;

    setState(() => _isLoading = true);
    try {
      final results = await Future.wait([
        _leaderboardService.getTopUsers(limit: 100), // Get top 100
        _leaderboardService.getUserRank(authProvider.user!.uid),
      ]);
      setState(() {
        _leaderboard = results[0] as List<Map<String, dynamic>>;
        _userRank = results[1] as Map<String, dynamic>;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading leaderboard: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaleX = size.width / 440;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF8B5CF6),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Bảng Xếp Hạng',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20 * scaleX,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xFF8B5CF6)))
          : Column(
              children: [
                // User's rank card - Fixed at top
                Container(
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
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF8B5CF6).withOpacity(0.3),
                        blurRadius: 15,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Consumer<AuthProvider>(
                    builder: (context, authProvider, _) {
                      final rank = _userRank['rank'] ?? 0;
                      final totalUsers = _userRank['totalUsers'] ?? 0;
                      final userPoints = _userRank['userPoints'] ?? 0;

                      return Row(
                        children: [
                          Container(
                            width: 70 * scaleX,
                            height: 70 * scaleX,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                '#$rank',
                                style: TextStyle(
                                  fontSize: 24 * scaleX,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF8B5CF6),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16 * scaleX),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hạng của bạn',
                                  style: TextStyle(
                                    fontSize: 14 * scaleX,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                                SizedBox(height: 4 * scaleX),
                                Text(
                                  authProvider.user?.displayName ?? 'User',
                                  style: TextStyle(
                                    fontSize: 18 * scaleX,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4 * scaleX),
                                Text(
                                  'Trong $totalUsers người dùng',
                                  style: TextStyle(
                                    fontSize: 12 * scaleX,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 24 * scaleX),
                              SizedBox(height: 4 * scaleX),
                              Text(
                                '$userPoints',
                                style: TextStyle(
                                  fontSize: 24 * scaleX,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'điểm',
                                style: TextStyle(
                                  fontSize: 12 * scaleX,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),

                // Leaderboard list
                Expanded(
                  child: _leaderboard.isEmpty
                      ? Center(
                          child: Text(
                            'Chưa có dữ liệu',
                            style: TextStyle(
                              fontSize: 16 * scaleX,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.all(16 * scaleX),
                          itemCount: _leaderboard.length,
                          itemBuilder: (context, index) {
                            final user = _leaderboard[index];
                            final rank = user['rank'];
                            final isTop3 = rank <= 3;
                            final isCurrentUser = user['userId'] == Provider.of<AuthProvider>(context, listen: false).user?.uid;
                            
                            Color rankColor = Color(0xFF8B5CF6);
                            if (rank == 1) rankColor = Color(0xFFFFD700); // Gold
                            if (rank == 2) rankColor = Color(0xFFC0C0C0); // Silver
                            if (rank == 3) rankColor = Color(0xFFCD7F32); // Bronze

                            return Container(
                              margin: EdgeInsets.only(bottom: 12 * scaleX),
                              padding: EdgeInsets.all(16 * scaleX),
                              decoration: BoxDecoration(
                                color: isCurrentUser 
                                    ? Color(0xFF8B5CF6).withOpacity(0.1)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(16 * scaleX),
                                border: Border.all(
                                  color: isCurrentUser 
                                      ? Color(0xFF8B5CF6)
                                      : isTop3 
                                          ? rankColor.withOpacity(0.3)
                                          : Colors.grey.shade200,
                                  width: isCurrentUser ? 2 : 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  // Rank badge
                                  Container(
                                    width: 50 * scaleX,
                                    height: 50 * scaleX,
                                    decoration: BoxDecoration(
                                      color: isTop3 ? rankColor : Color(0xFF8B5CF6).withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '#$rank',
                                        style: TextStyle(
                                          fontSize: 16 * scaleX,
                                          fontWeight: FontWeight.bold,
                                          color: isTop3 ? Colors.white : Color(0xFF8B5CF6),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16 * scaleX),
                                  
                                  // User info
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                user['displayName'] ?? 'User',
                                                style: TextStyle(
                                                  fontSize: 16 * scaleX,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.textPrimary,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            if (isCurrentUser)
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8 * scaleX,
                                                  vertical: 4 * scaleX,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF8B5CF6),
                                                  borderRadius: BorderRadius.circular(8 * scaleX),
                                                ),
                                                child: Text(
                                                  'Bạn',
                                                  style: TextStyle(
                                                    fontSize: 10 * scaleX,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        SizedBox(height: 6 * scaleX),
                                        Row(
                                          children: [
                                            Icon(Icons.school, size: 14 * scaleX, color: Colors.grey),
                                            SizedBox(width: 4 * scaleX),
                                            Text(
                                              '${user['completedLessons']} bài học',
                                              style: TextStyle(
                                                fontSize: 12 * scaleX,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(width: 12 * scaleX),
                                            Icon(Icons.local_fire_department, size: 14 * scaleX, color: Colors.orange),
                                            SizedBox(width: 4 * scaleX),
                                            Text(
                                              'Streak ${user['currentStreak']}',
                                              style: TextStyle(
                                                fontSize: 12 * scaleX,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  // Points
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Icon(Icons.star, color: Colors.amber, size: 20 * scaleX),
                                      SizedBox(height: 4 * scaleX),
                                      Text(
                                        '${user['totalPoints']}',
                                        style: TextStyle(
                                          fontSize: 20 * scaleX,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF8B5CF6),
                                        ),
                                      ),
                                      Text(
                                        'điểm',
                                        style: TextStyle(
                                          fontSize: 11 * scaleX,
                                          color: Colors.grey,
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
              ],
            ),
    );
  }
}
