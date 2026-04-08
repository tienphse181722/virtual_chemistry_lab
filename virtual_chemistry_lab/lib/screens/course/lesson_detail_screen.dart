import 'package:flutter/material.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';
import 'package:virtual_chemistry_lab/data/lesson_content.dart';
import 'package:virtual_chemistry_lab/data/quiz_data.dart';

class LessonDetailScreen extends StatefulWidget {
  final String title;
  final String type;
  final Color color;
  final IconData icon;

  const LessonDetailScreen({
    super.key,
    required this.title,
    required this.type,
    required this.color,
    required this.icon,
  });

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Map<String, dynamic> _lessonContent;
  int _currentQuestionIndex = 0;
  List<int?> _selectedAnswers = [];
  bool _showResults = false;
  late List<Map<String, dynamic>> _quizQuestions;

  @override
  void initState() {
    super.initState();
    
    // Load lesson content
    _lessonContent = LessonContent.getLessonContent(widget.title);
    final sections = _lessonContent['sections'] as List;
    
    // Tab controller: Lý thuyết + Quiz
    _tabController = TabController(length: 2, vsync: this);
    
    // Load quiz questions
    _quizQuestions = QuizData.getQuizByTopic(widget.title);
    _selectedAnswers = List.filled(_quizQuestions.length, null);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final scaleX = width / 440;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: widget.color,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18 * scaleX,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(
              icon: Icon(Icons.book),
              text: 'Lý thuyết',
            ),
            Tab(
              icon: Icon(Icons.quiz),
              text: 'Luyện tập',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTheoryContent(scaleX),
          _buildQuizContent(scaleX),
        ],
      ),
    );
  }

  Widget _buildTheoryContent(double scale) {
    final sections = _lessonContent['sections'] as List;
    
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24 * scale),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [widget.color, widget.color.withOpacity(0.7)],
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 80 * scale,
                  height: 80 * scale,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20 * scale),
                  ),
                  child: Icon(widget.icon, size: 40 * scale, color: widget.color),
                ),
                SizedBox(height: 16 * scale),
                Text(
                  _lessonContent['title'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20 * scale,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Content sections
          ...sections.map((section) => _buildSection(section, scale)).toList(),
          
          SizedBox(height: 20 * scale),
        ],
      ),
    );
  }

  Widget _buildSection(Map<String, dynamic> section, double scale) {
    final level = section['level'] as String;
    final icon = section['icon'] as String;
    final content = section['content'] as List;
    
    Color levelColor;
    if (level.contains('Cơ bản')) {
      levelColor = Colors.green;
    } else if (level.contains('Nâng cao')) {
      levelColor = Colors.orange;
    } else {
      levelColor = Colors.blue;
    }

    return Container(
      margin: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15 * scale),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16 * scale),
            decoration: BoxDecoration(
              color: levelColor.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15 * scale),
                topRight: Radius.circular(15 * scale),
              ),
            ),
            child: Row(
              children: [
                Text(
                  icon,
                  style: TextStyle(fontSize: 24 * scale),
                ),
                SizedBox(width: 12 * scale),
                Text(
                  level,
                  style: TextStyle(
                    fontSize: 18 * scale,
                    fontWeight: FontWeight.bold,
                    color: levelColor,
                  ),
                ),
              ],
            ),
          ),

          // Content items
          Padding(
            padding: EdgeInsets.all(16 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: content.map((item) {
                return Container(
                  margin: EdgeInsets.only(bottom: 20 * scale),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['heading'],
                        style: TextStyle(
                          fontSize: 16 * scale,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 8 * scale),
                      Container(
                        padding: EdgeInsets.all(12 * scale),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(10 * scale),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Text(
                          item['text'],
                          style: TextStyle(
                            fontSize: 14 * scale,
                            color: AppColors.textSecondary,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizContent(double scale) {
    if (_showResults) {
      return _buildQuizResults(scale);
    }

    final question = _quizQuestions[_currentQuestionIndex];
    
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Câu ${_currentQuestionIndex + 1}/${_quizQuestions.length}',
                  style: TextStyle(
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.bold,
                    color: widget.color,
                  ),
                ),
                Text(
                  '${((_currentQuestionIndex + 1) / _quizQuestions.length * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 14 * scale,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8 * scale),
            ClipRRect(
              borderRadius: BorderRadius.circular(10 * scale),
              child: LinearProgressIndicator(
                value: (_currentQuestionIndex + 1) / _quizQuestions.length,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(widget.color),
                minHeight: 8 * scale,
              ),
            ),
            
            SizedBox(height: 32 * scale),
            
            // Question
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20 * scale),
              decoration: BoxDecoration(
                color: widget.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15 * scale),
              ),
              child: Text(
                question['question'],
                style: TextStyle(
                  fontSize: 18 * scale,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            
            SizedBox(height: 24 * scale),
            
            // Options
            ...List.generate(
              (question['options'] as List).length,
              (index) => _buildQuizOption(
                question['options'][index],
                index,
                scale,
              ),
            ),
            
            SizedBox(height: 32 * scale),
            
            // Navigation buttons
            Row(
              children: [
                if (_currentQuestionIndex > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _currentQuestionIndex--;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16 * scale),
                        side: BorderSide(color: widget.color),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12 * scale),
                        ),
                      ),
                      child: Text(
                        'Câu trước',
                        style: TextStyle(
                          fontSize: 16 * scale,
                          color: widget.color,
                        ),
                      ),
                    ),
                  ),
                if (_currentQuestionIndex > 0) SizedBox(width: 16 * scale),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _selectedAnswers[_currentQuestionIndex] != null
                        ? () {
                            if (_currentQuestionIndex < _quizQuestions.length - 1) {
                              setState(() {
                                _currentQuestionIndex++;
                              });
                            } else {
                              setState(() {
                                _showResults = true;
                              });
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.color,
                      padding: EdgeInsets.symmetric(vertical: 16 * scale),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12 * scale),
                      ),
                    ),
                    child: Text(
                      _currentQuestionIndex < _quizQuestions.length - 1
                          ? 'Câu tiếp theo'
                          : 'Hoàn thành',
                      style: TextStyle(
                        fontSize: 16 * scale,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizOption(String option, int index, double scale) {
    final isSelected = _selectedAnswers[_currentQuestionIndex] == index;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAnswers[_currentQuestionIndex] = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12 * scale),
        padding: EdgeInsets.all(16 * scale),
        decoration: BoxDecoration(
          color: isSelected ? widget.color.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12 * scale),
          border: Border.all(
            color: isSelected ? widget.color : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24 * scale,
              height: 24 * scale,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? widget.color : Colors.transparent,
                border: Border.all(
                  color: isSelected ? widget.color : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(Icons.check, color: Colors.white, size: 16 * scale)
                  : null,
            ),
            SizedBox(width: 12 * scale),
            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 15 * scale,
                  color: AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizResults(double scale) {
    int correctCount = 0;
    for (int i = 0; i < _quizQuestions.length; i++) {
      if (_selectedAnswers[i] == _quizQuestions[i]['correctAnswer']) {
        correctCount++;
      }
    }
    
    final percentage = (correctCount / _quizQuestions.length * 100).toInt();
    
    return Padding(
      padding: EdgeInsets.all(20 * scale),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(32 * scale),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [widget.color.withOpacity(0.8), widget.color],
              ),
              borderRadius: BorderRadius.circular(20 * scale),
            ),
            child: Column(
              children: [
                Icon(
                  percentage >= 70 ? Icons.emoji_events : Icons.refresh,
                  size: 80 * scale,
                  color: Colors.white,
                ),
                SizedBox(height: 16 * scale),
                Text(
                  percentage >= 70 ? 'Xuất sắc!' : 'Cố gắng lên!',
                  style: TextStyle(
                    fontSize: 28 * scale,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8 * scale),
                Text(
                  'Bạn đã trả lời đúng $correctCount/${_quizQuestions.length} câu',
                  style: TextStyle(
                    fontSize: 16 * scale,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                SizedBox(height: 16 * scale),
                Text(
                  '$percentage%',
                  style: TextStyle(
                    fontSize: 48 * scale,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 24 * scale),
          
          ElevatedButton(
            onPressed: () {
              setState(() {
                _currentQuestionIndex = 0;
                _selectedAnswers = List.filled(_quizQuestions.length, null);
                _showResults = false;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.color,
              padding: EdgeInsets.symmetric(horizontal: 32 * scale, vertical: 16 * scale),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12 * scale),
              ),
            ),
            child: Text(
              'Làm lại',
              style: TextStyle(
                fontSize: 16 * scale,
                color: Colors.white,
              ),
            ),
          ),
          
          SizedBox(height: 12 * scale),
          
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Quay lại',
              style: TextStyle(
                fontSize: 16 * scale,
                color: widget.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
