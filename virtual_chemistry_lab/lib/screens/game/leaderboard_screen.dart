import 'package:flutter/material.dart';

/// SCR-013: Leaderboard
/// Bảng xếp hạng điểm số
class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bảng Xếp Hạng')),
      body: const Center(child: Text('Leaderboard Screen - TODO')),
    );
  }
}
