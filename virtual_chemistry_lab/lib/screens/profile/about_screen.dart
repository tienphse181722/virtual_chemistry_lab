import 'package:flutter/material.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';

/// About App Screen
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final scaleX = width / 440;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Về ứng dụng',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20 * scaleX,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20 * scaleX),
            child: Column(
              children: [
                SizedBox(height: 20 * scaleX),
                
                // App Icon
                Container(
                  width: 120 * scaleX,
                  height: 120 * scaleX,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary.withOpacity(0.8),
                        AppColors.primary,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30 * scaleX),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.science,
                    size: 60 * scaleX,
                    color: Colors.white,
                  ),
                ),
                
                SizedBox(height: 24 * scaleX),
                
                // App Name
                Text(
                  'Virtual Chemistry Lab',
                  style: TextStyle(
                    fontSize: 24 * scaleX,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                SizedBox(height: 8 * scaleX),
                
                // Version
                Text(
                  'Phiên bản 1.0.0',
                  style: TextStyle(
                    fontSize: 14 * scaleX,
                    color: AppColors.textSecondary,
                  ),
                ),
                
                SizedBox(height: 32 * scaleX),
                
                // Description
                Container(
                  padding: EdgeInsets.all(20 * scaleX),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20 * scaleX),
                    border: Border.all(color: Colors.grey.shade200),
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
                      Text(
                        'Về ứng dụng',
                        style: TextStyle(
                          fontSize: 18 * scaleX,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 12 * scaleX),
                      Text(
                        'Virtual Chemistry Lab là ứng dụng học tập hóa học tương tác, giúp học sinh và sinh viên khám phá thế giới hóa học một cách sinh động và thú vị.',
                        style: TextStyle(
                          fontSize: 14 * scaleX,
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 16 * scaleX),
                      Text(
                        'Tính năng nổi bật:',
                        style: TextStyle(
                          fontSize: 16 * scaleX,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 8 * scaleX),
                      _buildFeatureItem('🧪 Phòng thí nghiệm ảo với hơn 100+ thí nghiệm', scaleX),
                      _buildFeatureItem('📚 Khóa học hóa học từ cơ bản đến nâng cao', scaleX),
                      _buildFeatureItem('🎮 Game học tập tương tác và thú vị', scaleX),
                      _buildFeatureItem('🏆 Hệ thống thành tích và bảng xếp hạng', scaleX),
                      _buildFeatureItem('📊 Theo dõi tiến độ học tập chi tiết', scaleX),
                      _buildFeatureItem('🔬 Mô phỏng phản ứng hóa học 3D', scaleX),
                    ],
                  ),
                ),
                
                SizedBox(height: 20 * scaleX),
                
                // Developer Info
                Container(
                  padding: EdgeInsets.all(20 * scaleX),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary.withOpacity(0.1),
                        AppColors.primary.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20 * scaleX),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.code,
                        size: 40 * scaleX,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: 12 * scaleX),
                      Text(
                        'Phát triển bởi',
                        style: TextStyle(
                          fontSize: 14 * scaleX,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 4 * scaleX),
                      Text(
                        'Chemistry Lab Team',
                        style: TextStyle(
                          fontSize: 16 * scaleX,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 16 * scaleX),
                      Text(
                        '© 2024 Virtual Chemistry Lab',
                        style: TextStyle(
                          fontSize: 12 * scaleX,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 20 * scaleX),
                
                // Contact & Support
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildContactButton(
                      Icons.email,
                      'Email',
                      scaleX,
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('support@chemistrylab.com')),
                        );
                      },
                    ),
                    _buildContactButton(
                      Icons.language,
                      'Website',
                      scaleX,
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('www.chemistrylab.com')),
                        );
                      },
                    ),
                    _buildContactButton(
                      Icons.star,
                      'Đánh giá',
                      scaleX,
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Cảm ơn bạn đã đánh giá!')),
                        );
                      },
                    ),
                  ],
                ),
                
                SizedBox(height: 20 * scaleX),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text, double scale) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8 * scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(
              fontSize: 14 * scale,
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14 * scale,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactButton(IconData icon, String label, double scale, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16 * scale, vertical: 12 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12 * scale),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 24 * scale),
            SizedBox(height: 4 * scale),
            Text(
              label,
              style: TextStyle(
                fontSize: 12 * scale,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
