import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;

  User? get user => _user;

  // Signup Function
  Future<String?> signUp(String email, String password) async {
    _user = await _authService.signUp(email, password);
    notifyListeners();
    return _user != null ? "Signup Successful" : "Signup Failed";
  }

  // Login Function
  Future<String?> signIn(String email, String password) async {
    _user = await _authService.signIn(email, password);
    notifyListeners();
    return _user != null ? "Login Successful" : "Login Failed";
  }

  // Logout Function
  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }
}
