import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';
import 'package:virtual_chemistry_lab/data/game_data.dart';
import 'package:virtual_chemistry_lab/providers/auth_provider.dart';
import 'package:virtual_chemistry_lab/providers/progress_provider.dart';

class GhepTuScreen extends StatefulWidget {
  const GhepTuScreen({super.key});

  @override
  State<GhepTuScreen> createState() => _GhepTuScreenState();
}

class _GhepTuScreenState extends State<GhepTuScreen> {
  int _currentLevel = 0;
  int _currentWord = 0;
  int _score = 0;
  List<String> _letters = [];
  List<String> _placedLetters = [];

  @override
  void initState() {
    super.initState();
    _startLevel();
  }

  void _startLevel() {
    final level = GameData.ghepTuLevels[_currentLevel];
    final words = level['words'] as List;
    final word = words[_currentWord];
    final targetWord = word['word'] as String;
    
    setState(() {
      _letters = targetWord.split('')..shuffle();
      _placedLetters = [];
    });
  }

  void _placeLetter(String letter) {
    setState(() {
      _placedLetters.add(letter);
      _letters.remove(letter);
    });
  }

  void _removeLetter(int index) {
    setState(() {
      _letters.add(_placedLetters[index]);
      _placedLetters.removeAt(index);
    });
  }

  void _checkAnswer() {
    final level = GameData.ghepTuLevels[_currentLevel];
    final words = level['words'] as List;
    final word = words[_currentWord];
    final correctWord = word['word'] as String;
    final userWord = _placedLetters.join('');
    
    if (userWord == correctWord) {
      final points = word['points'] as int;
      setState(() => _score += points);
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Chính xác!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Từ đúng: $correctWord'),
              Text('Gợi ý: ${word['hint']}'),
              Text('+$points điểm'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (_currentWord < words.length - 1) {
                  setState(() => _currentWord++);
                  _startLevel();
                } else {
                  _showLevelCompleteDialog();
                }
              },
              child: const Text('Tiếp tục'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Chưa đúng'),
          content: const Text('Hãy thử lại!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _showLevelCompleteDialog() async {
    // Save progress to Firebase
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final progressProvider = Provider.of<ProgressProvider>(context, listen: false);
    
    if (authProvider.user != null) {
      await progressProvider.completeGame(
        authProvider.user!.uid,
        'ghep_tu_level_${_currentLevel + 1}',
        _score,
      );
    }
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Hoàn thành Level!'),
        content: Text('Điểm: $_score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Về trang chủ'),
          ),
          if (_currentLevel < GameData.ghepTuLevels.length - 1)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _currentLevel++;
                  _currentWord = 0;
                });
                _startLevel();
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
    final level = GameData.ghepTuLevels[_currentLevel];
    final words = level['words'] as List;
    final word = words[_currentWord];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Ghép Từ Hóa Học'),
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
                    colors: [Colors.green.shade400, Colors.green.shade600],
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
              // Score and Progress
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Từ ${_currentWord + 1}/${words.length}',
                    style: TextStyle(fontSize: 16 * scaleX, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12 * scaleX, vertical: 6 * scaleX),
                    decoration: BoxDecoration(
                      color: Colors.green,
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
              SizedBox(height: 20 * scaleX),
              // Hint
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16 * scaleX),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12 * scaleX),
                ),
                child: Column(
                  children: [
                    Icon(Icons.lightbulb, color: Colors.green, size: 30 * scaleX),
                    SizedBox(height: 8 * scaleX),
                    Text(
                      'Gợi ý: ${word['hint']}',
                      style: TextStyle(
                        fontSize: 16 * scaleX,
                        color: Colors.green.shade700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30 * scaleX),
              // Placed Letters Area
              Container(
                width: double.infinity,
                height: 100 * scaleX,
                padding: EdgeInsets.all(16 * scaleX),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12 * scaleX),
                  border: Border.all(color: Colors.green, width: 2),
                ),
                child: _placedLetters.isEmpty
                    ? Center(
                        child: Text(
                          'Chọn chữ cái để ghép từ',
                          style: TextStyle(
                            fontSize: 14 * scaleX,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : Wrap(
                        spacing: 8 * scaleX,
                        runSpacing: 8 * scaleX,
                        children: _placedLetters.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => _removeLetter(entry.key),
                            child: _buildLetterChip(entry.value, scaleX, true),
                          );
                        }).toList(),
                      ),
              ),
              SizedBox(height: 20 * scaleX),
              // Check Button
              ElevatedButton(
                onPressed: _placedLetters.length == (word['word'] as String).length
                    ? _checkAnswer
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 40 * scaleX, vertical: 12 * scaleX),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12 * scaleX),
                  ),
                ),
                child: Text(
                  'Kiểm tra',
                  style: TextStyle(fontSize: 16 * scaleX, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30 * scaleX),
              // Available Letters
              Text(
                'Chữ cái:',
                style: TextStyle(
                  fontSize: 16 * scaleX,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 10 * scaleX),
              Expanded(
                child: Center(
                  child: Wrap(
                    spacing: 10 * scaleX,
                    runSpacing: 10 * scaleX,
                    alignment: WrapAlignment.center,
                    children: _letters.map((letter) {
                      return GestureDetector(
                        onTap: () => _placeLetter(letter),
                        child: _buildLetterChip(letter, scaleX, false),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLetterChip(String letter, double scale, bool placed) {
    return Container(
      width: 50 * scale,
      height: 50 * scale,
      decoration: BoxDecoration(
        color: placed ? Colors.green : Colors.green.shade100,
        borderRadius: BorderRadius.circular(12 * scale),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          letter,
          style: TextStyle(
            fontSize: 24 * scale,
            fontWeight: FontWeight.bold,
            color: placed ? Colors.white : Colors.green,
          ),
        ),
      ),
    );
  }
}
