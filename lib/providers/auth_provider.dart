import 'package:flutter/material.dart';

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
}
