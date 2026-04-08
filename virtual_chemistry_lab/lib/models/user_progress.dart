import 'package:flutter/material.dart';

/// User Progress Model
class UserProgress {
  final String userId;
  final int totalPoints;
  final int completedLessons;
  final int totalLessons;
  final int currentStreak;
  final DateTime? lastActiveDate;
  final Map<String, bool> achievements;
  final Map<String, int> courseProgress; // courseId -> completed lessons
  final Map<String, int> labProgress; // labId -> completed count
  final Map<String, int> gameProgress; // gameId -> score

  UserProgress({
    required this.userId,
    this.totalPoints = 0,
    this.completedLessons = 0,
    this.totalLessons = 50, // Total lessons in app
    this.currentStreak = 0,
    this.lastActiveDate,
    Map<String, bool>? achievements,
    Map<String, int>? courseProgress,
    Map<String, int>? labProgress,
    Map<String, int>? gameProgress,
  })  : achievements = achievements ?? {},
        courseProgress = courseProgress ?? {},
        labProgress = labProgress ?? {},
        gameProgress = gameProgress ?? {};

  double get progressPercentage => totalLessons > 0 ? (completedLessons / totalLessons * 100) : 0;

  int get completedAchievements => achievements.values.where((v) => v).length;

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      userId: json['userId'] ?? '',
      totalPoints: json['totalPoints'] ?? 0,
      completedLessons: json['completedLessons'] ?? 0,
      totalLessons: json['totalLessons'] ?? 50,
      currentStreak: json['currentStreak'] ?? 0,
      lastActiveDate: json['lastActiveDate'] != null 
          ? DateTime.parse(json['lastActiveDate']) 
          : null,
      achievements: Map<String, bool>.from(json['achievements'] ?? {}),
      courseProgress: Map<String, int>.from(json['courseProgress'] ?? {}),
      labProgress: Map<String, int>.from(json['labProgress'] ?? {}),
      gameProgress: Map<String, int>.from(json['gameProgress'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'totalPoints': totalPoints,
      'completedLessons': completedLessons,
      'totalLessons': totalLessons,
      'currentStreak': currentStreak,
      'lastActiveDate': lastActiveDate?.toIso8601String(),
      'achievements': achievements,
      'courseProgress': courseProgress,
      'labProgress': labProgress,
      'gameProgress': gameProgress,
    };
  }

  UserProgress copyWith({
    int? totalPoints,
    int? completedLessons,
    int? currentStreak,
    DateTime? lastActiveDate,
    Map<String, bool>? achievements,
    Map<String, int>? courseProgress,
    Map<String, int>? labProgress,
    Map<String, int>? gameProgress,
  }) {
    return UserProgress(
      userId: userId,
      totalPoints: totalPoints ?? this.totalPoints,
      completedLessons: completedLessons ?? this.completedLessons,
      totalLessons: totalLessons,
      currentStreak: currentStreak ?? this.currentStreak,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
      achievements: achievements ?? this.achievements,
      courseProgress: courseProgress ?? this.courseProgress,
      labProgress: labProgress ?? this.labProgress,
      gameProgress: gameProgress ?? this.gameProgress,
    );
  }
}

/// Achievement definitions
class Achievement {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final int requiredPoints;
  final int requiredLessons;
  final int requiredStreak;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    this.requiredPoints = 0,
    this.requiredLessons = 0,
    this.requiredStreak = 0,
  });
}

/// List of all achievements
final List<Achievement> allAchievements = [
  Achievement(
    id: 'first_steps',
    title: 'Bước Đầu Tiên',
    description: 'Hoàn thành bài học đầu tiên',
    icon: Icons.star,
    requiredLessons: 1,
  ),
  Achievement(
    id: 'beginner',
    title: 'Người Mới Bắt Đầu',
    description: 'Đạt 100 điểm',
    icon: Icons.emoji_events,
    requiredPoints: 100,
  ),
  Achievement(
    id: 'dedicated',
    title: 'Kiên Trì',
    description: 'Streak 7 ngày liên tiếp',
    icon: Icons.local_fire_department,
    requiredStreak: 7,
  ),
  Achievement(
    id: 'intermediate',
    title: 'Trung Cấp',
    description: 'Hoàn thành 10 bài học',
    icon: Icons.school,
    requiredLessons: 10,
  ),
  Achievement(
    id: 'point_master',
    title: 'Bậc Thầy Điểm Số',
    description: 'Đạt 500 điểm',
    icon: Icons.stars,
    requiredPoints: 500,
  ),
  Achievement(
    id: 'streak_master',
    title: 'Bậc Thầy Streak',
    description: 'Streak 30 ngày',
    icon: Icons.whatshot,
    requiredStreak: 30,
  ),
  Achievement(
    id: 'advanced',
    title: 'Nâng Cao',
    description: 'Hoàn thành 25 bài học',
    icon: Icons.workspace_premium,
    requiredLessons: 25,
  ),
  Achievement(
    id: 'expert',
    title: 'Chuyên Gia',
    description: 'Đạt 1000 điểm',
    icon: Icons.military_tech,
    requiredPoints: 1000,
  ),
  Achievement(
    id: 'master',
    title: 'Bậc Thầy',
    description: 'Hoàn thành 40 bài học',
    icon: Icons.diamond,
    requiredLessons: 40,
  ),
  Achievement(
    id: 'legend',
    title: 'Huyền Thoại',
    description: 'Hoàn thành tất cả 50 bài học',
    icon: Icons.auto_awesome,
    requiredLessons: 50,
  ),
];
