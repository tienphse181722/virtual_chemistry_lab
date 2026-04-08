class QuizModel {
  final String id;
  final String title;
  final String description;
  final List<QuizQuestion> questions;
  final int totalPoints;

  QuizModel({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
    required this.totalPoints,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'questions': questions.map((q) => q.toMap()).toList(),
      'totalPoints': totalPoints,
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      questions: (map['questions'] as List)
          .map((q) => QuizQuestion.fromMap(q))
          .toList(),
      totalPoints: map['totalPoints'] ?? 0,
    );
  }
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswer;
  final int points;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.points,
  });

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'options': options,
      'correctAnswer': correctAnswer,
      'points': points,
    };
  }

  factory QuizQuestion.fromMap(Map<String, dynamic> map) {
    return QuizQuestion(
      question: map['question'] ?? '',
      options: List<String>.from(map['options'] ?? []),
      correctAnswer: map['correctAnswer'] ?? 0,
      points: map['points'] ?? 0,
    );
  }
}
