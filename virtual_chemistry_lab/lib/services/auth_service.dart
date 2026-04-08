import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Email & Password Sign Up
  Future<UserCredential?> signUpWithEmail(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Sign up error: $e');
      rethrow;
    }
  }

  // Email & Password Sign In
  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Sign in error: $e');
      rethrow;
    }
  }

  // Google Sign In - Simple and reliable
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Sign out first to show account picker
      await _googleSignIn.signOut();
      
      // Open browser/account picker
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        return null; // User cancelled
      }

      // Get auth credentials
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print('Google sign in error: $e');
      rethrow;
    }
  }

  // Facebook Sign In via Firebase OAuth (opens browser like Google)
  Future<UserCredential?> signInWithFacebook() async {
    try {
      // Create Facebook provider
      final facebookProvider = FacebookAuthProvider();
      
      // Add scopes
      facebookProvider.addScope('email');
      facebookProvider.addScope('public_profile');
      
      // Sign in with popup/redirect (opens browser)
      return await _auth.signInWithProvider(facebookProvider);
    } on FirebaseAuthException catch (e) {
      print('Facebook sign in error: ${e.code} - ${e.message}');
      
      // If Facebook not configured, show helpful message
      if (e.code == 'channel-error' || e.code == 'invalid-credential') {
        print('Facebook login not configured. Please enable Facebook provider in Firebase Console.');
      }
      
      return null;
    } catch (e) {
      print('Facebook sign in error: $e');
      return null;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print('Sign out error: $e');
      await _auth.signOut();
    }
  }

  // Reset Password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Reset password error: $e');
      rethrow;
    }
  }
}
