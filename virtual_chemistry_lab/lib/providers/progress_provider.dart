import 'package:flutter/material.dart';
import 'package:virtual_chemistry_lab/models/user_progress.dart';
import 'package:virtual_chemistry_lab/services/progress_service.dart';

class ProgressProvider with ChangeNotifier {
  final ProgressService _progressService = ProgressService();
  UserProgress? _progress;
  bool _isLoading = false;

  UserProgress? get progress => _progress;
  bool get isLoading => _isLoading;

  /// Load user progress
  Future<void> loadProgress(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _progress = await _progressService.getUserProgress(userId);
      // Update streak on load
      _progress = await _progressService.updateStreak(userId);
    } catch (e) {
      print('Error loading progress: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Add points
  Future<void> addPoints(String userId, int points) async {
    if (_progress == null) return;
    
    _progress = await _progressService.addPoints(userId, points);
    _progress = await _progressService.checkAchievements(userId);
    notifyListeners();
  }

  /// Complete lesson
  Future<void> completeLesson(String userId, String courseId, int points) async {
    if (_progress == null) return;
    
    _progress = await _progressService.completeLesson(userId, courseId);
    _progress = await _progressService.addPoints(userId, points);
    _progress = await _progressService.checkAchievements(userId);
    notifyListeners();
  }

  /// Complete lab
  Future<void> completeLab(String userId, String labId, int points) async {
    if (_progress == null) return;
    
    _progress = await _progressService.completeLab(userId, labId, points);
    _progress = await _progressService.checkAchievements(userId);
    notifyListeners();
  }

  /// Complete game
  Future<void> completeGame(String userId, String gameId, int score) async {
    if (_progress == null) return;
    
    _progress = await _progressService.completeGame(userId, gameId, score);
    _progress = await _progressService.checkAchievements(userId);
    notifyListeners();
  }

  /// Get course progress percentage
  double getCourseProgress(String courseId) {
    if (_progress == null) return 0;
    final completed = _progress!.courseProgress[courseId] ?? 0;
    // Assuming each course has 12 lessons
    return (completed / 12 * 100).clamp(0, 100);
  }

  /// Stream progress
  Stream<UserProgress> streamProgress(String userId) {
    return _progressService.streamUserProgress(userId);
  }
}
