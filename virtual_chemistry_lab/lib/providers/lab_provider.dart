import 'package:flutter/material.dart';
import 'package:virtual_chemistry_lab/models/chemical_model.dart';
import 'package:virtual_chemistry_lab/models/experiment_model.dart';
import 'package:virtual_chemistry_lab/services/firestore_service.dart';
import 'package:virtual_chemistry_lab/services/chemistry_engine.dart';

class LabProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  
  List<ChemicalModel> _chemicals = [];
  List<ExperimentModel> _experiments = [];
  ChemicalModel? _selectedChemical1;
  ChemicalModel? _selectedChemical2;
  String _experimentResult = '';
  bool _isLoading = false;

  List<ChemicalModel> get chemicals => _chemicals;
  List<ExperimentModel> get experiments => _experiments;
  ChemicalModel? get selectedChemical1 => _selectedChemical1;
  ChemicalModel? get selectedChemical2 => _selectedChemical2;
  String get experimentResult => _experimentResult;
  bool get isLoading => _isLoading;

  Future<void> loadChemicals() async {
    _isLoading = true;
    notifyListeners();

    try {
      _chemicals = await _firestoreService.getChemicals();
    } catch (e) {
      print('Error loading chemicals: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadUserExperiments(String userId) async {
    try {
      _experiments = await _firestoreService.getUserExperiments(userId);
      notifyListeners();
    } catch (e) {
      print('Error loading experiments: $e');
    }
  }

  void selectChemical1(ChemicalModel chemical) {
    _selectedChemical1 = chemical;
    notifyListeners();
  }

  void selectChemical2(ChemicalModel chemical) {
    _selectedChemical2 = chemical;
    notifyListeners();
  }

  void clearSelection() {
    _selectedChemical1 = null;
    _selectedChemical2 = null;
    _experimentResult = '';
    notifyListeners();
  }

  Future<void> mixChemicals(String userId) async {
    if (_selectedChemical1 == null || _selectedChemical2 == null) return;

    _experimentResult = ChemistryEngine.mixChemicals(
      _selectedChemical1!,
      _selectedChemical2!,
    );

    // Save experiment
    final experiment = ExperimentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      experimentType: 'mix',
      chemicals: [_selectedChemical1!.formula, _selectedChemical2!.formula],
      result: _experimentResult,
      timestamp: DateTime.now(),
    );

    await _firestoreService.saveExperiment(experiment);
    _experiments.insert(0, experiment);
    
    notifyListeners();
  }

  Future<void> burnChemical(String userId, ChemicalModel chemical) async {
    _experimentResult = ChemistryEngine.burnChemical(chemical);

    final experiment = ExperimentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      experimentType: 'burn',
      chemicals: [chemical.formula],
      result: _experimentResult,
      timestamp: DateTime.now(),
    );

    await _firestoreService.saveExperiment(experiment);
    _experiments.insert(0, experiment);
    
    notifyListeners();
  }

  String balanceEquation(String equation) {
    return ChemistryEngine.balanceEquation(equation);
  }

  bool isEquationBalanced(String equation) {
    return ChemistryEngine.isBalanced(equation);
  }

  String getSafetyInfo(ChemicalModel chemical) {
    return ChemistryEngine.getSafetyInfo(chemical);
  }
}
