import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';
import 'package:virtual_chemistry_lab/data/game_data.dart';
import 'package:virtual_chemistry_lab/providers/auth_provider.dart';
import 'package:virtual_chemistry_lab/providers/progress_provider.dart';

class XayDungPhanTuScreen extends StatefulWidget {
  const XayDungPhanTuScreen({super.key});

  @override
  State<XayDungPhanTuScreen> createState() => _XayDungPhanTuScreenState();
}

class _XayDungPhanTuScreenState extends State<XayDungPhanTuScreen> {
  int _currentLevel = 0;
  int _currentMolecule = 0;
  int _score = 0;
  List<String> _placedAtoms = [];
  List<String> _availableAtoms = [];

  @override
  void initState() {
    super.initState();
    _startLevel();
  }

  void _startLevel() {
    final level = GameData.xayDungPhanTuLevels[_currentLevel];
    final molecules = level['molecules'] as List;
    final molecule = molecules[_currentMolecule];
    
    setState(() {
      _placedAtoms = [];
      _availableAtoms = List<String>.from(molecule['atoms'] as List);
    });
  }

  void _placeAtom(String atom) {
    setState(() {
      _placedAtoms.add(atom);
      _availableAtoms.remove(atom);
    });
  }

  void _removeAtom(int index) {
    setState(() {
      _availableAtoms.add(_placedAtoms[index]);
      _placedAtoms.removeAt(index);
    });
  }

  void _checkAnswer() {
    final level = GameData.xayDungPhanTuLevels[_currentLevel];
    final molecules = level['molecules'] as List;
    final molecule = molecules[_currentMolecule];
    final correctAtoms = List<String>.from(molecule['atoms'] as List);
    
    final placedSorted = List<String>.from(_placedAtoms)..sort();
    final correctSorted = List<String>.from(correctAtoms)..sort();
    
    if (placedSorted.toString() == correctSorted.toString()) {
      final points = molecule['points'] as int;
      setState(() => _score += points);
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('🎉 Chính xác!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Bạn đã tạo đúng: ${molecule['name']}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Công thức: ${molecule['formula']}'),
              const SizedBox(height: 8),
              Text(
                '+$points điểm',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (_currentMolecule < molecules.length - 1) {
                  setState(() => _currentMolecule++);
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
          title: const Text('❌ Chưa đúng'),
          content: const Text('Hãy thử lại! Kiểm tra số lượng và loại nguyên tử.'),
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
        'xay_dung_phan_tu_level_${_currentLevel + 1}',
        _score,
      );
    }
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('🏆 Hoàn thành Level!'),
        content: Text('Tổng điểm: $_score\nBạn đã hoàn thành tất cả phân tử!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Về trang chủ'),
          ),
          if (_currentLevel < GameData.xayDungPhanTuLevels.length - 1)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _currentLevel++;
                  _currentMolecule = 0;
                });
                _startLevel();
              },
              child: const Text('Level tiếp theo'),
            ),
        ],
      ),
    );
  }

  Color _getAtomColor(String atom) {
    if (atom.contains('H')) return Colors.blue.shade400;
    if (atom.contains('O')) return Colors.red.shade400;
    if (atom.contains('C')) return Colors.grey.shade700;
    if (atom.contains('N')) return Colors.lightBlue.shade400;
    if (atom.contains('Cl')) return Colors.green.shade600;
    if (atom.contains('Na') || atom.contains('K') || atom.contains('Ca') || 
        atom.contains('Mg') || atom.contains('Al')) return Colors.orange.shade400;
    return Colors.teal;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaleX = size.width / 440;
    final level = GameData.xayDungPhanTuLevels[_currentLevel];
    final molecules = level['molecules'] as List;
    final molecule = molecules[_currentMolecule];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Xây Dựng Phân Tử'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12 * scaleX),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal.shade400, Colors.teal.shade600],
                ),
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
            
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20 * scaleX),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Phân tử ${_currentMolecule + 1}/${molecules.length}',
                          style: TextStyle(fontSize: 16 * scaleX, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12 * scaleX, vertical: 6 * scaleX),
                          decoration: BoxDecoration(
                            color: Colors.teal,
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
                    
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16 * scaleX),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.teal.shade50, Colors.teal.shade100],
                        ),
                        borderRadius: BorderRadius.circular(12 * scaleX),
                        border: Border.all(color: Colors.teal.shade300, width: 2),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.science, color: Colors.teal, size: 24 * scaleX),
                              SizedBox(width: 8 * scaleX),
                              Flexible(
                                child: Text(
                                  'Tạo phân tử: ${molecule['name']}',
                                  style: TextStyle(
                                    fontSize: 18 * scaleX,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal.shade800,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8 * scaleX),
                          Text(
                            'Công thức: ${molecule['formula']}',
                            style: TextStyle(
                              fontSize: 16 * scaleX,
                              color: Colors.teal.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25 * scaleX),
                    
                    Text(
                      'Khu vực xây dựng:',
                      style: TextStyle(
                        fontSize: 16 * scaleX,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 10 * scaleX),
                    
                    Container(
                      width: double.infinity,
                      constraints: BoxConstraints(minHeight: 140 * scaleX),
                      padding: EdgeInsets.all(16 * scaleX),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12 * scaleX),
                        border: Border.all(color: Colors.teal.shade300, width: 2),
                      ),
                      child: _placedAtoms.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.touch_app, color: Colors.grey, size: 40 * scaleX),
                                  SizedBox(height: 8 * scaleX),
                                  Text(
                                    'Nhấn vào nguyên tử bên dưới\nđể thêm vào đây',
                                    style: TextStyle(
                                      fontSize: 13 * scaleX,
                                      color: Colors.grey.shade600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          : Wrap(
                              spacing: 10 * scaleX,
                              runSpacing: 10 * scaleX,
                              alignment: WrapAlignment.center,
                              children: _placedAtoms.asMap().entries.map((entry) {
                                return GestureDetector(
                                  onTap: () => _removeAtom(entry.key),
                                  child: _buildAtomChip(entry.value, scaleX, true),
                                );
                              }).toList(),
                            ),
                    ),
                    SizedBox(height: 20 * scaleX),
                    
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _placedAtoms.length == (molecule['atoms'] as List).length
                            ? _checkAnswer
                            : null,
                        icon: const Icon(Icons.check_circle, color: Colors.white),
                        label: Text(
                          'Kiểm tra phân tử',
                          style: TextStyle(
                            fontSize: 16 * scaleX,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          disabledBackgroundColor: Colors.grey.shade300,
                          padding: EdgeInsets.symmetric(vertical: 14 * scaleX),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12 * scaleX),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25 * scaleX),
                    
                    Text(
                      'Nguyên tử có sẵn:',
                      style: TextStyle(
                        fontSize: 16 * scaleX,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 10 * scaleX),
                    
                    _availableAtoms.isEmpty
                        ? Container(
                            padding: EdgeInsets.all(20 * scaleX),
                            child: Text(
                              '✓ Đã sử dụng hết nguyên tử',
                              style: TextStyle(
                                fontSize: 14 * scaleX,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Wrap(
                            spacing: 10 * scaleX,
                            runSpacing: 10 * scaleX,
                            alignment: WrapAlignment.center,
                            children: _availableAtoms.map((atom) {
                              return GestureDetector(
                                onTap: () => _placeAtom(atom),
                                child: _buildAtomChip(atom, scaleX, false),
                              );
                            }).toList(),
                          ),
                    SizedBox(height: 20 * scaleX),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAtomChip(String atom, double scale, bool placed) {
    final color = _getAtomColor(atom);
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
      decoration: BoxDecoration(
        color: placed ? color : color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10 * scale),
        border: Border.all(
          color: color,
          width: 2,
        ),
        boxShadow: placed
            ? [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ]
            : [],
      ),
      child: Text(
        atom,
        style: TextStyle(
          fontSize: 18 * scale,
          fontWeight: FontWeight.bold,
          color: placed ? Colors.white : color,
        ),
      ),
    );
  }
}
