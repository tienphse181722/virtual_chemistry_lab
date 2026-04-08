import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtual_chemistry_lab/models/user_model.dart';
import 'package:virtual_chemistry_lab/models/chemical_model.dart';
import 'package:virtual_chemistry_lab/models/element_model.dart';
import 'package:virtual_chemistry_lab/models/experiment_model.dart';
import 'package:virtual_chemistry_lab/models/quiz_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // User operations
  Future<void> createUser(UserModel user) async {
    await _db.collection('users').doc(user.uid).set(user.toMap());
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    }
    return null;
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection('users').doc(uid).update(data);
  }

  // Chemical operations
  Future<List<ChemicalModel>> getChemicals() async {
    final snapshot = await _db.collection('chemicals').get();
    return snapshot.docs.map((doc) => ChemicalModel.fromMap(doc.data())).toList();
  }

  Future<ChemicalModel?> getChemical(String id) async {
    final doc = await _db.collection('chemicals').doc(id).get();
    if (doc.exists) {
      return ChemicalModel.fromMap(doc.data()!);
    }
    return null;
  }

  // Element operations (for Periodic Table)
  Future<List<ElementModel>> getElements() async {
    final snapshot = await _db.collection('chemicals').get();
    return snapshot.docs.map((doc) => ElementModel.fromMap(doc.data())).toList();
  }

  // Experiment operations
  Future<void> saveExperiment(ExperimentModel experiment) async {
    await _db.collection('experiments').add(experiment.toMap());
  }

  Future<List<ExperimentModel>> getUserExperiments(String userId) async {
    final snapshot = await _db
        .collection('experiments')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .get();
    return snapshot.docs.map((doc) => ExperimentModel.fromMap(doc.data())).toList();
  }

  // Quiz operations
  Future<List<QuizModel>> getQuizzes() async {
    final snapshot = await _db.collection('quizzes').get();
    return snapshot.docs.map((doc) => QuizModel.fromMap(doc.data())).toList();
  }

  Future<void> saveQuizResult(String userId, String quizId, int score) async {
    await _db.collection('quiz_results').add({
      'userId': userId,
      'quizId': quizId,
      'score': score,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<List<Map<String, dynamic>>> getUserQuizResults(String userId) async {
    final snapshot = await _db
        .collection('quiz_results')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
