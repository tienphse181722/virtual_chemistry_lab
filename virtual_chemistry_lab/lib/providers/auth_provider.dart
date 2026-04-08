import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:virtual_chemistry_lab/services/auth_service.dart';
import 'package:virtual_chemistry_lab/services/firestore_service.dart';
import 'package:virtual_chemistry_lab/models/user_model.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  
  User? _user;
  UserModel? _userModel;
  bool _isLoading = false;

  User? get user => _user;
  UserModel? get userModel => _userModel;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    // Listen for auth changes but don't auto-set user on init
    // User must explicitly sign in
  }

  // Check if there's a current user session
  Future<bool> checkCurrentUser() async {
    final currentUser = _authService.currentUser;
    if (currentUser != null) {
      _user = currentUser;
      await _loadUserData(currentUser.uid);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> _loadUserData(String uid) async {
    _userModel = await _firestoreService.getUser(uid);
    notifyListeners();
  }

  Future<bool> signInWithEmail(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _authService.signInWithEmail(email, password);
      if (result != null) {
        _user = result.user;
        await _loadUserData(result.user!.uid);
      }
      _isLoading = false;
      notifyListeners();
      return result != null;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow; // Rethrow để UI có thể xử lý lỗi cụ thể
    }
  }

  Future<bool> signUpWithEmail(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _authService.signUpWithEmail(email, password);
      if (result != null) {
        _user = result.user;
        // Create user document in Firestore
        final userModel = UserModel(
          uid: result.user!.uid,
          email: email,
          displayName: result.user!.displayName,
          photoUrl: result.user!.photoURL,
          createdAt: DateTime.now(),
          lastLogin: DateTime.now(),
        );
        await _firestoreService.createUser(userModel);
        await _loadUserData(result.user!.uid);
      }
      _isLoading = false;
      notifyListeners();
      return result != null;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow; // Rethrow để UI có thể xử lý lỗi cụ thể
    }
  }

  Future<bool> signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _authService.signInWithGoogle();
      if (result != null) {
        _user = result.user;
        // Check if user exists, if not create
        final existingUser = await _firestoreService.getUser(result.user!.uid);
        if (existingUser == null) {
          final userModel = UserModel(
            uid: result.user!.uid,
            email: result.user!.email!,
            displayName: result.user!.displayName,
            photoUrl: result.user!.photoURL,
            createdAt: DateTime.now(),
            lastLogin: DateTime.now(),
          );
          await _firestoreService.createUser(userModel);
        }
        await _loadUserData(result.user!.uid);
      }
      _isLoading = false;
      notifyListeners();
      return result != null;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signInWithFacebook() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _authService.signInWithFacebook();
      if (result != null) {
        _user = result.user;
        final existingUser = await _firestoreService.getUser(result.user!.uid);
        if (existingUser == null) {
          final userModel = UserModel(
            uid: result.user!.uid,
            email: result.user!.email ?? '',
            displayName: result.user!.displayName,
            photoUrl: result.user!.photoURL,
            createdAt: DateTime.now(),
            lastLogin: DateTime.now(),
          );
          await _firestoreService.createUser(userModel);
        }
        await _loadUserData(result.user!.uid);
      }
      _isLoading = false;
      notifyListeners();
      return result != null;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    _userModel = null;
    notifyListeners();
  }
}
