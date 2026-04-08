import 'package:flutter/material.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';

/// Dark Mode Settings Screen
class DarkModeScreen extends StatefulWidget {
  const DarkModeScreen({super.key});

  @override
  State<DarkModeScreen> createState() => _DarkModeScreenState();
}

class _DarkModeScreenState extends State<DarkModeScreen> {
  String _selectedMode = 'light'; // light, dark, system

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
          'Chế độ tối',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20 * scaleX,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20 * scaleX),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chọn giao diện',
                style: TextStyle(
                  fontSize: 18 * scaleX,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 16 * scaleX),
              
              _buildModeItem(
                'light',
                'Sáng',
                'Giao diện sáng',
                Icons.light_mode,
                scaleX,
              ),
              
              _buildModeItem(
                'dark',
                'Tối',
                'Giao diện tối',
                Icons.dark_mode,
                scaleX,
              ),
              
              _buildModeItem(
                'system',
                'Theo hệ thống',
                'Tự động theo cài đặt thiết bị',
                Icons.settings_brightness,
                scaleX,
              ),
              
              SizedBox(height: 24 * scaleX),
              
              Container(
                padding: EdgeInsets.all(16 * scaleX),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12 * scaleX),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.primary,
                      size: 24 * scaleX,
                    ),
                    SizedBox(width: 12 * scaleX),
                    Expanded(
                      child: Text(
                        'Chế độ tối giúp giảm mỏi mắt khi sử dụng trong điều kiện ánh sáng yếu',
                        style: TextStyle(
                          fontSize: 13 * scaleX,
                          color: AppColors.textSecondary,
                        ),
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

  Widget _buildModeItem(String mode, String title, String subtitle, IconData icon, double scale) {
    final isSelected = _selectedMode == mode;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMode = mode;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tính năng chế độ tối đang được phát triển. Hiện tại app chỉ hỗ trợ chế độ sáng.'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.orange,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12 * scale),
        padding: EdgeInsets.all(16 * scale),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12 * scale),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade200,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50 * scale,
              height: 50 * scale,
              decoration: BoxDecoration(
                color: isSelected 
                    ? AppColors.primary.withOpacity(0.2) 
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12 * scale),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.primary : Colors.grey.shade600,
                size: 28 * scale,
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
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                      color: isSelected ? AppColors.primary : AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4 * scale),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13 * scale,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: 24 * scale,
              ),
          ],
        ),
      ),
    );
  }
}
