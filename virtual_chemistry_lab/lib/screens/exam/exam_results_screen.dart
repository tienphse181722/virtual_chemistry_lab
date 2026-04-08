import 'package:flutter/material.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';

class ExamResultsScreen extends StatelessWidget {
  final String examName;
  final Color color;
  final Map<String, dynamic> result;
  final List<Map<String, dynamic>> examQuestions;
  final List<int?> userAnswers;

  const ExamResultsScreen({
    super.key,
    required this.examName,
    required this.color,
    required this.result,
    required this.examQuestions,
    required this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final scaleX = width / 440;

    final correctCount = result['correctCount'] as int;
    final totalQuestions = result['totalQuestions'] as int;
    final percentage = result['percentage'] as double;
    final score = result['score'] as double;
    final grade = result['grade'] as String;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: color,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Kết quả',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18 * scaleX,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Score summary
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(32 * scaleX),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withOpacity(0.8), color],
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    score >= 8 ? Icons.emoji_events : score >= 5 ? Icons.thumb_up : Icons.refresh,
                    size: 80 * scaleX,
                    color: Colors.white,
                  ),
                  SizedBox(height: 16 * scaleX),
                  Text(
                    grade,
                    style: TextStyle(
                      fontSize: 32 * scaleX,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8 * scaleX),
                  Text(
                    'Điểm: ${score.toStringAsFixed(2)}/10',
                    style: TextStyle(
                      fontSize: 24 * scaleX,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16 * scaleX),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20 * scaleX, vertical: 12 * scaleX),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12 * scaleX),
                    ),
                    child: Text(
                      'Đúng $correctCount/$totalQuestions câu (${percentage.toStringAsFixed(1)}%)',
                      style: TextStyle(
                        fontSize: 16 * scaleX,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Statistics
            Container(
              margin: EdgeInsets.all(16 * scaleX),
              padding: EdgeInsets.all(20 * scaleX),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15 * scaleX),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat('Đúng', correctCount.toString(), Colors.green, scaleX),
                  _buildStat('Sai', (totalQuestions - correctCount).toString(), Colors.red, scaleX),
                  _buildStat('Tổng', totalQuestions.toString(), color, scaleX),
                ],
              ),
            ),

            // Review answers section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: Row(
                children: [
                  Icon(Icons.list_alt, color: color, size: 24 * scaleX),
                  SizedBox(width: 8 * scaleX),
                  Text(
                    'Chi tiết đáp án',
                    style: TextStyle(
                      fontSize: 18 * scaleX,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16 * scaleX),

            // Answer details
            ...List.generate(
              examQuestions.length,
              (index) => _buildAnswerCard(
                index,
                examQuestions[index],
                userAnswers[index],
                scaleX,
              ),
            ),

            SizedBox(height: 20 * scaleX),

            // Action buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scaleX),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        padding: EdgeInsets.symmetric(vertical: 16 * scaleX),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12 * scaleX),
                        ),
                      ),
                      child: Text(
                        'Quay lại',
                        style: TextStyle(
                          fontSize: 16 * scaleX,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12 * scaleX),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Could navigate to exam screen again to retake
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16 * scaleX),
                        side: BorderSide(color: color),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12 * scaleX),
                        ),
                      ),
                      child: Text(
                        'Làm lại',
                        style: TextStyle(
                          fontSize: 16 * scaleX,
                          color: color,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32 * scaleX),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value, Color color, double scale) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 32 * scale,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4 * scale),
        Text(
          label,
          style: TextStyle(
            fontSize: 14 * scale,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildAnswerCard(
    int index,
    Map<String, dynamic> question,
    int? userAnswer,
    double scale,
  ) {
    final correctAnswer = question['correctAnswer'] as int;
    final isCorrect = userAnswer == correctAnswer;
    final options = question['options'] as List;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 8 * scale),
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15 * scale),
        border: Border.all(
          color: isCorrect ? Colors.green.shade200 : Colors.red.shade200,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question header
          Row(
            children: [
              Container(
                width: 32 * scale,
                height: 32 * scale,
                decoration: BoxDecoration(
                  color: isCorrect ? Colors.green : Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontSize: 16 * scale,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12 * scale),
              Expanded(
                child: Text(
                  isCorrect ? 'Đúng' : 'Sai',
                  style: TextStyle(
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.bold,
                    color: isCorrect ? Colors.green : Colors.red,
                  ),
                ),
              ),
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect ? Colors.green : Colors.red,
                size: 24 * scale,
              ),
            ],
          ),

          SizedBox(height: 12 * scale),

          // Question text
          Text(
            question['question'],
            style: TextStyle(
              fontSize: 15 * scale,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),

          SizedBox(height: 12 * scale),

          // User answer
          if (userAnswer != null)
            Container(
              padding: EdgeInsets.all(12 * scale),
              decoration: BoxDecoration(
                color: isCorrect ? Colors.green.shade50 : Colors.red.shade50,
                borderRadius: BorderRadius.circular(10 * scale),
              ),
              child: Row(
                children: [
                  Text(
                    'Bạn chọn: ',
                    style: TextStyle(
                      fontSize: 14 * scale,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      options[userAnswer],
                      style: TextStyle(
                        fontSize: 14 * scale,
                        fontWeight: FontWeight.w600,
                        color: isCorrect ? Colors.green.shade700 : Colors.red.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          if (userAnswer == null)
            Container(
              padding: EdgeInsets.all(12 * scale),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10 * scale),
              ),
              child: Text(
                'Bạn chưa trả lời',
                style: TextStyle(
                  fontSize: 14 * scale,
                  color: AppColors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

          SizedBox(height: 8 * scale),

          // Correct answer
          if (!isCorrect)
            Container(
              padding: EdgeInsets.all(12 * scale),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(10 * scale),
              ),
              child: Row(
                children: [
                  Text(
                    'Đáp án đúng: ',
                    style: TextStyle(
                      fontSize: 14 * scale,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      options[correctAnswer],
                      style: TextStyle(
                        fontSize: 14 * scale,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          SizedBox(height: 12 * scale),

          // Explanation
          Container(
            padding: EdgeInsets.all(12 * scale),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10 * scale),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lightbulb_outline, color: Colors.blue.shade700, size: 20 * scale),
                SizedBox(width: 8 * scale),
                Expanded(
                  child: Text(
                    question['explanation'],
                    style: TextStyle(
                      fontSize: 13 * scale,
                      color: Colors.blue.shade900,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
