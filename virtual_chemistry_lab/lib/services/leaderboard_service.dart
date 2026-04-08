import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Lấy top người dùng theo điểm
  Future<List<Map<String, dynamic>>> getTopUsers({int limit = 20}) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .orderBy('totalPoints', descending: true)
          .limit(limit)
          .get();

      List<Map<String, dynamic>> leaderboard = [];
      int rank = 1;
      
      for (var doc in snapshot.docs) {
        final data = doc.data();
        leaderboard.add({
          'rank': rank++,
          'userId': doc.id,
          'displayName': data['displayName'] ?? 'User',
          'email': data['email'] ?? '',
          'totalPoints': data['totalPoints'] ?? 0,
          'completedLessons': data['completedLessons'] ?? 0,
          'currentStreak': data['currentStreak'] ?? 0,
          'achievements': data['achievements'] ?? {},
        });
      }
      
      return leaderboard;
    } catch (e) {
      print('Error getting leaderboard: $e');
      return [];
    }
  }

  /// Lấy thứ hạng của người dùng
  Future<Map<String, dynamic>> getUserRank(String userId) async {
    try {
      // Get user's points
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (!userDoc.exists) {
        return {'rank': 0, 'totalUsers': 0, 'userPoints': 0};
      }
      
      final userPoints = userDoc.data()?['totalPoints'] ?? 0;
      
      // Count users with more points
      final higherRankCount = await _firestore
          .collection('users')
          .where('totalPoints', isGreaterThan: userPoints)
          .count()
          .get();
      
      // Count total users
      final totalUsersCount = await _firestore
          .collection('users')
          .count()
          .get();
      
      final rank = (higherRankCount.count ?? 0) + 1;
      final totalUsers = totalUsersCount.count ?? 0;
      
      return {
        'rank': rank,
        'totalUsers': totalUsers,
        'userPoints': userPoints,
      };
    } catch (e) {
      print('Error getting user rank: $e');
      return {'rank': 0, 'totalUsers': 0, 'userPoints': 0};
    }
  }

  /// Stream leaderboard real-time
  Stream<List<Map<String, dynamic>>> streamLeaderboard({int limit = 20}) {
    return _firestore
        .collection('users')
        .orderBy('totalPoints', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) {
      List<Map<String, dynamic>> leaderboard = [];
      int rank = 1;
      
      for (var doc in snapshot.docs) {
        final data = doc.data();
        leaderboard.add({
          'rank': rank++,
          'userId': doc.id,
          'displayName': data['displayName'] ?? 'User',
          'email': data['email'] ?? '',
          'totalPoints': data['totalPoints'] ?? 0,
          'completedLessons': data['completedLessons'] ?? 0,
          'currentStreak': data['currentStreak'] ?? 0,
          'achievements': data['achievements'] ?? {},
        });
      }
      
      return leaderboard;
    });
  }
}
