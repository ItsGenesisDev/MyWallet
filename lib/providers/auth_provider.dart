import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  String _email = '';
  String _password = '';

  String get email => _email;
  String get password => _password;

  void setEmail(String email) {
    _email = email;
    notifyListeners(); // Notifica a los widgets que dependen de este estado
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  bool validateCredentials() {
    return _email.isNotEmpty && _password.isNotEmpty;
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> registerWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      return userCredential.user;
    } catch (e) {
      print('Error en el registro: $e');
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      return userCredential.user;
    } catch (e) {
      print('Error en el inicio de sesión: $e');
      return null;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // El usuario canceló el inicio de sesión
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print('Error en el inicio de sesión con Google: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
    print('Error al cerrar sesión: $e');
    }
  }

  User? get currentUser {
    return _firebaseAuth.currentUser;
  }
}
