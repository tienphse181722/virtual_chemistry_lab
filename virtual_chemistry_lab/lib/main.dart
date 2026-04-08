import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:virtual_chemistry_lab/constants/colors.dart';
import 'package:virtual_chemistry_lab/screens/auth/splash_screen.dart';
import 'package:virtual_chemistry_lab/providers/auth_provider.dart' as app_auth;
import 'package:virtual_chemistry_lab/providers/lab_provider.dart';
import 'package:virtual_chemistry_lab/providers/quiz_provider.dart';
import 'package:virtual_chemistry_lab/providers/progress_provider.dart';
import 'package:virtual_chemistry_lab/firebase_options.dart';
import 'package:virtual_chemistry_lab/utils/scroll_behavior.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // CRITICAL: Sign out completely to prevent auto-login
  try {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.disconnect();
    }
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    print('Sign out error: $e');
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => app_auth.AuthProvider()),
        ChangeNotifierProvider(create: (_) => LabProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => ProgressProvider()),
      ],
      child: MaterialApp(
        title: 'ChemLearn',
        debugShowCheckedModeBanner: false,
        // Apply custom scroll behavior globally to disable overscroll effect
        scrollBehavior: NoOverscrollBehavior(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: AppColors.background,
        ),
        builder: (context, child) {
          // Disable overflow error indicators
          ErrorWidget.builder = (FlutterErrorDetails details) {
            return Container();
          };
          return child!;
        },
        home: const SplashScreen(),
      ),
    );
  }
}

