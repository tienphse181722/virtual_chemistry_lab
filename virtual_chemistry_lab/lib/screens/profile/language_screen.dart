import 'package:flutter/material.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';

/// Language Selection Screen
class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = 'vi'; // Default Vietnamese

  final List<Map<String, String>> _languages = [
    {'code': 'vi', 'name': 'Tiếng Việt', 'flag': '🇻🇳'},
    {'code': 'en', 'name': 'English', 'flag': '🇬🇧'},
  ];

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
          'Ngôn ngữ',
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
                'Chọn ngôn ngữ',
                style: TextStyle(
                  fontSize: 18 * scaleX,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 16 * scaleX),
              ..._languages.map((lang) => _buildLanguageItem(
                    lang['code']!,
                    lang['name']!,
                    lang['flag']!,
                    scaleX,
                  )),
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
                        'Ứng dụng sẽ khởi động lại để áp dụng ngôn ngữ mới',
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

  Widget _buildLanguageItem(String code, String name, String flag, double scale) {
    final isSelected = _selectedLanguage == code;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLanguage = code;
        });
        // Show coming soon message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tính năng đổi ngôn ngữ đang được phát triển. Hiện tại app chỉ hỗ trợ Tiếng Việt.'),
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
            Text(
              flag,
              style: TextStyle(fontSize: 32 * scale),
            ),
            SizedBox(width: 16 * scale),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 16 * scale,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                ),
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
