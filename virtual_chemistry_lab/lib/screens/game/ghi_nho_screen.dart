import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';
import 'package:virtual_chemistry_lab/data/game_data.dart';
import 'package:virtual_chemistry_lab/providers/auth_provider.dart';
import 'package:virtual_chemistry_lab/providers/progress_provider.dart';

class GhiNhoScreen extends StatefulWidget {
  const GhiNhoScreen({super.key});

  @override
  State<GhiNhoScreen> createState() => _GhiNhoScreenState();
}

class _GhiNhoScreenState extends State<GhiNhoScreen> {
  int _currentLevel = 0;
  int _score = 0;
  List<String> _cards = [];
  List<bool> _flipped = [];
  List<bool> _matched = [];
  int? _firstFlipped;
  int? _secondFlipped;
  bool _canFlip = true;

  @override
  void initState() {
    super.initState();
    _startLevel();
  }

  void _startLevel() {
    final level = GameData.ghiNhoLevels[_currentLevel];
    final pairs = level['pairs'] as List;
    
    // Create cards: formula and name for each pair
    List<String> cards = [];
    for (var pair in pairs) {
      cards.add('F:${pair['formula']}'); // F for formula
      cards.add('N:${pair['name']}'); // N for name
    }
    cards.shuffle();

    setState(() {
      _cards = cards;
      _flipped = List.filled(cards.length, false);
      _matched = List.filled(cards.length, false);
      _firstFlipped = null;
      _secondFlipped = null;
      _canFlip = true;
    });
  }

  void _flipCard(int index) {
    if (!_canFlip || _flipped[index] || _matched[index]) return;

    setState(() {
      _flipped[index] = true;
      
      if (_firstFlipped == null) {
        _firstFlipped = index;
      } else if (_secondFlipped == null) {
        _secondFlipped = index;
        _canFlip = false;
        _checkMatch();
      }
    });
  }

  void _checkMatch() {
    if (_firstFlipped == null || _secondFlipped == null) return;

    final card1 = _cards[_firstFlipped!];
    final card2 = _cards[_secondFlipped!];
    
    // Extract type and value
    final type1 = card1.split(':')[0];
    final value1 = card1.split(':')[1];
    final type2 = card2.split(':')[0];
    final value2 = card2.split(':')[1];

    // Check if they match (one formula, one name, same pair)
    bool isMatch = false;
    if (type1 != type2) {
      final level = GameData.ghiNhoLevels[_currentLevel];
      final pairs = level['pairs'] as List;
      
      for (var pair in pairs) {
        if ((value1 == pair['formula'] && value2 == pair['name']) ||
            (value1 == pair['name'] && value2 == pair['formula'])) {
          isMatch = true;
          break;
        }
      }
    }

    Timer(const Duration(milliseconds: 800), () {
      setState(() {
        if (isMatch) {
          _matched[_firstFlipped!] = true;
          _matched[_secondFlipped!] = true;
          _score += 10;
        } else {
          _flipped[_firstFlipped!] = false;
          _flipped[_secondFlipped!] = false;
        }
        
        _firstFlipped = null;
        _secondFlipped = null;
        _canFlip = true;

        // Check if all matched
        if (_matched.every((m) => m)) {
          _showLevelCompleteDialog();
        }
      });
    });
  }

  void _showLevelCompleteDialog() async {
    final level = GameData.ghiNhoLevels[_currentLevel];
    final points = level['points'] as int;
    
    // Save progress to Firebase
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final progressProvider = Provider.of<ProgressProvider>(context, listen: false);
    
    if (authProvider.user != null) {
      await progressProvider.completeGame(
        authProvider.user!.uid,
        'ghi_nho_level_${_currentLevel + 1}',
        _score + points,
      );
    }
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Hoàn thành!'),
        content: Text('Điểm: $_score\nThưởng: +$points điểm'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Về trang chủ'),
          ),
          if (_currentLevel < GameData.ghiNhoLevels.length - 1)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _currentLevel++;
                  _score += points;
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
    final level = GameData.ghiNhoLevels[_currentLevel];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Trò Chơi Ghi Nhớ'),
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
                    colors: [Colors.purple.shade400, Colors.purple.shade600],
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
              // Score
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12 * scaleX),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(12 * scaleX),
                ),
                child: Text(
                  'Điểm: $_score',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18 * scaleX,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ),
              SizedBox(height: 20 * scaleX),
              // Cards Grid
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10 * scaleX,
                    mainAxisSpacing: 10 * scaleX,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: _cards.length,
                  itemBuilder: (context, index) {
                    final card = _cards[index];
                    final parts = card.split(':');
                    final isFormula = parts[0] == 'F';
                    final value = parts[1];

                    return GestureDetector(
                      onTap: () => _flipCard(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: _matched[index]
                              ? Colors.green
                              : _flipped[index]
                                  ? Colors.purple.shade100
                                  : Colors.purple,
                          borderRadius: BorderRadius.circular(12 * scaleX),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: _flipped[index] || _matched[index]
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      isFormula ? Icons.science : Icons.label,
                                      color: _matched[index] ? Colors.white : Colors.purple,
                                      size: 20 * scaleX,
                                    ),
                                    SizedBox(height: 4 * scaleX),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 4 * scaleX),
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          fontSize: 11 * scaleX,
                                          fontWeight: FontWeight.bold,
                                          color: _matched[index] ? Colors.white : Colors.purple,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                )
                              : Icon(
                                  Icons.question_mark,
                                  color: Colors.white,
                                  size: 30 * scaleX,
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
