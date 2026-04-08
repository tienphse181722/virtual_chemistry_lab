import 'package:flutter/material.dart';

/// SCR-011: Results Screen
/// Hiển thị kết quả thí nghiệm
class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kết Quả')),
      body: const Center(child: Text('Results Screen - TODO')),
    );
  }
}
