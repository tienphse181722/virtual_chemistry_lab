import 'package:flutter/material.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';

/// Notifications Settings Screen
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _achievementNotifications = true;
  bool _courseReminders = true;
  bool _labUpdates = true;
  bool _gameInvites = false;

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
          'Thông báo',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cài đặt thông báo',
                  style: TextStyle(
                    fontSize: 18 * scaleX,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 16 * scaleX),
                
                _buildNotificationItem(
                  'Thông báo đẩy',
                  'Nhận thông báo trên thiết bị',
                  Icons.notifications_active,
                  _pushNotifications,
                  (value) => setState(() => _pushNotifications = value),
                  scaleX,
                ),
                
                _buildNotificationItem(
                  'Thông báo Email',
                  'Nhận thông báo qua email',
                  Icons.email,
                  _emailNotifications,
                  (value) => setState(() => _emailNotifications = value),
                  scaleX,
                ),
                
                SizedBox(height: 24 * scaleX),
                
                Text(
                  'Loại thông báo',
                  style: TextStyle(
                    fontSize: 18 * scaleX,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 16 * scaleX),
                
                _buildNotificationItem(
                  'Thành tích mới',
                  'Thông báo khi đạt thành tích',
                  Icons.emoji_events,
                  _achievementNotifications,
                  (value) => setState(() => _achievementNotifications = value),
                  scaleX,
                ),
                
                _buildNotificationItem(
                  'Nhắc nhở khóa học',
                  'Nhắc nhở học tập hàng ngày',
                  Icons.school,
                  _courseReminders,
                  (value) => setState(() => _courseReminders = value),
                  scaleX,
                ),
                
                _buildNotificationItem(
                  'Cập nhật thí nghiệm',
                  'Thông báo thí nghiệm mới',
                  Icons.science,
                  _labUpdates,
                  (value) => setState(() => _labUpdates = value),
                  scaleX,
                ),
                
                _buildNotificationItem(
                  'Lời mời chơi game',
                  'Nhận lời mời từ bạn bè',
                  Icons.gamepad,
                  _gameInvites,
                  (value) => setState(() => _gameInvites = value),
                  scaleX,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    Function(bool) onChanged,
    double scale,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12 * scale),
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 40 * scale,
            height: 40 * scale,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10 * scale),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 22 * scale,
            ),
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 2 * scale),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12 * scale,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
