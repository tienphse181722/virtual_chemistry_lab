import 'package:cloud_firestore/cloud_firestore.dart';

/// Service quản lý toàn bộ dữ liệu người dùng trên Firebase
class UserDataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ==================== GAME DATA ====================
  
  /// Lưu kết quả game
  Future<void> saveGameResult({
    required String userId,
    required String gameType, // 'quiz_nhanh', 'ghi_nho', 'xay_dung_phan_tu', 'ghep_tu', 'tong_hop'
    required int level,
    required int score,
    required int timeSpent, // seconds
    required bool completed,
  }) async {
    try {
      await _firestore.collection('game_results').add({
        'userId': userId,
        'gameType': gameType,
        'level': level,
        'score': score,
        'timeSpent': timeSpent,
        'completed': completed,
        'timestamp': FieldValue.serverTimestamp(),
      });
      
      // Update best score for this game+level
      final bestScoreDoc = _firestore
          .collection('users')
          .doc(userId)
          .collection('best_scores')
          .doc('${gameType}_level_$level');
      
      final bestScore = await bestScoreDoc.get();
      if (!bestScore.exists || (bestScore.data()?['score'] ?? 0) < score) {
        await bestScoreDoc.set({
          'gameType': gameType,
          'level': level,
          'score': score,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error saving game result: $e');
    }
  }

  /// Lấy lịch sử chơi game
  Future<List<Map<String, dynamic>>> getGameHistory(String userId, {String? gameType}) async {
    try {
      Query query = _firestore
          .collection('game_results')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .limit(50);
      
      if (gameType != null) {
        query = query.where('gameType', isEqualTo: gameType);
      }
      
      final snapshot = await query.get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print('Error getting game history: $e');
      return [];
    }
  }

  /// Lấy điểm cao nhất của từng game
  Future<Map<String, int>> getBestScores(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('best_scores')
          .get();
      
      Map<String, int> bestScores = {};
      for (var doc in snapshot.docs) {
        bestScores[doc.id] = doc.data()['score'] ?? 0;
      }
      return bestScores;
    } catch (e) {
      print('Error getting best scores: $e');
      return {};
    }
  }

  // ==================== LAB DATA ====================
  
  /// Lưu kết quả thí nghiệm
  Future<void> saveLabExperiment({
    required String userId,
    required String labType, // 'mix_chemicals', 'burn_chemical', 'electrolysis', 'quantitative_analysis', 'reaction_kinetics', 'balance_equation'
    required String experimentName,
    required Map<String, dynamic> inputs,
    required Map<String, dynamic> results,
    required bool successful,
  }) async {
    try {
      await _firestore.collection('lab_experiments').add({
        'userId': userId,
        'labType': labType,
        'experimentName': experimentName,
        'inputs': inputs,
        'results': results,
        'successful': successful,
        'timestamp': FieldValue.serverTimestamp(),
      });
      
      // Update lab statistics
      final labStatsDoc = _firestore
          .collection('users')
          .doc(userId)
          .collection('lab_stats')
          .doc(labType);
      
      await labStatsDoc.set({
        'totalExperiments': FieldValue.increment(1),
        'successfulExperiments': successful ? FieldValue.increment(1) : FieldValue.increment(0),
        'lastExperiment': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error saving lab experiment: $e');
    }
  }

  /// Lấy lịch sử thí nghiệm
  Future<List<Map<String, dynamic>>> getLabHistory(String userId, {String? labType}) async {
    try {
      Query query = _firestore
          .collection('lab_experiments')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .limit(50);
      
      if (labType != null) {
        query = query.where('labType', isEqualTo: labType);
      }
      
      final snapshot = await query.get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print('Error getting lab history: $e');
      return [];
    }
  }

  /// Lấy thống kê lab
  Future<Map<String, Map<String, dynamic>>> getLabStats(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('lab_stats')
          .get();
      
      Map<String, Map<String, dynamic>> stats = {};
      for (var doc in snapshot.docs) {
        stats[doc.id] = doc.data();
      }
      return stats;
    } catch (e) {
      print('Error getting lab stats: $e');
      return {};
    }
  }

  // ==================== COURSE DATA ====================
  
  /// Lưu tiến độ học bài
  Future<void> saveLessonProgress({
    required String userId,
    required String courseId,
    required String lessonId,
    required double progress, // 0.0 to 1.0
    required bool completed,
    int? timeSpent, // seconds
  }) async {
    try {
      final lessonDoc = _firestore
          .collection('users')
          .doc(userId)
          .collection('lesson_progress')
          .doc('${courseId}_$lessonId');
      
      await lessonDoc.set({
        'courseId': courseId,
        'lessonId': lessonId,
        'progress': progress,
        'completed': completed,
        'timeSpent': timeSpent ?? 0,
        'lastAccessed': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      
      // Update course progress
      await _updateCourseProgress(userId, courseId);
    } catch (e) {
      print('Error saving lesson progress: $e');
    }
  }

  /// Cập nhật tiến độ khóa học
  Future<void> _updateCourseProgress(String userId, String courseId) async {
    try {
      final lessonsSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('lesson_progress')
          .where('courseId', isEqualTo: courseId)
          .get();
      
      int totalLessons = lessonsSnapshot.docs.length;
      int completedLessons = lessonsSnapshot.docs.where((doc) => doc.data()['completed'] == true).length;
      
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('course_progress')
          .doc(courseId)
          .set({
        'courseId': courseId,
        'totalLessons': totalLessons,
        'completedLessons': completedLessons,
        'progress': totalLessons > 0 ? completedLessons / totalLessons : 0.0,
        'lastAccessed': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error updating course progress: $e');
    }
  }

  /// Lấy tiến độ khóa học
  Future<Map<String, dynamic>?> getCourseProgress(String userId, String courseId) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(userId)
          .collection('course_progress')
          .doc(courseId)
          .get();
      
      return doc.exists ? doc.data() : null;
    } catch (e) {
      print('Error getting course progress: $e');
      return null;
    }
  }

  /// Lấy tất cả tiến độ khóa học
  Future<Map<String, Map<String, dynamic>>> getAllCourseProgress(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('course_progress')
          .get();
      
      Map<String, Map<String, dynamic>> progress = {};
      for (var doc in snapshot.docs) {
        progress[doc.id] = doc.data();
      }
      return progress;
    } catch (e) {
      print('Error getting all course progress: $e');
      return {};
    }
  }

  // ==================== EXAM DATA ====================
  
  /// Lưu kết quả thi
  Future<void> saveExamResult({
    required String userId,
    required String examId,
    required String examTitle,
    required int totalQuestions,
    required int correctAnswers,
    required int score,
    required int timeSpent, // seconds
    required List<Map<String, dynamic>> answers,
  }) async {
    try {
      await _firestore.collection('exam_results').add({
        'userId': userId,
        'examId': examId,
        'examTitle': examTitle,
        'totalQuestions': totalQuestions,
        'correctAnswers': correctAnswers,
        'score': score,
        'timeSpent': timeSpent,
        'answers': answers,
        'timestamp': FieldValue.serverTimestamp(),
      });
      
      // Update best exam score
      final bestScoreDoc = _firestore
          .collection('users')
          .doc(userId)
          .collection('best_exam_scores')
          .doc(examId);
      
      final bestScore = await bestScoreDoc.get();
      if (!bestScore.exists || (bestScore.data()?['score'] ?? 0) < score) {
        await bestScoreDoc.set({
          'examId': examId,
          'examTitle': examTitle,
          'score': score,
          'correctAnswers': correctAnswers,
          'totalQuestions': totalQuestions,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error saving exam result: $e');
    }
  }

  /// Lấy lịch sử thi
  Future<List<Map<String, dynamic>>> getExamHistory(String userId, {String? examId}) async {
    try {
      Query query = _firestore
          .collection('exam_results')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .limit(50);
      
      if (examId != null) {
        query = query.where('examId', isEqualTo: examId);
      }
      
      final snapshot = await query.get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print('Error getting exam history: $e');
      return [];
    }
  }

  /// Lấy điểm thi cao nhất
  Future<Map<String, Map<String, dynamic>>> getBestExamScores(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('best_exam_scores')
          .get();
      
      Map<String, Map<String, dynamic>> bestScores = {};
      for (var doc in snapshot.docs) {
        bestScores[doc.id] = doc.data();
      }
      return bestScores;
    } catch (e) {
      print('Error getting best exam scores: $e');
      return {};
    }
  }

  // ==================== STATISTICS ====================
  
  /// Lấy tổng quan thống kê người dùng
  Future<Map<String, dynamic>> getUserStatistics(String userId) async {
    try {
      // Get all data in parallel
      final results = await Future.wait([
        getGameHistory(userId),
        getLabHistory(userId),
        getAllCourseProgress(userId),
        getExamHistory(userId),
        getBestScores(userId),
        getLabStats(userId),
      ]);
      
      final gameHistory = results[0] as List<Map<String, dynamic>>;
      final labHistory = results[1] as List<Map<String, dynamic>>;
      final courseProgress = results[2] as Map<String, Map<String, dynamic>>;
      final examHistory = results[3] as List<Map<String, dynamic>>;
      final bestScores = results[4] as Map<String, int>;
      final labStats = results[5] as Map<String, Map<String, dynamic>>;
      
      return {
        'totalGamesPlayed': gameHistory.length,
        'totalLabExperiments': labHistory.length,
        'totalCoursesStarted': courseProgress.length,
        'totalExamsTaken': examHistory.length,
        'bestGameScores': bestScores,
        'labStatistics': labStats,
        'courseProgress': courseProgress,
      };
    } catch (e) {
      print('Error getting user statistics: $e');
      return {};
    }
  }

  // ==================== ACTIVITY LOG ====================
  
  /// Lưu hoạt động người dùng
  Future<void> logActivity({
    required String userId,
    required String activityType, // 'game', 'lab', 'course', 'exam'
    required String action, // 'start', 'complete', 'view'
    required String itemId,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      await _firestore.collection('user_activities').add({
        'userId': userId,
        'activityType': activityType,
        'action': action,
        'itemId': itemId,
        'metadata': metadata ?? {},
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error logging activity: $e');
    }
  }

  /// Lấy hoạt động gần đây
  Future<List<Map<String, dynamic>>> getRecentActivities(String userId, {int limit = 20}) async {
    try {
      final snapshot = await _firestore
          .collection('user_activities')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .limit(limit)
          .get();
      
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print('Error getting recent activities: $e');
      return [];
    }
  }
}
