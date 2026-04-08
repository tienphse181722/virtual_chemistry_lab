import 'package:flutter/material.dart';
import 'package:virtual_chemistry_lab/models/quiz_model.dart';
import 'package:virtual_chemistry_lab/services/firestore_service.dart';

class QuizProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  
  List<QuizModel> _quizzes = [];
  QuizModel? _currentQuiz;
  int _currentQuestionIndex = 0;
  int _score = 0;
  List<int> _userAnswers = [];
  bool _isLoading = false;

  List<QuizModel> get quizzes => _quizzes;
  QuizModel? get currentQuiz => _currentQuiz;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  List<int> get userAnswers => _userAnswers;
  bool get isLoading => _isLoading;
  bool get isQuizCompleted => _currentQuiz != null && 
      _currentQuestionIndex >= _currentQuiz!.questions.length;

  Future<void> loadQuizzes() async {
    _isLoading = true;
    notifyListeners();

    try {
      _quizzes = await _firestoreService.getQuizzes();
    } catch (e) {
      print('Error loading quizzes: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void startQuiz(QuizModel quiz) {
    _currentQuiz = quiz;
    _currentQuestionIndex = 0;
    _score = 0;
    _userAnswers = [];
    notifyListeners();
  }

  void answerQuestion(int answerIndex) {
    if (_currentQuiz == null || isQuizCompleted) return;

    _userAnswers.add(answerIndex);
    
    final currentQuestion = _currentQuiz!.questions[_currentQuestionIndex];
    if (answerIndex == currentQuestion.correctAnswer) {
      _score += currentQuestion.points;
    }

    _currentQuestionIndex++;
    notifyListeners();
  }

  Future<void> submitQuiz(String userId) async {
    if (_currentQuiz == null) return;

    await _firestoreService.saveQuizResult(
      userId,
      _currentQuiz!.id,
      _score,
    );
  }

  void resetQuiz() {
    _currentQuiz = null;
    _currentQuestionIndex = 0;
    _score = 0;
    _userAnswers = [];
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> getUserQuizHistory(String userId) async {
    return await _firestoreService.getUserQuizResults(userId);
  }
}
