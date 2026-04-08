import 'dart:async';
import 'package:flutter/material.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';
import 'package:virtual_chemistry_lab/data/exam_data.dart';
import 'package:virtual_chemistry_lab/screens/exam/exam_results_screen.dart';

class ExamScreen extends StatefulWidget {
  final String examName;
  final Color color;
  final int timeLimit; // in minutes

  const ExamScreen({
    super.key,
    required this.examName,
    required this.color,
    required this.timeLimit,
  });

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  late List<Map<String, dynamic>> _examQuestions;
  late List<int?> _selectedAnswers;
  int _currentQuestionIndex = 0;
  late Timer _timer;
  late int _remainingSeconds;
  bool _isSubmitted = false;

  @override
  void initState() {
    super.initState();
    _examQuestions = ExamData.getExamByName(widget.examName);
    _selectedAnswers = List.filled(_examQuestions.length, null);
    _remainingSeconds = widget.timeLimit * 60;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _submitExam();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _submitExam() {
    if (_isSubmitted) return;
    
    _timer.cancel();
    setState(() {
      _isSubmitted = true;
    });

    final result = ExamData.calculateScore(_selectedAnswers, _examQuestions);
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ExamResultsScreen(
          examName: widget.examName,
          color: widget.color,
          result: result,
          examQuestions: _examQuestions,
          userAnswers: _selectedAnswers,
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final scaleX = width / 440;

    final question = _examQuestions[_currentQuestionIndex];

    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Thoát bài thi?'),
            content: const Text('Bài làm của bạn sẽ không được lưu.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Hủy'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Thoát'),
              ),
            ],
          ),
        );
        return shouldExit ?? false;
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: widget.color,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () async {
              final shouldExit = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Thoát bài thi?'),
                  content: const Text('Bài làm của bạn sẽ không được lưu.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Hủy'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Thoát'),
                    ),
                  ],
                ),
              );
              if (shouldExit == true && mounted) {
                Navigator.pop(context);
              }
            },
          ),
          title: Text(
            widget.examName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18 * scaleX,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 16 * scaleX),
              padding: EdgeInsets.symmetric(horizontal: 12 * scaleX, vertical: 6 * scaleX),
              decoration: BoxDecoration(
                color: _remainingSeconds < 300 ? Colors.red : Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8 * scaleX),
              ),
              child: Row(
                children: [
                  Icon(Icons.timer, color: Colors.white, size: 18 * scaleX),
                  SizedBox(width: 4 * scaleX),
                  Text(
                    _formatTime(_remainingSeconds),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16 * scaleX,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            // Progress bar
            Container(
              padding: EdgeInsets.all(16 * scaleX),
              color: widget.color.withOpacity(0.1),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Câu ${_currentQuestionIndex + 1}/${_examQuestions.length}',
                        style: TextStyle(
                          fontSize: 16 * scaleX,
                          fontWeight: FontWeight.bold,
                          color: widget.color,
                        ),
                      ),
                      Text(
                        '${((_currentQuestionIndex + 1) / _examQuestions.length * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 14 * scaleX,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8 * scaleX),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10 * scaleX),
                    child: LinearProgressIndicator(
                      value: (_currentQuestionIndex + 1) / _examQuestions.length,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(widget.color),
                      minHeight: 8 * scaleX,
                    ),
                  ),
                ],
              ),
            ),

            // Question content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20 * scaleX),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20 * scaleX),
                      decoration: BoxDecoration(
                        color: widget.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15 * scaleX),
                      ),
                      child: Text(
                        question['question'],
                        style: TextStyle(
                          fontSize: 18 * scaleX,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),

                    SizedBox(height: 24 * scaleX),

                    // Options
                    ...List.generate(
                      (question['options'] as List).length,
                      (index) => _buildOption(
                        question['options'][index],
                        index,
                        scaleX,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Navigation buttons
            Container(
              padding: EdgeInsets.all(16 * scaleX),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
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
                          padding: EdgeInsets.symmetric(vertical: 16 * scaleX),
                          side: BorderSide(color: widget.color),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12 * scaleX),
                          ),
                        ),
                        child: Text(
                          'Câu trước',
                          style: TextStyle(
                            fontSize: 16 * scaleX,
                            color: widget.color,
                          ),
                        ),
                      ),
                    ),
                  if (_currentQuestionIndex > 0) SizedBox(width: 16 * scaleX),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentQuestionIndex < _examQuestions.length - 1) {
                          setState(() {
                            _currentQuestionIndex++;
                          });
                        } else {
                          _showSubmitDialog();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.color,
                        padding: EdgeInsets.symmetric(vertical: 16 * scaleX),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12 * scaleX),
                        ),
                      ),
                      child: Text(
                        _currentQuestionIndex < _examQuestions.length - 1
                            ? 'Câu tiếp theo'
                            : 'Nộp bài',
                        style: TextStyle(
                          fontSize: 16 * scaleX,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String option, int index, double scale) {
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

  void _showSubmitDialog() {
    final unansweredCount = _selectedAnswers.where((answer) => answer == null).length;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nộp bài thi?'),
        content: Text(
          unansweredCount > 0
              ? 'Bạn còn $unansweredCount câu chưa trả lời. Bạn có chắc muốn nộp bài?'
              : 'Bạn đã hoàn thành tất cả câu hỏi. Nộp bài ngay?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _submitExam();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.color,
            ),
            child: const Text('Nộp bài'),
          ),
        ],
      ),
    );
  }
}
