class ExperimentModel {
  final String id;
  final String userId;
  final String experimentType; // 'mix', 'burn', 'balance'
  final List<String> chemicals;
  final String result;
  final DateTime timestamp;

  ExperimentModel({
    required this.id,
    required this.userId,
    required this.experimentType,
    required this.chemicals,
    required this.result,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'experimentType': experimentType,
      'chemicals': chemicals,
      'result': result,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory ExperimentModel.fromMap(Map<String, dynamic> map) {
    return ExperimentModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      experimentType: map['experimentType'] ?? '',
      chemicals: List<String>.from(map['chemicals'] ?? []),
      result: map['result'] ?? '',
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
