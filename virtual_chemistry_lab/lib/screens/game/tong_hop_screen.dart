import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';
import 'package:virtual_chemistry_lab/data/game_data.dart';
import 'package:virtual_chemistry_lab/providers/auth_provider.dart';
import 'package:virtual_chemistry_lab/providers/progress_provider.dart';

class TongHopScreen extends StatefulWidget {
  const TongHopScreen({super.key});

  @override
  State<TongHopScreen> createState() => _TongHopScreenState();
}

class _TongHopScreenState extends State<TongHopScreen> {
  int _currentLevel = 0;
  int _currentQuestion = 0;
  int _score = 0;
  bool _answered = false;
  int? _selectedAnswer;

  @override
  void initState() {
    super.initState();
  }

  void _answerQuestion(int selected) {
    if (_answered) return;
    
    final level = GameData.tongHopLevels[_currentLevel];
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
        _showLevelCompleteDialog();
      }
    });
  }

  void _showLevelCompleteDialog() async {
    // Save progress to Firebase
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final progressProvider = Provider.of<ProgressProvider>(context, listen: false);
    
    if (authProvider.user != null) {
      await progressProvider.completeGame(
        authProvider.user!.uid,
        'tong_hop_level_${_currentLevel + 1}',
        _score,
      );
    }
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Hoàn thành Level!'),
        content: Text('Điểm: $_score\nBạn đã hoàn thành level ${_currentLevel + 1}!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Về trang chủ'),
          ),
          if (_currentLevel < GameData.tongHopLevels.length - 1)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _currentLevel++;
                  _currentQuestion = 0;
                  _answered = false;
                  _selectedAnswer = null;
                });
              },
              child: const Text('Level tiếp theo'),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaleX = size.width / 440;
    final level = GameData.tongHopLevels[_currentLevel];
    final questions = level['questions'] as List;
    final question = questions[_currentQuestion];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Kiến Thức Tổng Hợp'),
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
                    colors: [Colors.blue.shade400, Colors.blue.shade600],
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
              // Progress and Score
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
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20 * scaleX),
                    ),
                    child: Text(
                      'Điểm: $_score',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14 * scaleX,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
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
                              color: isSelected ? Colors.blue : Colors.grey.shade300,
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
              // Explanation (if answered and has explanation)
              if (_answered && question.containsKey('explanation'))
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12 * scaleX),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12 * scaleX),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Giải thích:',
                        style: TextStyle(
                          fontSize: 14 * scaleX,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 4 * scaleX),
                      Text(
                        question['explanation'] as String,
                        style: TextStyle(
                          fontSize: 13 * scaleX,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
