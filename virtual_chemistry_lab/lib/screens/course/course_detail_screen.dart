import 'package:flutter/material.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';
import 'package:virtual_chemistry_lab/screens/course/periodic_table_screen.dart';
import 'package:virtual_chemistry_lab/screens/course/ion_recognition_screen.dart';
import 'package:virtual_chemistry_lab/screens/course/lesson_detail_screen.dart';
import 'package:virtual_chemistry_lab/screens/exam/exam_screen.dart';

class CourseDetailScreen extends StatelessWidget {
  final String courseName;
  final IconData icon;
  final Color color;
  final int progress;
  final int lessons;

  const CourseDetailScreen({
    super.key,
    required this.courseName,
    required this.icon,
    required this.color,
    required this.progress,
    required this.lessons,
  });

  @override
  Widget build(BuildContext context) {
    // Special screens for specific courses
    if (courseName == 'Bảng tuần hoàn') {
      return const PeriodicTableScreen();
    }
    if (courseName == 'Nhận biết ion') {
      return const IonRecognitionScreen();
    }

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final scaleX = width / 440;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20 * scaleX),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color.withOpacity(0.8),
                    color,
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back, color: Colors.white, size: 24 * scaleX),
                      ),
                      Expanded(
                        child: Text(
                          courseName,
                          style: TextStyle(
                            fontSize: 20 * scaleX,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 40 * scaleX),
                    ],
                  ),
                  SizedBox(height: 20 * scaleX),
                  Container(
                    width: 80 * scaleX,
                    height: 80 * scaleX,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20 * scaleX),
                    ),
                    child: Icon(icon, size: 40 * scaleX, color: color),
                  ),
                  SizedBox(height: 16 * scaleX),
                  Text(
                    _getCourseDescription(),
                    style: TextStyle(
                      fontSize: 14 * scaleX,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20 * scaleX),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildHeaderStat('$lessons', 'Chủ đề', scaleX),
                      _buildHeaderStat('$progress%', 'Hoàn thành', scaleX),
                      _buildHeaderStat('${lessons * 20}', 'Điểm', scaleX),
                    ],
                  ),
                ],
              ),
            ),

            // Content based on course type
            Expanded(
              child: _buildCourseContent(context, scaleX),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseContent(BuildContext context, double scale) {
    switch (courseName) {
      case 'Hóa học cơ bản':
        return _buildBasicChemistryContent(scale);
      case 'Phản ứng hóa học':
        return _buildReactionContent(scale);
      case 'Hóa hữu cơ':
        return _buildOrganicChemistryContent(scale);
      case 'Tổng hợp kiến thức':
        return _buildComprehensiveContent(scale);
      default:
        return _buildDefaultContent(scale);
    }
  }

  Widget _buildBasicChemistryContent(double scale) {
    final topics = [
      {'title': 'Nguyên tử & Phân tử', 'icon': Icons.blur_on, 'color': Colors.blue, 'type': 'Quiz'},
      {'title': 'Liên kết hóa học', 'icon': Icons.link, 'color': Colors.purple, 'type': 'Quiz'},
      {'title': 'Phản ứng cơ bản', 'icon': Icons.science, 'color': Colors.orange, 'type': 'Quiz'},
      {'title': 'Mol & Tính toán', 'icon': Icons.calculate, 'color': Colors.green, 'type': 'Quiz'},
      {'title': 'Dung dịch', 'icon': Icons.water_drop, 'color': Colors.cyan, 'type': 'Quiz'},
      {'title': 'Axit & Bazơ', 'icon': Icons.science_outlined, 'color': Colors.red, 'type': 'Quiz'},
    ];

    return ListView.builder(
      padding: EdgeInsets.all(20 * scale),
      itemCount: topics.length,
      itemBuilder: (context, index) {
        final topic = topics[index];
        return _buildTopicCard(
          context,
          topic['title'] as String,
          topic['icon'] as IconData,
          topic['color'] as Color,
          topic['type'] as String,
          index < 4,
          scale,
        );
      },
    );
  }

  Widget _buildReactionContent(double scale) {
    final reactions = [
      {'title': 'Phản ứng tổng hợp', 'icon': Icons.add_circle, 'color': Colors.blue, 'example': 'H₂ + O₂ → H₂O'},
      {'title': 'Phản ứng phân hủy', 'icon': Icons.call_split, 'color': Colors.orange, 'example': '2H₂O → 2H₂ + O₂'},
      {'title': 'Phản ứng thế', 'icon': Icons.swap_horiz, 'color': Colors.purple, 'example': 'Zn + HCl → ZnCl₂ + H₂'},
      {'title': 'Phản ứng trao đổi', 'icon': Icons.sync_alt, 'color': Colors.green, 'example': 'NaCl + AgNO₃ → AgCl + NaNO₃'},
      {'title': 'Oxi hóa khử', 'icon': Icons.autorenew, 'color': Colors.red, 'example': 'Fe + CuSO₄ → FeSO₄ + Cu'},
    ];

    return ListView.builder(
      padding: EdgeInsets.all(20 * scale),
      itemCount: reactions.length,
      itemBuilder: (context, index) {
        final reaction = reactions[index];
        return _buildReactionCard(
          context,
          reaction['title'] as String,
          reaction['icon'] as IconData,
          reaction['color'] as Color,
          reaction['example'] as String,
          index < 3,
          scale,
        );
      },
    );
  }

  Widget _buildOrganicChemistryContent(double scale) {
    final topics = [
      {'title': 'Hiđrocacbon', 'icon': Icons.hub, 'color': Colors.blue, 'molecules': '5 phân tử'},
      {'title': 'Ancol & Phenol', 'icon': Icons.water, 'color': Colors.cyan, 'molecules': '4 phân tử'},
      {'title': 'Anđehit & Xeton', 'icon': Icons.science, 'color': Colors.orange, 'molecules': '3 phân tử'},
      {'title': 'Axit cacboxylic', 'icon': Icons.local_fire_department, 'color': Colors.red, 'molecules': '4 phân tử'},
      {'title': 'Este & Lipit', 'icon': Icons.bubble_chart, 'color': Colors.purple, 'molecules': '3 phân tử'},
      {'title': 'Cacbohiđrat', 'icon': Icons.grain, 'color': Colors.green, 'molecules': '4 phân tử'},
    ];

    return ListView.builder(
      padding: EdgeInsets.all(20 * scale),
      itemCount: topics.length,
      itemBuilder: (context, index) {
        final topic = topics[index];
        return _buildMoleculeCard(
          context,
          topic['title'] as String,
          topic['icon'] as IconData,
          topic['color'] as Color,
          topic['molecules'] as String,
          index < 2,
          scale,
        );
      },
    );
  }

  Widget _buildComprehensiveContent(double scale) {
    final tests = [
      {'title': 'Đề thi thử số 1', 'icon': Icons.quiz, 'color': Colors.blue, 'questions': '40 câu', 'time': '45 phút'},
      {'title': 'Đề thi thử số 2', 'icon': Icons.quiz, 'color': Colors.purple, 'questions': '40 câu', 'time': '45 phút'},
      {'title': 'Đề thi thử số 3', 'icon': Icons.quiz, 'color': Colors.orange, 'questions': '40 câu', 'time': '45 phút'},
      {'title': 'Chuyên đề nâng cao', 'icon': Icons.school, 'color': Colors.green, 'questions': '30 câu', 'time': '35 phút'},
      {'title': 'Tổng ôn tập', 'icon': Icons.book, 'color': Colors.red, 'questions': '50 câu', 'time': '60 phút'},
    ];

    return ListView.builder(
      padding: EdgeInsets.all(20 * scale),
      itemCount: tests.length,
      itemBuilder: (context, index) {
        final test = tests[index];
        return _buildTestCard(
          context,
          test['title'] as String,
          test['icon'] as IconData,
          test['color'] as Color,
          test['questions'] as String,
          test['time'] as String,
          index < 1,
          scale,
        );
      },
    );
  }

  Widget _buildDefaultContent(double scale) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.construction, size: 80 * scale, color: Colors.grey),
          SizedBox(height: 16 * scale),
          Text(
            'Nội dung đang được phát triển',
            style: TextStyle(
              fontSize: 16 * scale,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicCard(BuildContext context, String title, IconData icon, Color color, String type, bool isUnlocked, double scale) {
    return GestureDetector(
      onTap: isUnlocked
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LessonDetailScreen(
                    title: title,
                    type: type,
                    color: color,
                    icon: icon,
                  ),
                ),
              );
            }
          : null,
      child: Container(
        margin: EdgeInsets.only(bottom: 16 * scale),
        padding: EdgeInsets.all(16 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15 * scale),
          border: Border.all(color: isUnlocked ? color.withOpacity(0.3) : Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60 * scale,
              height: 60 * scale,
              decoration: BoxDecoration(
                color: isUnlocked ? color.withOpacity(0.15) : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12 * scale),
              ),
              child: Icon(
                isUnlocked ? icon : Icons.lock,
                color: isUnlocked ? color : Colors.grey,
                size: 30 * scale,
              ),
            ),
            SizedBox(width: 16 * scale),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16 * scale,
                      fontWeight: FontWeight.bold,
                      color: isUnlocked ? AppColors.textPrimary : Colors.grey,
                    ),
                  ),
                  SizedBox(height: 6 * scale),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10 * scale, vertical: 4 * scale),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8 * scale),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        fontSize: 11 * scale,
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.play_circle_filled,
              color: isUnlocked ? color : Colors.grey,
              size: 32 * scale,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReactionCard(BuildContext context, String title, IconData icon, Color color, String example, bool isUnlocked, double scale) {
    return GestureDetector(
      onTap: isUnlocked
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LessonDetailScreen(
                    title: title,
                    type: 'Video + Thí nghiệm',
                    color: color,
                    icon: icon,
                  ),
                ),
              );
            }
          : null,
      child: Container(
        margin: EdgeInsets.only(bottom: 16 * scale),
        padding: EdgeInsets.all(16 * scale),
        decoration: BoxDecoration(
          gradient: isUnlocked
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
                )
              : null,
          color: isUnlocked ? null : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(15 * scale),
          border: Border.all(color: isUnlocked ? color : Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50 * scale,
                  height: 50 * scale,
                  decoration: BoxDecoration(
                    color: isUnlocked ? color.withOpacity(0.2) : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12 * scale),
                  ),
                  child: Icon(
                    isUnlocked ? icon : Icons.lock,
                    color: isUnlocked ? color : Colors.grey,
                    size: 28 * scale,
                  ),
                ),
                SizedBox(width: 12 * scale),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16 * scale,
                      fontWeight: FontWeight.bold,
                      color: isUnlocked ? AppColors.textPrimary : Colors.grey,
                    ),
                  ),
                ),
                if (isUnlocked)
                  Icon(Icons.arrow_forward_ios, color: color, size: 20 * scale),
              ],
            ),
            if (isUnlocked) ...[
              SizedBox(height: 12 * scale),
              Container(
                padding: EdgeInsets.all(12 * scale),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10 * scale),
                ),
                child: Text(
                  example,
                  style: TextStyle(
                    fontSize: 14 * scale,
                    color: AppColors.textPrimary,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMoleculeCard(BuildContext context, String title, IconData icon, Color color, String molecules, bool isUnlocked, double scale) {
    return GestureDetector(
      onTap: isUnlocked
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LessonDetailScreen(
                    title: title,
                    type: 'Mô phỏng 3D',
                    color: color,
                    icon: icon,
                  ),
                ),
              );
            }
          : null,
      child: Container(
        margin: EdgeInsets.only(bottom: 16 * scale),
        padding: EdgeInsets.all(16 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15 * scale),
          border: Border.all(color: isUnlocked ? color.withOpacity(0.3) : Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60 * scale,
              height: 60 * scale,
              decoration: BoxDecoration(
                color: isUnlocked ? color.withOpacity(0.15) : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isUnlocked ? icon : Icons.lock,
                color: isUnlocked ? color : Colors.grey,
                size: 30 * scale,
              ),
            ),
            SizedBox(width: 16 * scale),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16 * scale,
                      fontWeight: FontWeight.bold,
                      color: isUnlocked ? AppColors.textPrimary : Colors.grey,
                    ),
                  ),
                  SizedBox(height: 6 * scale),
                  Row(
                    children: [
                      Icon(Icons.category, size: 14 * scale, color: AppColors.textSecondary),
                      SizedBox(width: 4 * scale),
                      Text(
                        molecules,
                        style: TextStyle(
                          fontSize: 12 * scale,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(8 * scale),
              decoration: BoxDecoration(
                color: isUnlocked ? color.withOpacity(0.1) : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8 * scale),
              ),
              child: Text(
                '3D',
                style: TextStyle(
                  fontSize: 12 * scale,
                  fontWeight: FontWeight.bold,
                  color: isUnlocked ? color : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestCard(BuildContext context, String title, IconData icon, Color color, String questions, String time, bool isUnlocked, double scale) {
    // Extract time limit in minutes
    int timeLimit = 45; // default
    if (title.contains('số 1') || title.contains('số 2') || title.contains('số 3')) {
      timeLimit = 45;
    } else if (title.contains('Chuyên đề')) {
      timeLimit = 35;
    } else if (title.contains('Tổng ôn')) {
      timeLimit = 60;
    }

    return GestureDetector(
      onTap: isUnlocked
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ExamScreen(
                    examName: title,
                    color: color,
                    timeLimit: timeLimit,
                  ),
                ),
              );
            }
          : null,
      child: Container(
        margin: EdgeInsets.only(bottom: 16 * scale),
        padding: EdgeInsets.all(16 * scale),
        decoration: BoxDecoration(
          gradient: isUnlocked
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withOpacity(0.15), color.withOpacity(0.05)],
                )
              : null,
          color: isUnlocked ? null : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(15 * scale),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60 * scale,
              height: 60 * scale,
              decoration: BoxDecoration(
                color: isUnlocked ? color : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12 * scale),
              ),
              child: Icon(
                isUnlocked ? icon : Icons.lock,
                color: Colors.white,
                size: 30 * scale,
              ),
            ),
            SizedBox(width: 16 * scale),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16 * scale,
                      fontWeight: FontWeight.bold,
                      color: isUnlocked ? AppColors.textPrimary : Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8 * scale),
                  Row(
                    children: [
                      Icon(Icons.help_outline, size: 14 * scale, color: AppColors.textSecondary),
                      SizedBox(width: 4 * scale),
                      Text(
                        questions,
                        style: TextStyle(fontSize: 12 * scale, color: AppColors.textSecondary),
                      ),
                      SizedBox(width: 12 * scale),
                      Icon(Icons.access_time, size: 14 * scale, color: AppColors.textSecondary),
                      SizedBox(width: 4 * scale),
                      Text(
                        time,
                        style: TextStyle(fontSize: 12 * scale, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (isUnlocked)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 8 * scale),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8 * scale),
                ),
                child: Text(
                  'Bắt đầu',
                  style: TextStyle(
                    fontSize: 12 * scale,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderStat(String value, String label, double scale) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24 * scale,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4 * scale),
        Text(
          label,
          style: TextStyle(
            fontSize: 12 * scale,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  String _getCourseDescription() {
    switch (courseName) {
      case 'Hóa học cơ bản':
        return 'Khám phá kiến thức nền tảng qua video, quiz và thí nghiệm tương tác';
      case 'Phản ứng hóa học':
        return 'Mô phỏng và thực hành các loại phản ứng hóa học';
      case 'Hóa hữu cơ':
        return 'Xây dựng và khám phá cấu trúc phân tử 3D';
      case 'Tổng hợp kiến thức':
        return 'Luyện thi với đề thi thử và chuyên đề nâng cao';
      default:
        return 'Khóa học hóa học chuyên sâu';
    }
  }
}
