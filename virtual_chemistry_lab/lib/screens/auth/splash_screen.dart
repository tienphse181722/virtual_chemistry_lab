import 'package:flutter/material.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';
import 'package:virtual_chemistry_lab/screens/auth/login_screen.dart';

/// SCR-001: Splash Screen - Loading screen
/// Updated logo size to match design specs
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      // Always go to login screen, don't auto-login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = size.width / 440;
    
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo circle with ChemLearn logo - Optimized
            SizedBox(
              width: 180 * scale,
              height: 180 * scale,
              child: Image.asset(
                'assets/images/chemlearn_logo.png',
                fit: BoxFit.contain,
                cacheWidth: 360, // 2x for better quality
                cacheHeight: 360,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to icon if image not found
                  return Center(
                    child: Icon(
                      Icons.science_outlined,
                      size: 140 * scale,
                      color: AppColors.primary,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 40 * scale),
            Text(
              'ChemLearn',
              style: TextStyle(
                fontSize: 40 * scale,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 200 * scale),
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 18 * scale,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
