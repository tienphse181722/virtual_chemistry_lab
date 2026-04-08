import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';
import 'package:virtual_chemistry_lab/data/game_data.dart';
import 'package:virtual_chemistry_lab/providers/auth_provider.dart';
import 'package:virtual_chemistry_lab/providers/progress_provider.dart';
import 'package:virtual_chemistry_lab/services/user_data_service.dart';

class QuizNhanhScreen extends StatefulWidget {
  const QuizNhanhScreen({super.key});

  @override
  State<QuizNhanhScreen> createState() => _QuizNhanhScreenState();
}

class _QuizNhanhScreenState extends State<QuizNhanhScreen> {
  int _currentLevel = 0;
  int _currentQuestion = 0;
  int _score = 0;
  int _timeLeft = 0;
  Timer? _timer;
  bool _answered = false;
  int? _selectedAnswer;
  final UserDataService _userDataService = UserDataService();
  int _startTime = 0;

  @override
  void initState() {
    super.initState();
    _startLevel();
  }

  void _startLevel() {
    final level = GameData.quizNhanhLevels[_currentLevel];
    setState(() {
      _currentQuestion = 0;
      _timeLeft = level['timeLimit'] as int;
      _answered = false;
      _selectedAnswer = null;
      _startTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    });
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() => _timeLeft--);
      } else {
        _timer?.cancel();
        _showTimeUpDialog();
      }
    });
  }

  void _answerQuestion(int selected) {
    if (_answered) return;
    
    final level = GameData.quizNhanhLevels[_currentLevel];
    final questions = level['questions'] as List;
    final question = questions[_currentQuestion];
    final correct = question['correct'] as int;
    
    setState(() {
      _answered = true;
      _selectedAnswer = selected;
      if (selected == correct) {
        _score += question['points'] as int;
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (_currentQuestion < questions.length - 1) {
        setState(() {
          _currentQuestion++;
          _answered = false;
          _selectedAnswer = null;
        });
      } else {
        _timer?.cancel();
        _showLevelCompleteDialog();
      }
    });
  }

  void _showTimeUpDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Hết giờ!'),
        content: Text('Điểm của bạn: $_score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Về trang chủ'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _score = 0;
                _currentLevel = 0;
              });
              _startLevel();
            },
            child: const Text('Chơi lại'),
          ),
        ],
      ),
    );
  }

  void _showLevelCompleteDialog() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final progressProvider = Provider.of<ProgressProvider>(context, listen: false);
    
    if (authProvider.user != null) {
      final timeSpent = (DateTime.now().millisecondsSinceEpoch ~/ 1000) - _startTime;
      
      // Save to progress system
      await progressProvider.completeGame(
        authProvider.user!.uid,
        'quiz_nhanh_level_${_currentLevel + 1}',
        _score,
      );
      
      // Save detailed game result to Firebase
      await _userDataService.saveGameResult(
        userId: authProvider.user!.uid,
        gameType: 'quiz_nhanh',
        level: _currentLevel + 1,
        score: _score,
        timeSpent: timeSpent,
        completed: true,
      );
      
      // Log activity
      await _userDataService.logActivity(
        userId: authProvider.user!.uid,
        activityType: 'game',
        action: 'complete',
        itemId: 'quiz_nhanh_level_${_currentLevel + 1}',
        metadata: {'score': _score, 'timeSpent': timeSpent},
      );
    }
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Hoàn thành!'),
        content: Text('Điểm: $_score\nBạn đã hoàn thành level ${_currentLevel + 1}!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Về trang chủ'),
          ),
          if (_currentLevel < GameData.quizNhanhLevels.length - 1)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() => _currentLevel++);
                _startLevel();
              },
              child: const Text('Level tiếp theo'),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaleX = size.width / 440;
    final level = GameData.quizNhanhLevels[_currentLevel];
    final questions = level['questions'] as List;
    final question = questions[_currentQuestion];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Quiz Nhanh'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20 * scaleX),
          child: Column(
            children: [
              // Level Indicator
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12 * scaleX),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange.shade400, Colors.orange.shade600],
                  ),
                  borderRadius: BorderRadius.circular(12 * scaleX),
                ),
                child: Text(
                  'Level ${_currentLevel + 1}: ${level['name']}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16 * scaleX,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10 * scaleX),
              // Progress and Timer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Câu ${_currentQuestion + 1}/${questions.length}',
                    style: TextStyle(fontSize: 16 * scaleX, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12 * scaleX, vertical: 6 * scaleX),
                    decoration: BoxDecoration(
                      color: _timeLeft < 10 ? Colors.red : Colors.orange,
                      borderRadius: BorderRadius.circular(20 * scaleX),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.timer, color: Colors.white, size: 16 * scaleX),
                        SizedBox(width: 4 * scaleX),
                        Text(
                          '$_timeLeft s',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14 * scaleX,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10 * scaleX),
              // Score
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12 * scaleX),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12 * scaleX),
                ),
                child: Text(
                  'Điểm: $_score',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18 * scaleX,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),
              SizedBox(height: 30 * scaleX),
              // Question
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20 * scaleX),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16 * scaleX),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  question['question'] as String,
                  style: TextStyle(
                    fontSize: 18 * scaleX,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30 * scaleX),
              // Options
              Expanded(
                child: ListView.builder(
                  itemCount: (question['options'] as List).length,
                  itemBuilder: (context, index) {
                    final option = (question['options'] as List)[index];
                    final isSelected = _selectedAnswer == index;
                    final isCorrect = question['correct'] == index;
                    Color? bgColor;
                    
                    if (_answered) {
                      if (isCorrect) {
                        bgColor = Colors.green;
                      } else if (isSelected && !isCorrect) {
                        bgColor = Colors.red;
                      }
                    }

                    return Padding(
                      padding: EdgeInsets.only(bottom: 12 * scaleX),
                      child: InkWell(
                        onTap: () => _answerQuestion(index),
                        child: Container(
                          padding: EdgeInsets.all(16 * scaleX),
                          decoration: BoxDecoration(
                            color: bgColor ?? Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12 * scaleX),
                            border: Border.all(
                              color: isSelected ? Colors.orange : Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          child: Text(
                            option as String,
                            style: TextStyle(
                              fontSize: 16 * scaleX,
                              color: bgColor != null ? Colors.white : AppColors.textPrimary,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
