import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtual_chemistry_lab/models/user_progress.dart';

class ProgressService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get user progress
  Future<UserProgress> getUserProgress(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      
      if (doc.exists) {
        final data = doc.data()!;
        // Extract progress data from user document
        return UserProgress(
          userId: userId,
          totalPoints: data['totalPoints'] ?? 0,
          completedLessons: data['completedLessons'] ?? 0,
          totalLessons: data['totalLessons'] ?? 50,
          currentStreak: data['currentStreak'] ?? 0,
          lastActiveDate: data['lastActiveDate'] != null 
              ? DateTime.parse(data['lastActiveDate']) 
              : null,
          achievements: Map<String, bool>.from(data['achievements'] ?? {}),
          courseProgress: Map<String, int>.from(data['courseProgress'] ?? {}),
          labProgress: Map<String, int>.from(data['labProgress'] ?? {}),
          gameProgress: Map<String, int>.from(data['gameProgress'] ?? {}),
        );
      } else {
        // Return default progress for new user
        return UserProgress(userId: userId);
      }
    } catch (e) {
      print('Error getting user progress: $e');
      return UserProgress(userId: userId);
    }
  }

  /// Update user progress
  Future<void> updateProgress(UserProgress progress) async {
    try {
      await _firestore.collection('users').doc(progress.userId).update({
        'totalPoints': progress.totalPoints,
        'completedLessons': progress.completedLessons,
        'totalLessons': progress.totalLessons,
        'currentStreak': progress.currentStreak,
        'lastActiveDate': progress.lastActiveDate?.toIso8601String(),
        'achievements': progress.achievements,
        'courseProgress': progress.courseProgress,
        'labProgress': progress.labProgress,
        'gameProgress': progress.gameProgress,
      });
    } catch (e) {
      print('Error updating progress: $e');
    }
  }

  /// Add points
  Future<UserProgress> addPoints(String userId, int points) async {
    final progress = await getUserProgress(userId);
    final updated = progress.copyWith(
      totalPoints: progress.totalPoints + points,
    );
    await updateProgress(updated);
    return updated;
  }

  /// Complete lesson
  Future<UserProgress> completeLesson(String userId, String courseId) async {
    final progress = await getUserProgress(userId);
    final courseProgress = Map<String, int>.from(progress.courseProgress);
    courseProgress[courseId] = (courseProgress[courseId] ?? 0) + 1;
    
    final updated = progress.copyWith(
      completedLessons: progress.completedLessons + 1,
      courseProgress: courseProgress,
    );
    await updateProgress(updated);
    return updated;
  }

  /// Complete lab
  Future<UserProgress> completeLab(String userId, String labId, int points) async {
    final progress = await getUserProgress(userId);
    final labProgress = Map<String, int>.from(progress.labProgress);
    labProgress[labId] = (labProgress[labId] ?? 0) + 1;
    
    final updated = progress.copyWith(
      totalPoints: progress.totalPoints + points,
      labProgress: labProgress,
    );
    await updateProgress(updated);
    return updated;
  }

  /// Complete game
  Future<UserProgress> completeGame(String userId, String gameId, int score) async {
    final progress = await getUserProgress(userId);
    final gameProgress = Map<String, int>.from(progress.gameProgress);
    final currentScore = gameProgress[gameId] ?? 0;
    
    if (score > currentScore) {
      gameProgress[gameId] = score;
    }
    
    final updated = progress.copyWith(
      totalPoints: progress.totalPoints + score,
      gameProgress: gameProgress,
    );
    await updateProgress(updated);
    return updated;
  }

  /// Update streak
  Future<UserProgress> updateStreak(String userId) async {
    final progress = await getUserProgress(userId);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    int newStreak = progress.currentStreak;
    
    if (progress.lastActiveDate == null) {
      newStreak = 1;
    } else {
      final lastActive = DateTime(
        progress.lastActiveDate!.year,
        progress.lastActiveDate!.month,
        progress.lastActiveDate!.day,
      );
      
      final difference = today.difference(lastActive).inDays;
      
      if (difference == 0) {
        // Same day, no change
        return progress;
      } else if (difference == 1) {
        // Next day, increment streak
        newStreak = progress.currentStreak + 1;
      } else {
        // Streak broken, reset to 1
        newStreak = 1;
      }
    }
    
    final updated = progress.copyWith(
      currentStreak: newStreak,
      lastActiveDate: now,
    );
    await updateProgress(updated);
    return updated;
  }

  /// Check and unlock achievements
  Future<UserProgress> checkAchievements(String userId) async {
    final progress = await getUserProgress(userId);
    final achievements = Map<String, bool>.from(progress.achievements);
    bool updated = false;
    
    for (final achievement in allAchievements) {
      if (achievements[achievement.id] == true) continue;
      
      bool unlocked = false;
      
      if (achievement.requiredPoints > 0 && progress.totalPoints >= achievement.requiredPoints) {
        unlocked = true;
      }
      if (achievement.requiredLessons > 0 && progress.completedLessons >= achievement.requiredLessons) {
        unlocked = true;
      }
      if (achievement.requiredStreak > 0 && progress.currentStreak >= achievement.requiredStreak) {
        unlocked = true;
      }
      
      if (unlocked) {
        achievements[achievement.id] = true;
        updated = true;
      }
    }
    
    if (updated) {
      final newProgress = progress.copyWith(achievements: achievements);
      await updateProgress(newProgress);
      return newProgress;
    }
    
    return progress;
  }

  /// Stream user progress
  Stream<UserProgress> streamUserProgress(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((doc) {
      if (doc.exists) {
        final data = doc.data()!;
        return UserProgress(
          userId: userId,
          totalPoints: data['totalPoints'] ?? 0,
          completedLessons: data['completedLessons'] ?? 0,
          totalLessons: data['totalLessons'] ?? 50,
          currentStreak: data['currentStreak'] ?? 0,
          lastActiveDate: data['lastActiveDate'] != null 
              ? DateTime.parse(data['lastActiveDate']) 
              : null,
          achievements: Map<String, bool>.from(data['achievements'] ?? {}),
          courseProgress: Map<String, int>.from(data['courseProgress'] ?? {}),
          labProgress: Map<String, int>.from(data['labProgress'] ?? {}),
          gameProgress: Map<String, int>.from(data['gameProgress'] ?? {}),
        );
      }
      return UserProgress(userId: userId);
    });
  }
}
